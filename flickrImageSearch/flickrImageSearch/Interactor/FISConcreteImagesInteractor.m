//
//  FISConcreteImagesInteractor.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteImagesInteractor.h"
#import "FISFlickrImage.h"

@interface FISConcreteImagesInteractor ()

@property (atomic) NSArray *imagesJSON;

@end

@implementation FISConcreteImagesInteractor

@synthesize delegate = _delegate;

- (void)addImagesJSON:(NSArray<NSDictionary *> *)imagesJSON {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSAssert(imagesJSON != nil, @"Images JSON should not be nil");
    self.imagesJSON = (self.imagesJSON == nil
                       ? [imagesJSON copy]
                       : [self.imagesJSON arrayByAddingObjectsFromArray:imagesJSON]);
    [self.delegate imagesInteractorDidUpdateImages:self];
}

- (NSUInteger)totalNumberOfImages {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    return self.imagesJSON == nil ? 0 : [self.imagesJSON count];
}

- (id<FISImage>)imageAtIndex:(NSUInteger)index {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSDictionary *imageJSON = [self.imagesJSON objectAtIndex:index];
    return [[FISFlickrImage alloc] initWithJSON:imageJSON];
}

- (void)deleteAllImagesData {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    self.imagesJSON = nil;
    [self.delegate imagesInteractorDidUpdateImages:self];
}

@end
