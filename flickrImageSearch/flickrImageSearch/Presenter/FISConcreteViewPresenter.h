//
//  FISConcreteViewPresenter.h
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISViewPresenter.h"
#import "FISImagesInteractor.h"
#import "FISQueryManager.h"

@interface FISConcreteViewPresenter : NSObject <FISViewPresenter>

- (instancetype)initWithImagesInteractor:(id<FISImagesInteractor>)interactor
                            queryManager:(id<FISQueryManager>)queryManager;

@end
