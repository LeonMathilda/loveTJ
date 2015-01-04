//
//  BaceViewController.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "BaceViewController.h"
#define chuMianUI_RightClickPlace 0
#define chuMianUI_LeftClickPlace 0
#define chuMianUI_RightColor   [UIColor darkGrayColor]
#define chuMianUI_RightClickColor [UIColor colorWithRed:180.0f/255.0f green:180.0f/255.0 blue:188.0/255.0 alpha:1]
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
-(void)loadView
{
    [super loadView];
}
-(void)showRightButton:(BOOL)showRight withNomoralImage:(NSString *)strNomoralImage HighlightedImage:(NSString *)HighlightedImage title:(NSString *)title
{
    if (showRight) {
        UIButton* navigationRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        navigationRightBtn.frame=CGRectMake(0, 0, 138/2, 88/2);
        
        [navigationRightBtn addTarget:self action:@selector(BaseControllerClickNavRightButton:) forControlEvents:UIControlEventTouchUpInside];
        navigationRightBtn.hidden=NO;
        if (strNomoralImage) {
            [navigationRightBtn setImage:[UIImage imageNamed:strNomoralImage] forState:UIControlStateNormal];
        }
        if (HighlightedImage) {
            [navigationRightBtn setImage:[UIImage imageNamed:HighlightedImage] forState:UIControlStateHighlighted];
        }
        navigationRightBtn.frame=CGRectMake(self.view.frame.size.width-chuMianUI_LeftClickPlace-chuMianUI_RightClickPlace-navigationRightBtn.currentImage.size.width/2, 0, chuMianUI_LeftClickPlace+chuMianUI_RightClickPlace+navigationRightBtn.currentImage.size.width/2, 44);
        navigationRightBtn.frame=CGRectMake(0, 0, chuMianUI_LeftClickPlace+chuMianUI_RightClickPlace+navigationRightBtn.currentImage.size.width/2, 44);
        navigationRightBtn.imageEdgeInsets=UIEdgeInsetsMake((navigationRightBtn.frame.size.height-navigationRightBtn.currentImage.size.height/2)/2, chuMianUI_LeftClickPlace, (navigationRightBtn.frame.size.height-navigationRightBtn.currentImage.size.height/2)/2,chuMianUI_RightClickPlace);
        
        if (title) {
            
    
            navigationRightBtn.frame = CGRectMake(self.view.frame.size.width-165/2, 0, 165/2, 43);
            [navigationRightBtn setTitleColor:chuMianUI_RightColor forState:UIControlStateNormal];
            [navigationRightBtn setTitle:title forState:UIControlStateNormal];
            [navigationRightBtn setTitleColor:chuMianUI_RightClickColor forState:UIControlStateHighlighted];
            navigationRightBtn.backgroundColor=[UIColor clearColor];
            [navigationRightBtn.titleLabel sizeToFit];
            navigationRightBtn.frame=CGRectMake(0, 0, navigationRightBtn.titleLabel.frame.size.width, navigationRightBtn.titleLabel.frame.size.height);
        }
        
        UIBarButtonItem *bar=[[UIBarButtonItem alloc] initWithCustomView:navigationRightBtn];
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        if (IOS7_OR_LATER) {
            negativeSpacer.width=-5;
        }else
        {
            negativeSpacer.width=3;
        }
        self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:negativeSpacer,bar, nil];
        
    }else
    {
        self.navigationItem.rightBarButtonItems=nil;
        
    }

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
-(void)BaseControllerClickNavRightButton:(id)sender
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
