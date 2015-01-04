//
//  GMFaTieViewController.m
//  LoveTJproject
//
//  Created by yunqi on 15/1/5.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "GMFaTieViewController.h"

@interface GMFaTieViewController ()
{
    UITextView *textView;
    UITextField *textField;
}
@end

@implementation GMFaTieViewController
-(void)BaseClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)BaseControllerClickNavRightButton:(id)sender
{
    
}
- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"发表主题";
    [self showRightButton:YES withNomoralImage:nil HighlightedImage:nil title:@"发帖"];
    [self showBackButton];
    [super viewDidLoad];
    
    float placeX=9;
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"标题";
    label.font=[UIFont systemFontOfSize:17];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor lightGrayColor];
    label.backgroundColor=[UIColor clearColor];
    label.frame=CGRectMake(placeX, 0, 50, 44);
    [self.view addSubview:label];
    
    textField=[[UITextField alloc]init];
    textField.backgroundColor=[UIColor clearColor];
    textField.frame=CGRectMake(label.frame.size.width+label.frame.origin.x, label.frame.origin.y, self.view.frame.size.width-label.frame.size.width-label.frame.origin.x-placeX, 44);
    textField.returnKeyType=UIReturnKeyDefault;
    [self.view addSubview:textField];
    
    
    textView=[[UITextView alloc]init];
    textView.returnKeyType=UIReturnKeyDefault;
    textView.backgroundColor=[UIColor clearColor];
    textView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth=0.7;
    textView.font=[UIFont systemFontOfSize:15];
    textView.layer.masksToBounds=YES;
    textView.layer.cornerRadius=6;
    textView.frame=CGRectMake(placeX, textField.frame.size.height+textField.frame.origin.y+placeX, self.view.frame.size.width-2*placeX, 200);
    [self.view addSubview:textView];
    [textField becomeFirstResponder];
       // Do any additional setup after loading the view.
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
