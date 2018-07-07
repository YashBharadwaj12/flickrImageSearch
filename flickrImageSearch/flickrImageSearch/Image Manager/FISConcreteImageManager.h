//
//  FISConcreteImageManager.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISImageManager.h"
#import "FISImageCache.h"

@interface FISConcreteImageManager : NSObject <FISImageManager>

- (instancetype)initWithImageCache:(id<FISImageCache>)imageCache;

@end
