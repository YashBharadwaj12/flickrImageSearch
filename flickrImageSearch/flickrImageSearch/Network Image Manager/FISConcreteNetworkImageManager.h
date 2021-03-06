//
//  FISConcreteNetworkImageManager.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISNetworkImageManager.h"
#import "FISNetworkHandler.h"

@interface FISConcreteNetworkImageManager : NSObject <FISNetworkImageManager>

- (instancetype)initWithNetworkHandler:(id<FISNetworkHandler>)networkHandler;

@end
