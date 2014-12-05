//
//  GMmainLoginViewViewController.m
//  LoveTJproject
//
//  Created by 李昂 on 14-9-25.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMmainLoginViewViewController.h"
#import "GMPhoneRegistViewController.h"
@interface GMmainLoginViewViewController ()

@end

@implementation GMmainLoginViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickLogin:(id)sender{
    
    
}

- (IBAction)onClickWeiboLogin:(id)sender {
    
    
}
- (IBAction)onClickPhoneRegist:(id)sender {
    
    GMPhoneRegistViewController *PhoneRegistVC = [[GMPhoneRegistViewController alloc] initWithNibName:@"GMPhoneRegistViewController" bundle:nil];
    [self.navigationController pushViewController:PhoneRegistVC animated:YES];
}
- (IBAction)onClickNoLogin:(id)sender {
    
    
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
