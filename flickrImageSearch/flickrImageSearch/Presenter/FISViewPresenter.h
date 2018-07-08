//
//  FISViewPresenter.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISImage.h"

@protocol FISViewPresenterOutput;

/**
 All methods must be invoked on main thread only
 */
@protocol FISViewPresenter <NSObject>

@property (nonatomic, weak) id<FISViewPresenterOutput> output;

- (void)loadImagesForQuery:(NSString *)searchText;
- (void)loadMoreImages;
- (NSUInteger)totalNumberOfImages;
- (id<FISImage>)imageAtIndex:(NSUInteger)index;
- (BOOL)areMoreImagesAvailable;

@end

@protocol FISViewPresenterOutput <NSObject>

- (void)showLoadingImages:(BOOL)showLoading;
- (void)updateData;
- (void)showErrorAlert;

@end
