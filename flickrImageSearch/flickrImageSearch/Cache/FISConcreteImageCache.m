//
//  FISConcreteImageCache.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteImageCache.h"

static const NSUInteger MaxNumberOfCachedImages = 100;

@interface FISConcreteImageCache ()

@property (nonatomic, readonly) NSCache *cache;

@end

@implementation FISConcreteImageCache

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = MaxNumberOfCachedImages;
    }
    
    return self;
}

- (void)setCountLimit:(NSUInteger)countLimit {
    NSAssert(countLimit > 0, @"Count limit should not be greter than zero.");
    self.cache.countLimit = countLimit;
}

- (UIImage *)imageForURL:(NSURL *)URL {
    NSAssert(URL != nil, @"URL should not be nil.");
    return [self.cache objectForKey:URL];
}

- (void)cacheImage:(UIImage *)image forURL:(NSURL *)URL {
    NSAssert(image != nil, @"Image should not be nil.");
    NSAssert(URL != nil, @"URL should not be nil.");
    [self.cache setObject:image forKey:URL];
}

@end
