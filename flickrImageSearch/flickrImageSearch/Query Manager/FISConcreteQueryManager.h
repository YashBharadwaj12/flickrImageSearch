//
//  FISConcreteQueryManager.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISQueryManager.h"
#import "FISNetworkHandler.h"

@interface FISConcreteQueryManager : NSObject <FISQueryManager>

- (instancetype)initWithNetworkHandler:(id<FISNetworkHandler>)networkHandler
                                apiKey:(NSString *)apiKey;

@end
