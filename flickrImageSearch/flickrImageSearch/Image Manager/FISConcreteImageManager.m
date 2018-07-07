//
//  FISConcreteImageManager.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteImageManager.h"

@interface FISConcreteImageManager ()

@property (nonatomic, readonly) id<FISImageCache> imageCache;

@end

@implementation FISConcreteImageManager

- (instancetype)initWithImageCache:(id<FISImageCache>)imageCache {
    NSAssert(imageCache != nil, @"FISImageCache cache should not be nil");
    self = [super init];
    
    if (self) {
        _imageCache = imageCache;
    }
    
    return self;
}

- (void)imageForURL:(NSURL *)URL
    completionBlock:(void (^)(NSURL *, UIImage *, NSError *))completionBlock {
    NSAssert(URL != nil, @"URL should not be nil");
    NSAssert(completionBlock != nil, @"completionBlock should not be nil");
    UIImage *cachedImage = [self.imageCache imageForURL:URL];
    
    if (cachedImage != nil) {
        completionBlock(URL, cachedImage, nil);
    } else {
        [self networkImageForURL:URL
                 completionBlock:completionBlock];
    }
}

- (void)networkImageForURL:(NSURL *)URL
           completionBlock:(void (^)(NSURL *, UIImage *, NSError *))completionBlock {
    // TODO: Download image from network nd call completion block
}

@end
