//
//  FISConcreteQueryManager.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteQueryManager.h"
#import "FISSchedulerHelper.h"

static NSString * const BaseURLString = @"https://api.flickr.com/services/rest/";
static NSString * const PhotoSearchMethod = @"flickr.photos.search";

typedef void (^FISFlickrQuerManagerBlock)(NSString *searchText, NSUInteger page, NSError *error, NSArray<NSDictionary *> *imagesJSON);

@interface FISConcreteQueryManager ()

@property (nonatomic) NSString *apiKey;
@property (nonatomic) id<FISNetworkHandler> networkHandler;
@property (nonatomic, readonly) NSMutableDictionary *queryCompletionBlocksMap;

@end

@implementation FISConcreteQueryManager

- (instancetype)initWithNetworkHandler:(id<FISNetworkHandler>)networkHandler
                                apiKey:(NSString *)apiKey {
    NSAssert(apiKey != nil, @"apiKey should not be nil");
    NSAssert(networkHandler != nil, @"Network handler should not be nil");
    self = [super init];
    if (self) {
        _apiKey = apiKey;
        _networkHandler = networkHandler;
        _queryCompletionBlocksMap = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)fetchImagesForSearchText:(NSString *)searchText
                            page:(NSUInteger)page
                 completionBlock:(void (^)(NSString *searchText,
                                           NSUInteger page,
                                           NSError *error,
                                           NSArray<NSDictionary *> *imagesJSON))completionBlock {
    NSAssert(searchText != nil, @"searchTextr should not be nil");
    NSAssert(page > 0, @"Page number should be greater than 0");
    __weak typeof(self) weakSelf = self;
    FISRunOnMainThread(NO, ^{
        [weakSelf __fetchImagesForSearchText:searchText page:page completionBlock:completionBlock];
    });
}

- (void)__fetchImagesForSearchText:(NSString *)searchText
                              page:(NSUInteger)page
                   completionBlock:(void (^)(NSString *searchText,
                                             NSUInteger page,
                                             NSError *error,
                                             NSArray<NSDictionary *> *imagesJSON))completionBlock {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSAssert(searchText != nil, @"searchTextr should not be nil");
    NSAssert(page > 0, @"Page number should be greater than 0");
    NSString *key = [self keyForSearchText:searchText page:page];
    NSArray *allBlocks = [self.queryCompletionBlocksMap objectForKey:key];
    if (allBlocks == nil) {
        NSURLRequest *request = [self requestForSearchText:searchText
                                                      page:page];
        __weak typeof(self) weakSelf = self;
        [self.networkHandler sendRequest:request
                     withCompletionBlock:^(NSData *data,
                                           NSURLResponse *response,
                                           NSError *error) {
                         NSArray *imagesJSON = nil;
                         if (error == nil && data != nil) {
                             imagesJSON = [self imagesJSONFromData:data];
                         }
                         
                         FISRunOnMainThread(NO, ^{
                             [weakSelf invokeCompletionBlocksForSearchText:searchText
                                                                      page:page
                                                                     error:error
                                                                imagesJSON:imagesJSON];
                         });
                     }];
    }
    
    allBlocks = (allBlocks == nil
                 ? @[completionBlock]
                 : [allBlocks arrayByAddingObject:completionBlock]);
    [self.queryCompletionBlocksMap setObject:allBlocks forKey:key];
}

- (NSString *)keyForSearchText:(NSString *)searchText
                          page:(NSUInteger)page {
    NSAssert(searchText != nil, @"searchTextr should not be nil");
    NSAssert(page > 0, @"Page number should be greater than 0");
    return  [NSString stringWithFormat:@"%@-%@", searchText, @(page)];
}

- (NSURLRequest *)requestForSearchText:(NSString *)searchText
                                  page:(NSUInteger)page {
    NSAssert(searchText != nil, @"searchTextr should not be nil");
    NSAssert(page > 0, @"Page number should be greater than 0");
    NSURLComponents *components = [NSURLComponents componentsWithString:BaseURLString];
    NSURLQueryItem *method = [NSURLQueryItem queryItemWithName:@"method" value:PhotoSearchMethod];
    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:self.apiKey];
    NSURLQueryItem *format = [NSURLQueryItem queryItemWithName:@"format" value:@"json"];
    NSURLQueryItem *nojsoncallback = [NSURLQueryItem queryItemWithName:@"nojsoncallback" value:@"1"];
    NSURLQueryItem *safe_search = [NSURLQueryItem queryItemWithName:@"safe_search" value:@"1"];
    NSURLQueryItem *text = [NSURLQueryItem queryItemWithName:@"text" value:searchText];
    NSURLQueryItem *pageNo = [NSURLQueryItem queryItemWithName:@"page" value:[NSString stringWithFormat:@"%@", @(page)]];
    components.queryItems = @[method, apiKey, format, nojsoncallback, safe_search, text, pageNo];
    NSURL *URL = [components URL];
    return [NSMutableURLRequest requestWithURL:URL];
}

- (void)invokeCompletionBlocksForSearchText:(NSString *)searchText
                                       page:(NSUInteger)page
                                      error:(NSError *)error
                                 imagesJSON:(NSArray<NSDictionary *> *)imagesJSON {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSString *key = [self keyForSearchText:searchText page:page];
    NSArray *allBlocks = [self.queryCompletionBlocksMap objectForKey:key];
    if (allBlocks != nil) {
        for (FISFlickrQuerManagerBlock completionBlock in allBlocks) {
            completionBlock(searchText, page, error, imagesJSON);
        }
        
        [self.queryCompletionBlocksMap removeObjectForKey:key];
    }
}

- (NSArray *)imagesJSONFromData:(NSData *)data {
    NSError *error = nil;
    id imagesJSON;
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error == nil) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary *)json;
            imagesJSON = [[jsonDict objectForKey:@"photos"] objectForKey:@"photo"];
            if (imagesJSON != nil
                && ![imagesJSON isKindOfClass:[NSArray class]]) {
                imagesJSON = nil;
            }
        } else {
            NSLog(@"Response JSON is not in dictionary format as expected");
        }
    } else {
        NSLog(@"error in converting to json:%@", error);
    }
    
    return imagesJSON;
}

@end
