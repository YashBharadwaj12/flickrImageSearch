//
//  FISConcreteViewPresenter.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteViewPresenter.h"
#import "FISSchedulerHelper.h"

@interface FISConcreteViewPresenter () <FISImagesInteractorDelegate>

@property (nonatomic, readonly) id<FISImagesInteractor> interactor;
@property (nonatomic, readonly) id<FISQueryManager> queryManager;
@property (nonatomic) NSString *searchText;
@property (nonatomic, getter=areMoreImagesAvailableToDownload) BOOL moreImagesAvailableToDownload;
@property (nonatomic) NSUInteger page;
@property (nonatomic, getter=isImagesDownloadingInProgress) BOOL imagesDownloadingInProgress;

@end

@implementation FISConcreteViewPresenter

@synthesize delegate = _delegate;

- (instancetype)initWithImagesInteractor:(id<FISImagesInteractor>)interactor
                            queryManager:(id<FISQueryManager>)queryManager {
    NSAssert(interactor != nil, @"Interactor should not be nil.");
    NSAssert(queryManager != nil, @"QueryManager should not be nil.");
    self = [super init];
    if (self) {
        _interactor = interactor;
        _queryManager = queryManager;
        _page = 1;
        _moreImagesAvailableToDownload = NO;
    }
    
    return self;
}

- (void)loadImagesForQuery:(NSString *)searchText {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    [self.interactor deleteAllImagesData];
    self.searchText = searchText;
    self.moreImagesAvailableToDownload = YES;
    self.imagesDownloadingInProgress = NO;
    if (searchText == nil
        || [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        self.moreImagesAvailableToDownload = NO;
        [self.delegate viewPresenter:self
               didLoadImagesForQuery:searchText
                           withError:nil];
    } else {
        self.page = 1;
        [self fetchImages];
    }
}

- (void)fetchImages {
    NSAssert(!self.isImagesDownloadingInProgress, @"Images downloading is already in progress");
    self.imagesDownloadingInProgress = YES;
    __weak typeof(self) weakSelf = self;
    [self.queryManager fetchImagesForSearchText:self.searchText
                                           page:self.page
                                completionBlock:^(NSString *searchText,
                                                  NSUInteger page,
                                                  NSError *error,
                                                  NSArray<NSDictionary *> *imagesJSON) {
                                    if ([self.searchText isEqualToString:searchText]) {
                                        FISRunOnMainThread(NO, ^{
                                            __strong typeof(weakSelf) strongSelf = weakSelf;
                                            
                                            if (error == nil) {
                                                if (imagesJSON == nil || [imagesJSON count] == 0) {
                                                    strongSelf.moreImagesAvailableToDownload = NO;
                                                } else {
                                                    [strongSelf.interactor addImagesJSON:imagesJSON];
                                                }
                                            }
                                            
                                            strongSelf.imagesDownloadingInProgress = NO;
                                            [strongSelf.delegate viewPresenter:strongSelf
                                                         didLoadImagesForQuery:searchText
                                                                     withError:error];
                                        });
                                    }
                                }];
}

- (void)loadMoreImages {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    if (self.areMoreImagesAvailable
        && !self.isImagesDownloadingInProgress) {
        self.page += 1;
        [self fetchImages];
    }
}

- (NSUInteger)totalNumberOfImages {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    return [self.interactor totalNumberOfImages];
}

- (id<FISImage>)imageAtIndex:(NSUInteger)index {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    return [self.interactor imageAtIndex:index];
}

- (BOOL)areMoreImagesAvailable {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    return self.areMoreImagesAvailableToDownload;
}

#pragma mark <FISImagesInteractorDelegate>

- (void)imagesInteractorDidUpdateImages:(id<FISImagesInteractor>)imagesInteractor {
    [self.delegate viewPresenter:self
           didLoadImagesForQuery:self.searchText
                       withError:nil];
}

@end
