//
//  FISConcreteViewPresenterTests.m
//  flickrImageSearchTests
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FISConcreteViewPresenter.h"
#import "FISMockQueryManager.h"
#import "FISMockImagesInteractor.h"

@interface FISConcreteViewPresenterTests : XCTestCase <FISViewPresenterOutput>

@property (nonatomic) FISConcreteViewPresenter *presenter;
@property (nonatomic) XCTestExpectation *outputUpdateDataExpectation;
@property (nonatomic) BOOL showLoading;

@end

@implementation FISConcreteViewPresenterTests

- (void)setUp {
    [super setUp];
    FISMockQueryManager *queryManager = [[FISMockQueryManager alloc] init];
    FISMockImagesInteractor *interactor = [[FISMockImagesInteractor alloc] init];
    self.presenter = [[FISConcreteViewPresenter alloc] initWithImagesInteractor:interactor
                                                                   queryManager:queryManager];
    self.presenter.output = self;
    self.outputUpdateDataExpectation = nil;
    self.showLoading = NO;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMoreImagesAvailable {
    self.outputUpdateDataExpectation = [[XCTestExpectation alloc] initWithDescription:@"Presenter delegate called."];
    [self.presenter loadImagesForQuery:@"dfsdf"];
    [self waitForExpectations:@[self.outputUpdateDataExpectation] timeout:5];
    XCTAssertTrue([self.presenter areMoreImagesAvailable]);
    
    self.outputUpdateDataExpectation = [[XCTestExpectation alloc] initWithDescription:@"Presenter delegate called again."];
    [self.presenter loadMoreImages];
    [self waitForExpectations:@[self.outputUpdateDataExpectation] timeout:5];
    XCTAssertFalse([self.presenter areMoreImagesAvailable]);
}

- (void)testShowLoadingImages {
    [self.presenter loadImagesForQuery:@"dfsdf"];
    XCTAssertTrue(self.showLoading);
}

- (void)updateData {
    if (self.outputUpdateDataExpectation != nil) {
        [self.outputUpdateDataExpectation fulfill];
    }
}

- (void)showLoadingImages:(BOOL)showLoading {
    self.showLoading = showLoading;
}

- (void)showErrorAlert {
}

@end
