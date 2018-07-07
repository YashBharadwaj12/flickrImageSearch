//
//  FISImageCollectionViewCell.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISImageCollectionViewCell.h"
#import "FISImageManager.h"
#import "FISSchedulerHelper.h"

@interface FISImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
@property (nonatomic) NSURL *imageURL;

@end

@implementation FISImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)prepareForReuse {
    [self.imageView setImage:nil];
    self.loadingSpinner.hidesWhenStopped = YES;
    [self.loadingSpinner startAnimating];
}

- (void)configureWithImageURL:(NSURL *)URL {
    NSAssert(self.imageManager != nil, @"Image manager must be set before configuring cell with URL");
    NSAssert(URL != nil, @"URL should not be nil");
    if (self.imageURL != URL) {
        self.imageURL = URL;
        __weak typeof(self) wealSelf = self;
        [self.imageManager imageForURL:URL
                       completionBlock:^(NSURL *imageURL, UIImage *image, NSError *error) {
                           if (imageURL == wealSelf.imageURL) {
                               FISRunOnMainThread(NO, ^{
                                   __strong typeof(wealSelf) strongSelf = wealSelf;
                                   [strongSelf.loadingSpinner stopAnimating];
                                   if (error != nil) {
                                       [strongSelf.imageView setImage:[UIImage imageNamed:@"failed.png"]];
                                   } else {
                                       [strongSelf.imageView setImage:image];
                                   }
                               });
                           }
                       }];
    }
}

@end
