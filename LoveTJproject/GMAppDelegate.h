//
//  GMAppDelegate.h
//  LoveTJproject
//
//  Created by 李昂 on 14-9-9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import "AppDatabase.h"
#import "AGViewDelegate.h"
#import "WXApi.h"
#import "WBApi.h"
@interface GMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly, nonatomic) AGViewDelegate *shareViewDelegate;

@end
