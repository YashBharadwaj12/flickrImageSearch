//
//  FISBuilder.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISBuilder.h"
#import "FISConcreteNetworkHandler.h"
#import "FISConcreteImageCache.h"
#import "FISConcreteNetworkImageManager.h"
#import "FISConcreteImageManager.h"
#import "FISConcreteQueryManager.h"
#import "FISConcreteImagesInteractor.h"
#import "FISConcreteViewPresenter.h"
#import "FISImagesCollectionViewController.h"
#import "FISSearchImagesViewController.h"

static NSString * const APIKey = @"3e7cc266ae2b0e0d78e279ce8e361736";

@implementation FISBuilder

+ (UIViewController *)flickerImagesViewController {
    FISConcreteNetworkHandler *networkHandler = [[FISConcreteNetworkHandler alloc] init];
    FISConcreteNetworkImageManager *networkImageManager = [[FISConcreteNetworkImageManager alloc] initWithNetworkHandler:networkHandler];
    FISConcreteImageCache *imageCache = [[FISConcreteImageCache alloc] init];
    FISConcreteImageManager *imageManager = [[FISConcreteImageManager alloc] initWithImageCache:imageCache
                                                                            networkImageManager:networkImageManager];
    FISConcreteQueryManager *queryManager = [[FISConcreteQueryManager alloc] initWithNetworkHandler:networkHandler
                                                                                             apiKey:APIKey];
    FISConcreteImagesInteractor *interactor = [[FISConcreteImagesInteractor alloc] init];
    FISConcreteViewPresenter *presenter = [[FISConcreteViewPresenter alloc] initWithImagesInteractor:interactor
                                                                                        queryManager:queryManager];
    FISImagesCollectionViewController *imagesCollectionViewController
    = [[FISImagesCollectionViewController alloc] initWithPresenter:presenter
                                                      imageManager:imageManager];
    FISSearchImagesViewController *searchImagesController
    = [[FISSearchImagesViewController alloc] initWithImagesCollectionViewController:imagesCollectionViewController];
    
    return searchImagesController;
}

@end
