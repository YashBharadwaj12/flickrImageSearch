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

@protocol FISImagesInteractor <NSObject>

@property (nonatomic, weak) id<FISImagesInteractorDelegate> delegate;

- (void)addImagesJSON:(NSArray<NSDictionary *> *)imagesJSON
             forQuery:(NSString *)searchText;
- (NSUInteger)totalNumberOfImages;
- (id<FISImage>)imageAtIndex:(NSUInteger)index;
- (void)deleteAllImagesData;
- (void)deleteImagesDataForQuery:(NSString *)searchQuery;

@end

@protocol FISImagesInteractorDelegate <NSObject>

- (void)imagesInteractor:(id<FISImagesInteractor>)imagesInteractor didUpdateImagesDataForQuery:(NSString *)searchQuery;
- (void)imagesInteractorDidDeleteAllImages:(id<FISImagesInteractor>)imagesInteractor;

@end

#endif /* FISImagesInteractor_h */
