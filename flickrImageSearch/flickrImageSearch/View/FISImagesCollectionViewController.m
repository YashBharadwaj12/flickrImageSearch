//
//  FISImagesCollectionViewController.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISImagesCollectionViewController.h"
#import "FISImage.h"
#import "FISImageCollectionViewCell.h"
#import "FISSchedulerHelper.h"

static NSString * const reuseIdentifier = @"Cell";
static const NSUInteger CellsPerRow = 3;
static const NSUInteger SectionLeftInset = 5;
static const NSUInteger CellFromEndToLoadMore = 20;

@interface FISImagesCollectionViewController () <FISViewPresenterOutput, UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (nonatomic, readonly) id<FISViewPresenter> presenter;
@property (nonatomic, readonly) id<FISImageManager> imageManager;

@end

@implementation FISImagesCollectionViewController

- (instancetype)initWithPresenter:(id<FISViewPresenter>)presenter
                     imageManager:(id<FISImageManager>)imageManager {
    NSAssert(presenter != nil, @"Presenter should not be nil");
    NSAssert(imageManager != nil, @"Image manager should not be nil");
    self = [super initWithNibName:@"FISImagesCollectionViewController" bundle:nil];
    if (self) {
        _presenter = presenter;
        _presenter.output = self;
        _imageManager = imageManager;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FISImageCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification {
    [self fis_reloadData];
}

- (void)showImagesForSearchText:(NSString *)searchText {
    [self.presenter loadImagesForQuery:searchText];
}

- (void)loadMoreImagesIfRequiredWithIndex:(NSUInteger)index {
    NSUInteger totalNumberOfImages = [self.presenter totalNumberOfImages];
    if (totalNumberOfImages < index || (totalNumberOfImages - index) <= CellFromEndToLoadMore) {
        [self.presenter loadMoreImages];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.presenter totalNumberOfImages];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self loadMoreImagesIfRequiredWithIndex:indexPath.row];
    FISImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                 forIndexPath:indexPath];
    id<FISImage> image = [self.presenter imageAtIndex:(NSUInteger)indexPath.row];
    cell.imageManager = self.imageManager;
    [cell configureWithImageURL:image.thumbnailImageRemoteURL];
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
    CGFloat paddingSpace = SectionLeftInset * (CellsPerRow * 2);
    CGFloat availableWidth = CGRectGetWidth(self.view.bounds) - paddingSpace;
    CGFloat widthPerCell = floor(availableWidth / CellsPerRow);
    
    return CGSizeMake(widthPerCell, widthPerCell);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SectionLeftInset;
}

#pragma mark - FISViewPresenterOutput methods

- (void)updateData {
    __weak typeof(self) weakSelf = self;
    FISRunOnMainThread(NO, ^{
        [weakSelf fis_reloadData];
    });
}

- (void)showLoadingImages:(BOOL)showLoading {
    __weak typeof(self) weakSelf = self;
    FISRunOnMainThread(NO, ^{
        if (showLoading) {
            self.textlabel.text = @"Loading...";
        }
        
        self.textlabel.hidden = !showLoading;
    });
}

- (void)showErrorAlert {
    __weak typeof(self) weakSelf = self;
    FISRunOnMainThread(NO, ^{
        [weakSelf showAlertWithTitle:@"Facing some error"
                             message:@"Please search again"];
    });
}

- (void)fis_reloadData {
    if ([self.presenter totalNumberOfImages] == 0) {
        self.textlabel.text = @"No Images available";
        self.textlabel.hidden = NO;
    } else {
        self.textlabel.hidden = YES;
    }
    
    [self.collectionView reloadData];
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
