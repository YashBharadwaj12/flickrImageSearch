//
//  FISQueryManager.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#ifndef FISQueryManager_h
#define FISQueryManager_h

@protocol FISQueryManager

- (void)fetchImagesForSearchText:(NSString *)searchText
                            page:(NSUInteger)page
                 completionBlock:(void (^)(NSString *searchText,
                                           NSUInteger page,
                                           NSError *error,
                                           NSArray<NSDictionary *> *imagesJSON))completionBlock;

@end

#endif /* FISQueryManager_h */
