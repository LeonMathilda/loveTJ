//
//  BaceViewController.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "BaceViewController.h"

@interface BaceViewController ()

@end

@implementation BaceViewController

- (void)viewDidLoad {
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)showBackButton
{
    UIButton *navigationLeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    navigationLeftBtn.frame = CGRectMake(0, 0, 122/2, 88/2);
    [navigationLeftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui@2x"] forState:UIControlStateNormal];
    [navigationLeftBtn addTarget:self action:@selector(BaseClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar=[[UIBarButtonItem alloc] initWithCustomView:navigationLeftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (IOS7_OR_LATER) {
        negativeSpacer.width=-15;
    }else
    {
        negativeSpacer.width=-5;
    }
    
    self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,bar, nil];
}
-(void)BaseClickBackButton:(id)sender
{
    
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
