//
//  FISNetworkImageManager.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#ifndef FISNetworkImageManager_h
#define FISNetworkImageManager_h

@protocol FISNetworkImageManager

- (void)networkImageForURL:(NSURL *)URL
           completionBlock:(void (^)(NSURL *URL, UIImage *image, NSError *error))completionBlock;

@end

#endif /* FISNetworkImageManager_h */
