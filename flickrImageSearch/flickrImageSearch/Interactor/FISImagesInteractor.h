//
//  FISImagesInteractor.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISImage.h"

#ifndef FISImagesInteractor_h
#define FISImagesInteractor_h

@protocol FISImagesInteractorDelegate;

/**
 All methods must be invoked on main thread only
 */
@protocol FISImagesInteractor <NSObject>

@property (nonatomic, weak) id<FISImagesInteractorDelegate> delegate;

- (void)addImagesJSON:(NSArray<NSDictionary *> *)imagesJSON;
- (NSUInteger)totalNumberOfImages;
- (id<FISImage>)imageAtIndex:(NSUInteger)index;
- (void)deleteAllImagesData;

@end

@protocol FISImagesInteractorDelegate <NSObject>

- (void)imagesInteractorDidUpdateImages:(id<FISImagesInteractor>)imagesInteractor;

@end

#endif /* FISImagesInteractor_h */
