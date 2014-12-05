//
//  APIClient.h
//  YouYanChuApp
//
//  Created by Ron on 13-11-14.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface APIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

+ (void)setUpToken:(NSString*) token;

@end
