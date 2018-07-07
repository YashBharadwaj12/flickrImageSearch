//
//  FISConcreteQueryManager.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISConcreteQueryManager.h"

@implementation FISConcreteQueryManager

- (void)fetchImagesForSearchText:(NSString *)searchText
                            page:(NSUInteger)page
                 completionBlock:(void (^)(NSString *, NSUInteger, NSError *, NSArray<NSDictionary *> *))completionBlock {
    // TODO: Compose and make network call to fetch images json
}

@end
