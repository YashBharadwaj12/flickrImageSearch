//
//  FISImageManager.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#ifndef FISImageManager_h
#define FISImageManager_h

@protocol FISImageManager

- (void)imageForURL:(NSURL *)URL
    completionBlock:(void(^)(NSURL *URL, UIImage *image, NSError *error))completionBlock;

@end

#endif /* FISImageManager_h */
