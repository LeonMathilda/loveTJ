//
//  APIClient.m
//  YouYanChuApp
//
//  Created by Ron on 13-11-14.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import "APIClient2.h"

@implementation APIClient2

+ (instancetype)sharedClient {
    static APIClient2 *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient2 alloc] initWithBaseURL:[NSURL URLWithString:API_HOST2]];
        [[_sharedClient requestSerializer] setValue:@"7981c775fd46c1b5e88ff3f382154c1e" forHTTPHeaderField:@"X-APP-TOKEN"];
        [[_sharedClient requestSerializer] setValue:[YYCAccount currentAccount].uid forHTTPHeaderField:@"X-USER-ID"];
        [[_sharedClient requestSerializer] setValue:@"application/vnd.youyanchu.v1" forHTTPHeaderField:@"Accept"];
    });
    return _sharedClient;
}
+ (void)setUpToken:(NSString *)token{
    if (token) {
        [[[APIClient2 sharedClient] requestSerializer] setValue:token forHTTPHeaderField:@"X-USER-ACCESS-TOKEN"];
    }
    else {
        [[[APIClient2 sharedClient] requestSerializer] clearAuthorizationHeader];
    }
}

@end
