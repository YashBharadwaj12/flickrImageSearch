//
//  FISMockQueryManager.m
//  flickrImageSearchTests
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISMockQueryManager.h"

@implementation FISMockQueryManager

- (void)fetchImagesForSearchText:(NSString *)searchText
                            page:(NSUInteger)page
                 completionBlock:(void (^)(NSString *searchText,
                                           NSUInteger page,
                                           NSError *error,
                                           NSArray<NSDictionary *> *imagesJSON))completionBlock {
    NSAssert(completionBlock != nil, @"completionBlock should not be nil");
    if (page <= 1) {
        completionBlock(searchText, page, nil, @[@{@"id": @"43213036722",
                                                   @"owner": @"113478655@N07",
                                                   @"secret": @"a875b697f5",
                                                   @"server": @"1784",
                                                   @"farm": @(2),
                                                   @"title": @"IMG_3851",
                                                   @"ispublic": @(1),
                                                   @"isfriend": @(0),
                                                   @"isfamily": @(0)}]);
    } else {
        completionBlock(searchText, page, nil, nil);
    }
}

@end
