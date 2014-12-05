//
//  APIClient.m
//  YouYanChuApp
//
//  Created by Ron on 13-11-14.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:API_HOST]];
        [[_sharedClient requestSerializer] setValue:@"7981c775fd46c1b5e88ff3f382154c1e" forHTTPHeaderField:@"X-APP-TOKEN"];
               [[_sharedClient requestSerializer] setValue:@"application/vnd.youyanchu.v1" forHTTPHeaderField:@"Accept"];
    _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/html", @"text/javascript", nil];
    });
    return _sharedClient;
}

+ (void)setUpToken:(NSString *)token {
    if (token) {
        [[[APIClient sharedClient] requestSerializer] setValue:[NSString stringWithFormat:@"%d",[[YYCAccount currentAccount].uid intValue]]
                                                      forHTTPHeaderField:@"YYC-User-Id"];

        [[[APIClient sharedClient] requestSerializer] setValue:token forHTTPHeaderField:@"YYC-Auth-Token"];
    }
    else {
        [[[APIClient sharedClient] requestSerializer] clearAuthorizationHeader];
    }
}

@end
