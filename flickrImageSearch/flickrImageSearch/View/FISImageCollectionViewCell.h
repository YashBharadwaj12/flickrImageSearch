//
//  FISImageCollectionViewCell.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISImageManager.h"

@interface FISImageCollectionViewCell : UICollectionViewCell

@property (nonatomic) id<FISImageManager> imageManager;

- (void)configureWithImageURL:(NSURL *)URL;

@end
