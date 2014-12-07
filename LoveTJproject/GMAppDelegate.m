//
//  GMAppDelegate.m
//  LoveTJproject
//
//  Created by 李昂 on 14-9-9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMAppDelegate.h"
#import "BaseNavViewController.h"
#import "BaceViewController.h"
#import "HomePageViewController.h"
#import "GMFirstViewController.h"
#import "GMSecondViewController.h"
#import "GMfourthViewController.h"
@implementation GMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BaseNavViewController *homeController=[[BaseNavViewController alloc]initWithRootViewController:[[HomePageViewController alloc]init]];
    
    UITabBarItem *itemHome = [[UITabBarItem alloc]initWithTitle:@"资讯" image:[UIImage imageNamed:@"all-news-onclick"] selectedImage:[UIImage imageNamed:@"all-news-blue"]];
    homeController.tabBarItem = itemHome;
    
    BaseNavViewController *FirstController=[[BaseNavViewController alloc]initWithRootViewController:[[GMFirstViewController alloc]init]];
    UITabBarItem *itemFirst = [[UITabBarItem alloc]initWithTitle:@"论坛" image:[UIImage imageNamed:@"all-bar-on"] selectedImage:[UIImage imageNamed:@"all-bar-blue"]];
    FirstController.tabBarItem = itemFirst;
    
    
    BaseNavViewController *SecondController=[[BaseNavViewController alloc]initWithRootViewController:[[GMSecondViewController alloc]init]];
    UITabBarItem *itemSecond = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"all-found-on"] selectedImage:[UIImage imageNamed:@"all-found-blue"]];
    SecondController.tabBarItem = itemSecond;
    
    BaseNavViewController *FourthController=[[BaseNavViewController alloc]initWithRootViewController:[[GMfourthViewController alloc]init]];
    UITabBarItem *itemFourth = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"all-me-on"] selectedImage:[UIImage imageNamed:@"all-me-blue"]];
    FourthController.tabBarItem = itemFourth;
    
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    tabbar.viewControllers=[NSArray arrayWithObjects:homeController,FirstController,SecondController,FourthController, nil];
    tabbar.tabBar.translucent=NO;
    self.window.rootViewController=tabbar;
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
