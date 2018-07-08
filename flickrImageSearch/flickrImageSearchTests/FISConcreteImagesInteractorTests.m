//
//  FISConcreteImagesInteractorTests.m
//  flickrImageSearchTests
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FISConcreteImagesInteractor.h"

@interface FISConcreteImagesInteractorTests : XCTestCase

@property (nonatomic) FISConcreteImagesInteractor *interactor;

@end

@implementation FISConcreteImagesInteractorTests

- (void)setUp {
    [super setUp];
    
    self.interactor = [[FISConcreteImagesInteractor alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddImagesCount {
    [self.interactor addImagesJSON:@[@{@"id": @"43213036722",
                                       @"owner": @"113478655@N07",
                                       @"secret": @"a875b697f5",
                                       @"server": @"1784",
                                       @"farm": @(2),
                                       @"title": @"IMG_3851",
                                       @"ispublic": @(1),
                                       @"isfriend": @(0),
                                       @"isfamily": @(0)}]];
    XCTAssertTrue([self.interactor totalNumberOfImages] == 1);
    XCTAssertNotNil([self.interactor imageAtIndex:0]);
    
    // Same image id should not add to count.
    [self.interactor addImagesJSON:@[@{@"id": @"43213036722",
                                       @"owner": @"113478655@N07",
                                       @"secret": @"a875b697f5",
                                       @"server": @"1784",
                                       @"farm": @(2),
                                       @"title": @"IMG_3851",
                                       @"ispublic": @(1),
                                       @"isfriend": @(0),
                                       @"isfamily": @(0)}]];
    
    XCTAssertTrue([self.interactor totalNumberOfImages] == 1);
    XCTAssertNotNil([self.interactor imageAtIndex:0]);
    
    // Test with new image id
    [self.interactor addImagesJSON:@[@{@"id": @"43213036645",
                                       @"owner": @"113478655@N07",
                                       @"secret": @"a875b697f5",
                                       @"server": @"1784",
                                       @"farm": @(2),
                                       @"title": @"IMG_3851",
                                       @"ispublic": @(1),
                                       @"isfriend": @(0),
                                       @"isfamily": @(0)}]];
    
    XCTAssertTrue([self.interactor totalNumberOfImages] == 2);
    XCTAssertNotNil([self.interactor imageAtIndex:1]);
}

- (void)testDeleteAllImages {
    [self.interactor addImagesJSON:@[@{@"id": @"43213036722",
                                       @"owner": @"113478655@N07",
                                       @"secret": @"a875b697f5",
                                       @"server": @"1784",
                                       @"farm": @(2),
                                       @"title": @"IMG_3851",
                                       @"ispublic": @(1),
                                       @"isfriend": @(0),
                                       @"isfamily": @(0)}]];
    XCTAssertTrue([self.interactor totalNumberOfImages] == 1);
    XCTAssertNotNil([self.interactor imageAtIndex:0]);
    [self.interactor deleteAllImagesData];
    XCTAssertTrue([self.interactor totalNumberOfImages] == 0);
}

@end
