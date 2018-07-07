//
//  FISImagesCollectionViewController.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISImagesCollectionViewController.h"
#import "FISViewPresenter.h"
#import "FISImage.h"
#import "FISImageManager.h"
#import "FISImageCollectionViewCell.h"
#import "FISSchedulerHelper.h"

static NSString * const reuseIdentifier = @"Cell";
static const NSUInteger CellsPerRow = 3;
static const NSUInteger SectionLeftInset = 5;

@interface FISImagesCollectionViewController () <FISViewPresenterDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly) id<FISViewPresenter> presenter;
@property (nonatomic, readonly) id<FISImageManager> imageManager;

@end

@implementation FISImagesCollectionViewController

- (instancetype)initWithPresenter:(id<FISViewPresenter>)presenter imageManager:(id<FISImageManager>)imageManager {
    NSAssert(presenter != nil, @"Presenter should not be nil");
    NSAssert(imageManager != nil, @"Image manager should not be nil");
    self = [super initWithNibName:@"FISImagesCollectionViewController" bundle:nil];
    if (self) {
        _presenter = presenter;
        _imageManager = imageManager;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[FISImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)showImagesForSearchText:(NSString *)searchText {
    [self.presenter loadImagesForQuery:searchText];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.presenter totalNumberOfImages];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FISImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    id<FISImage> image = [self.presenter imageAtIndex:(NSUInteger)indexPath.row];
    cell.imageManager = self.imageManager;
    [cell configureWithImageURL:image.imageRemoteURL];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(SectionLeftInset, SectionLeftInset, SectionLeftInset, SectionLeftInset);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat paddingSpace = SectionLeftInset* (CellsPerRow + 1);
    CGFloat availableWidth = CGRectGetWidth(self.view.bounds) - paddingSpace;
    CGFloat widthPerCell = floor(availableWidth / CellsPerRow);
    
    return CGSizeMake(widthPerCell, widthPerCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SectionLeftInset;
}

#pragma mark - FISViewPresenter delegate methods

- (void)viewPresenter:(id<FISViewPresenter>)viewPresenter
didLoadImagesForQuery:(NSString *)searchText
            withError:(NSError *)error {
    __weak typeof(self) weakSelf = self;
    FISRunOnMainThread(NO, ^{
        if (error != nil) {
            [weakSelf showAlertWithTitle:@"Facing some error"
                                 message:@"Please search again"];
        } else {
            [weakSelf.collectionView reloadData];
        }
    });
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
