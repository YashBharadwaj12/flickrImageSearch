//
//  FISSchedulerHelper.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FISSimpleBlock)(void);

void FISRunOnMainThread(BOOL wait,FISSimpleBlock block);
