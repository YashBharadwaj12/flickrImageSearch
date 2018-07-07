//
//  FISSchedulerHelper.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISSchedulerHelper.h"

void FISRunOnMainThread(BOOL wait, FISSimpleBlock block) {
    [[block copy] performSelectorOnMainThread:@selector(my_callBlock)
                                   withObject:nil
                                waitUntilDone:wait];
}
