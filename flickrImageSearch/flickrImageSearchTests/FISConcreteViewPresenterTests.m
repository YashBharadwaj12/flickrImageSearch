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
@property (nonatomic) XCTestExpectation *delegateCallExpectation;

@end

@implementation FISConcreteViewPresenterTests

- (void)setUp {
    [super setUp];
    FISMockQueryManager *queryManager = [[FISMockQueryManager alloc] init];
    FISMockImagesInteractor *interactor = [[FISMockImagesInteractor alloc] init];
    self.presenter = [[FISConcreteViewPresenter alloc] initWithImagesInteractor:interactor
                                                                   queryManager:queryManager];
    self.presenter.output = self;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMoreImagesAvailable {
    self.delegateCallExpectation = [[XCTestExpectation alloc] initWithDescription:@"Presenter delegate called."];
    [self.presenter loadImagesForQuery:@"dfsdf"];
    [self waitForExpectations:@[self.delegateCallExpectation] timeout:5];
    XCTAssertTrue([self.presenter areMoreImagesAvailable]);
    
    self.delegateCallExpectation = [[XCTestExpectation alloc] initWithDescription:@"Presenter delegate called again."];
    [self.presenter loadMoreImages];
    [self waitForExpectations:@[self.delegateCallExpectation] timeout:5];
    XCTAssertFalse([self.presenter areMoreImagesAvailable]);
}

- (void)updateData {
    [self.delegateCallExpectation fulfill];
}

- (void)showLoadingImages:(BOOL)showLoading {
}

- (void)showErrorAlert {
}

@end
