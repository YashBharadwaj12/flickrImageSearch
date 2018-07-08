//
//  FISFlickrImage.m
//  flickrImageSearch
//
//  Created by Yash Bhardwaj on 7/7/18.
//  Copyright © 2018 Yash Bhardwaj. All rights reserved.
//

#import "FISFlickrImage.h"

static NSString * const ImageURL = @"http://farm%@.static.flickr.com/%@/%@_%@.jpg";
static NSString * const ThumbnailImageURL = @"http://farm%@.static.flickr.com/%@/%@_%@_t.jpg";

@interface FISFlickrImage ()

@property (nonatomic, readonly) NSString *imageId;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) id farm;
@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *secret;
@end

@implementation FISFlickrImage

- (instancetype)initWithJSON:(NSDictionary *)JSON {
    NSAssert(JSON != nil, @"JSON is nil");
    self = [super init];
    if (self) {
        _imageId = [JSON objectForKey:@"id"];
        _title = [JSON objectForKey:@"title"];
        _farm = [JSON objectForKey:@"farm"];
        _server = [JSON objectForKey:@"server"];
        _secret = [JSON objectForKey:@"secret"];
    }
    
    return self;
}

- (NSURL *)imageRemoteURL {
    NSString *stringURL = [NSString stringWithFormat:ImageURL, self.farm, self.server, self.imageId, self.secret];
    return [NSURL URLWithString:stringURL];
}

- (NSURL *)thumbnailImageRemoteURL {
    NSString *stringURL = [NSString stringWithFormat:ThumbnailImageURL, self.farm, self.server, self.imageId, self.secret];
    return [NSURL URLWithString:stringURL];
}

@end
