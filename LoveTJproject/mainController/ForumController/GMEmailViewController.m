//
//  GMEmailViewController.m
//  LoveTJproject
//
//  Created by yunqi on 15/1/5.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "GMEmailViewController.h"

@interface GMEmailViewController ()
{
    UISegmentedControl *segmentedControl;
}
@end

@implementation GMEmailViewController

-(void)BaseClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];
    [self showBackButton];
    segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"发帖",@"回帖",@"回复", nil]];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor lightGrayColor];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [segmentedControl addTarget:self action:@selector(SelectType) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)SelectType
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
