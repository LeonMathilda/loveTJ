//
//  UIViewController+Custom.h
//  hepaimusic
//
//  Created by Ron on 13-7-27.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//
typedef void(^voidBlock)();
@interface UIViewController(Custom)
- (void)configNavigationRightItemWithStringNoEnable:(NSString*)text andAction:(voidBlock)action;
- (void)configNavigationBackItemRed:(voidBlock)backAction;
- (void)configNavigationBackItem:(voidBlock)backAction;
- (void)configNavigationRightItemWithImages:(UIImage*)image :(UIImage*)image2 andAction:(voidBlock)action :(voidBlock)action2;
- (void)configNavigationLeftItemWithString:(NSString*)text andAction:(voidBlock)action;

- (void)configNavigationRightItemWithString:(NSString*)text andAction:(voidBlock)action;

- (void)configNavigationLeftItemWithImage:(UIImage*)image andAction:(voidBlock)action;

- (void)configNavigationRightItemWithImage:(UIImage*)image andAction:(voidBlock)action;

- (void)setNavigationBarTitle:(NSString*)title;

- (void)configKeyboard;

- (void)removeObsever;

//NavigationBarCongig
- (void)putOnNavigationBarWithRedCoat;

@end
