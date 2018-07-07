//
//  FISViewPresenter.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISImage.h"

@protocol FISViewPresenterDelegate;

@protocol FISViewPresenter <NSObject>

@property (nonatomic, weak) id<FISViewPresenterDelegate> delegate;

- (void)loadImagesForQuery:(NSString *)searchText;
- (void)loadMoreImages;
- (NSUInteger)totalNumberOFImages;
- (id<FISImage>)imageAtIndex:(NSUInteger)index;
- (BOOL)areMoreImagesAvailable;

@end

@protocol FISViewPresenterDelegate <NSObject>

- (void)viewPresenter:(id<FISViewPresenter>)viewPresenter
didLoadImagesForQuery:(NSString *)searchText
            withError:(NSError *)error;

@end
