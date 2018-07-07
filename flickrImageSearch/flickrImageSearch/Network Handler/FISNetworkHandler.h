//
//  FISNetworkHandler.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#ifndef FISNetworkHandler_h
#define FISNetworkHandler_h

@protocol FISNetworkHandler <NSObject>

- (void)sendRequest:(NSURLRequest *)request
withCompletionBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionBlock;

@end

#endif /* FISNetworkHandler_h */
