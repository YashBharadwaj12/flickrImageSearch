//
//  FISImagesCollectionViewController.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISViewPresenter.h"
#import "FISImageManager.h"

@interface FISImagesCollectionViewController : UICollectionViewController

- (instancetype)initWithPresenter:(id<FISViewPresenter>)presenter
                     imageManager:(id<FISImageManager>)imageManager;

/**
 Show images for the search text. Pass nil to show empty view.
 */
- (void)showImagesForSearchText:(NSString *)searchText;

@end
