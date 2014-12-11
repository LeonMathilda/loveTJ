//
//  GMPhotosViewController.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPhotosViewController.h"

@interface GMPhotosViewController ()
{
    UIStatusBarStyle barStyle;
    UIBarStyle navBarStyle;
    BOOL barHiden;
    BOOL navTranslucent;
    UIScrollView *scroller;
}
@end

@implementation GMPhotosViewController
-(void)loadView
{
    navTranslucent=self.navigationController.navigationBar.translucent;
    barStyle=[UIApplication sharedApplication].statusBarStyle;
    barHiden=[UIApplication sharedApplication].isStatusBarHidden;
    navBarStyle=self.navigationController.navigationBar.barStyle;
    [super loadView];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent=navTranslucent;
    [UIApplication sharedApplication].statusBarHidden=barHiden;
    [[UIApplication sharedApplication]setStatusBarStyle:barStyle animated:NO];
    [self.navigationController.navigationBar setBarStyle:navBarStyle];
        [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor blackColor];
    
    [self showBackButton];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)BaseClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
