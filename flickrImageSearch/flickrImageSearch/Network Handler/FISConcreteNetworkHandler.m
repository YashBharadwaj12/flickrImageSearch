//
//  FISConcreteNetworkHandler.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteNetworkHandler.h"

@implementation FISConcreteNetworkHandler

- (void)sendRequest:(NSURLRequest *)request
withCompletionBlock:(void (^)(NSData *, NSURLResponse *, NSError *))completionBlock {
    NSAssert(request != nil, @"request should not be nil");
    NSAssert(completionBlock != nil, @"completionBlock should not be nil");
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * _Nullable data,
                                                                                     NSURLResponse * _Nullable response,
                                                                                     NSError * _Nullable error) {
                                                                     completionBlock(data, response, error);
                                                                 }];
    [task resume];
}

@end
