//
//  FISFlickrImageTests.m
//  flickrImageSearchTests
//
//  Created by Yash Bhardwaj on 7/8/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FISFlickrImage.h"

@interface FISFlickrImageTests : XCTestCase

@property (nonatomic) FISFlickrImage *image;

@end

@implementation FISFlickrImageTests

- (void)setUp {
    [super setUp];
    self.image = [[FISFlickrImage alloc] initWithJSON:@{@"id": @"43213036722",
                                                        @"owner": @"113478655@N07",
                                                        @"secret": @"a875b697f5",
                                                        @"server": @"1784",
                                                        @"farm": @(2),
                                                        @"title": @"IMG_3851",
                                                        @"ispublic": @(1),
                                                        @"isfriend": @(0),
                                                        @"isfamily": @(0)}];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testRemoteURL {
    XCTAssertTrue([[self.image imageRemoteURL].absoluteString isEqualToString:@"http://farm2.static.flickr.com/1784/43213036722_a875b697f5.jpg"]);
}

- (void)testThumbnailRemoteURL {
    XCTAssertTrue([[self.image thumbnailImageRemoteURL].absoluteString isEqualToString:@"http://farm2.static.flickr.com/1784/43213036722_a875b697f5_t.jpg"]);
}

@end
