//
//  FISSearchImagesViewController.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISSearchImagesViewController.h"
#import "FISImagesCollectionViewController.h"

@interface FISSearchImagesViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *resultsView;
@property (nonatomic, readonly) FISImagesCollectionViewController *imagesCollectionViewController;

@end

@implementation FISSearchImagesViewController

- (instancetype)initWithImagesCollectionViewController:(FISImagesCollectionViewController *)imagesCollectionViewController {
    NSAssert(imagesCollectionViewController != nil, @"imagesCollectionViewController should not be nil");
    self = [super initWithNibName:@"FISSearchImagesViewController" bundle:nil];
    if (self) {
        _imagesCollectionViewController = imagesCollectionViewController;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.imagesCollectionViewController];
    UIView *imagesCollectionView = self.imagesCollectionViewController.view;
    [self.resultsView addSubview:imagesCollectionView];
    [self.imagesCollectionViewController didMoveToParentViewController:self];
    imagesCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [imagesCollectionView.leftAnchor constraintEqualToAnchor:self.resultsView.leftAnchor].active = YES;
    [imagesCollectionView.topAnchor constraintEqualToAnchor:self.resultsView.topAnchor].active = YES;
    [imagesCollectionView.rightAnchor constraintEqualToAnchor:self.resultsView.rightAnchor].active = YES;
    [imagesCollectionView.bottomAnchor constraintEqualToAnchor:self.resultsView.bottomAnchor].active = YES;
    [self.imagesCollectionViewController showImagesForSearchText:nil];
}

#pragma mark - Search bar delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.imagesCollectionViewController showImagesForSearchText:searchBar.text];
}

@end
