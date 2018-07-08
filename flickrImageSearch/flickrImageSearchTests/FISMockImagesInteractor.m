//
//  FISMockImagesInteractor.m
//  flickrImageSearchTests
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISMockImagesInteractor.h"

@implementation FISMockImagesInteractor

@synthesize delegate = _delegate;

- (void)addImagesJSON:(NSArray<NSDictionary *> *)imagesJSON {
}

- (NSUInteger)totalNumberOfImages {
    return 0;
}

- (id<FISImage>)imageAtIndex:(NSUInteger)index {
    return nil;
}

- (void)deleteAllImagesData {
}

@end
