//
//  FISConcreteNetworkImageManager.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteNetworkImageManager.h"
#import "FISSchedulerHelper.h"

typedef void (^FISNetworkImageCompletionBlock)(NSURL *, UIImage *, NSError *);

@interface FISConcreteNetworkImageManager ()

@property (nonatomic) id<FISNetworkHandler> networkHandler;
@property (nonatomic, readonly) NSMutableDictionary *urlCompletionBlocksMap;

@end

@implementation FISConcreteNetworkImageManager

- (instancetype)initWithNetworkHandler:(id<FISNetworkHandler>)networkHandler {
    NSAssert(networkHandler != nil, @"Network handler should not be nil");
    self = [super init];
    if (self) {
        _networkHandler = networkHandler;
        _urlCompletionBlocksMap = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)networkImageForURL:(NSURL *)URL
           completionBlock:(void (^)(NSURL *, UIImage *, NSError *))completionBlock {
    NSAssert(URL != nil, @"URL should not be nil");
    NSAssert(completionBlock != nil, @"completionBlock should not be nil");
    __weak typeof(self) weakSelf = self;
    FISRunOnMainThread(NO, ^{
        [weakSelf __networkImageForURL:URL completionBlock:completionBlock];
    });
}

- (void)__networkImageForURL:(NSURL *)URL
             completionBlock:(void (^)(NSURL *, UIImage *, NSError *))completionBlock {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSAssert(URL != nil, @"URL should not be nil");
    NSAssert(completionBlock != nil, @"completionBlock should not be nil");
    NSArray *allBlocks = [self.urlCompletionBlocksMap objectForKey:URL];
    if (allBlocks == nil) {
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        __weak typeof(self) weakSelf = self;
        [self.networkHandler sendRequest:request
                     withCompletionBlock:^(NSData *data,
                                           NSURLResponse *response,
                                           NSError *error) {
                         UIImage *image = nil;
                         if (error == nil && data != nil) {
                             image = [UIImage imageWithData:data];
                         }
                         
                         FISRunOnMainThread(NO, ^{
                             [weakSelf invokeCompletionBlocksForURL:URL
                                                              image:image
                                                              error:error];
                         });
                     }];
    }
    
    allBlocks = (allBlocks == nil
                 ? @[completionBlock]
                 : [allBlocks arrayByAddingObject:completionBlock]);
    [self.urlCompletionBlocksMap setObject:allBlocks forKey:URL];
}

- (void)invokeCompletionBlocksForURL:(NSURL *)URL
                               image:(UIImage *)image
                               error:(NSError *)error {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSArray *allBlocks = [self.urlCompletionBlocksMap objectForKey:URL];
    if (allBlocks != nil) {
        if (error == nil && image == nil) {
            error = [NSError errorWithDomain:@"FISNtworkImageDomain" code:1 userInfo:nil];
        }
        
        for (FISNetworkImageCompletionBlock completionBlock in allBlocks) {
            completionBlock(URL, image, error);
        }
        [self.urlCompletionBlocksMap removeObjectForKey:URL];
    }
}

@end
