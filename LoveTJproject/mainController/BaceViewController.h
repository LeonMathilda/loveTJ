//
//  BaceViewController.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaceViewController : UIViewController
-(void)showBackButton;
-(void)showRightButton:(BOOL)showRight withNomoralImage:(NSString *)strNomoralImage HighlightedImage:(NSString *)HighlightedImage title:(NSString *)title;
-(void)BaseClickBackButton:(id)sender;
-(void)BaseControllerClickNavRightButton:(id)sender;
@end
