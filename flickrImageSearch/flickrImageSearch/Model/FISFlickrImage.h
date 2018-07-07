//
//  FISFlickrImage.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISImage.h"

@interface FISFlickrImage : NSObject <FISImage>

- (instancetype)initWithJSON:(NSDictionary *)JSON;

@end
