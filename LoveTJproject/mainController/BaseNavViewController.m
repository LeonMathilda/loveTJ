//
//  BaseNavViewController.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/6.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    [[self.viewControllers lastObject] setHidesBottomBarWhenPushed:NO];
     return  [super popToRootViewControllerAnimated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    

    if (self.viewControllers.count==2) {
        [[self.viewControllers  objectAtIndex:0] setHidesBottomBarWhenPushed:NO];
        [[self.viewControllers lastObject] setHidesBottomBarWhenPushed:NO];
    }
    return  [super popViewControllerAnimated:animated];
}
-(NSArray*)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers indexOfObject:viewController]==0) {
        [[self.viewControllers lastObject] setHidesBottomBarWhenPushed:NO];
    }
    return  [super popToViewController:viewController animated:animated];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
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
