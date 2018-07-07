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

@property (nonatomic) NSArray *imagesJSON;
@property (nonatomic) NSMutableSet *imageIDs;

@end

@implementation FISConcreteImagesInteractor

@synthesize delegate = _delegate;

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageIDs = [NSMutableSet set];
        _imagesJSON = [NSArray array];
    }
    
    return self;
}

- (void)addImagesJSON:(NSArray<NSDictionary *> *)imagesJSON {
    NSAssert([NSThread isMainThread], @"Not called on main thread");
    NSAssert(imagesJSON != nil, @"Images JSON should not be nil");
    NSMutableArray *newImagesJSON = [NSMutableArray array];
    for (NSDictionary *json in imagesJSON) {
        NSString *imageID = [json objectForKey:@"id"];
        if (imageID != nil && ![self.imageIDs containsObject:imageID]) {
            [newImagesJSON addObject:json];
            [self.imageIDs addObject:imageID];
        }
    }
    self.imagesJSON = [self.imagesJSON arrayByAddingObjectsFromArray:newImagesJSON];
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
    self.imagesJSON = [NSArray array];
    [self.imageIDs removeAllObjects];
    [self.delegate imagesInteractorDidUpdateImages:self];
}

@end
