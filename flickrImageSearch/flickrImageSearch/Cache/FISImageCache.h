//
//  FISImageCache.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#ifndef FISImageCache_h
#define FISImageCache_h

@protocol FISImageCache

- (void)setCountLimit:(NSUInteger)countLimit;
- (UIImage *)imageForURL:(NSURL *)URL;
- (void)cacheImage:(UIImage *)image forURL:(NSURL *)URL;

@end

#endif /* FISImageCache_h */
