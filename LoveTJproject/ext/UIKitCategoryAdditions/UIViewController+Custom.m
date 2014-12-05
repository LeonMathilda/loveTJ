//
//  UIViewController+Custom.m
//  hepaimusic
//
//  Created by Ron on 13-7-27.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//

#import "UIViewController+Custom.h"

static voidBlock backBlock;
static voidBlock leftBlock;
static voidBlock rightBlock;
static voidBlock rightBlock2;
static UIButton *inputEndBtn;

@implementation UIViewController(Custom)


#pragma mark -
#pragma mark ==================== NavigationItem =====================
- (void)configNavigationBackItem:(voidBlock)backAction{
    backBlock = backAction;
    //   LeftItemSupplementBackButton
    
    if (isIOS7) {
        
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_title_back"] style:UIBarButtonItemStylePlain target:self action:@selector(press2Back:)]];
//        [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    }else {
        UIView *backBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 44)];
        backBtnView.backgroundColor = [UIColor clearColor];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"button_back_white_navigation"] forState:UIControlStateNormal];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        backBtn.bounds = CGRectMake(0, 0, 48, 44);
        [backBtn addTarget:self action:@selector(press2Back:) forControlEvents:UIControlEventTouchUpInside];
        [backBtnView addSubview:backBtn];
        backBtn.center = CGPointMake(backBtnView.frame.size.width/2-2, backBtnView.frame.size.height/2);
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backBtnView]];
        
    }
}
- (void)configNavigationBackItemRed:(voidBlock)backAction{
    backBlock = backAction;
    //   LeftItemSupplementBackButton
    
    if (isIOS7) {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button_back_navigation"] style:UIBarButtonItemStylePlain target:self action:@selector(press2Back:)]];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    }else {
        UIView *backBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 44)];
        backBtnView.backgroundColor = [UIColor clearColor];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"button_back_navigation"] forState:UIControlStateNormal];
        [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        backBtn.bounds = CGRectMake(0, 0, 48, 44);
        [backBtn addTarget:self action:@selector(press2Back:) forControlEvents:UIControlEventTouchUpInside];
        [backBtnView addSubview:backBtn];
        backBtn.center = CGPointMake(backBtnView.frame.size.width/2-2, backBtnView.frame.size.height/2);
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backBtnView]];
    }
}

- (void)configNavigationLeftItemWithString:(NSString*)text andAction:(voidBlock)action
{
    leftBlock = action;
    UIBarButtonItem *barButtonItem;
    if (isIOS7) {
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:@selector(pressLeft:)];
        [barButtonItem setTintColor:[UIColor whiteColor]];
    }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressLeft:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:text forState:UIControlStateNormal];
        [button sizeToFit];
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    self.navigationItem.leftBarButtonItem = barButtonItem;
}




- (void)configNavigationRightItemWithStringNoEnable:(NSString*)text andAction:(voidBlock)action
{
    rightBlock = action;
    UIBarButtonItem *barButtonItem;
    if (isIOS7) {
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:nil];
//        barButtonItem.
        
        [barButtonItem setEnabled:NO];
        [barButtonItem setTintColor:[UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0]];
    }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setEnabled:NO];
        [button addTarget:self action:@selector(pressRight:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:text forState:UIControlStateNormal];
        [button sizeToFit];
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)configNavigationRightItemWithString:(NSString*)text andAction:(voidBlock)action
{
    rightBlock = action;
    UIBarButtonItem *barButtonItem;
    if (isIOS7) {
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
        [barButtonItem setTintColor:[UIColor whiteColor]];
    }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressRight:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:text forState:UIControlStateNormal];
        [button sizeToFit];
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)configNavigationLeftItemWithImage:(UIImage*)image andAction:(voidBlock)action
{
    leftBlock = action;
    UIBarButtonItem *barButtonItem;
    if (isIOS7) {
        barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(pressLeft:)];
        [barButtonItem setTintColor:[UIColor whiteColor]];
    }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressLeft:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        [button setContentEdgeInsets:UIEdgeInsetsMake(2, 10, 2, 10)];
        [button sizeToFit];
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)configNavigationRightItemWithImage:(UIImage*)image andAction:(voidBlock)action
{
    rightBlock = action;
    UIBarButtonItem *barButtonItem;
    if (isIOS7) {
        barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
//        [barButtonItem setTintColor:[UIColor whiteColor]];
    }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressRight:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        [button setContentEdgeInsets:UIEdgeInsetsMake(2, 10, 2, 10)];
        [button sizeToFit];
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
- (void)configNavigationRightItemWithImages:(UIImage*)image :(UIImage*)image2 andAction:(voidBlock)action :(voidBlock)action2
{
    rightBlock = action;
    rightBlock2 = action2;
    NSMutableArray *rightButtons = [[NSMutableArray alloc] init];
    UIBarButtonItem *barButtonItem;
    UIBarButtonItem *barButtonItem2;
    if (isIOS7) {
        barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(pressRight:)];
//        [barButtonItem setTintColor:[UIColor redColor]];
        
        barButtonItem2 = [[UIBarButtonItem alloc] initWithImage:image2  style:UIBarButtonItemStyleDone target:self action:@selector(pressRight1:)];
//        [barButtonItem2 setTintColor:[UIColor redColor]];
        [rightButtons addObject:barButtonItem2];
        [rightButtons addObject:barButtonItem];
      }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pressRight:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        [button setContentEdgeInsets:UIEdgeInsetsMake(2, 10, 2, 10)];
        [button sizeToFit];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(pressRight1:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setImage:image forState:UIControlStateNormal];
        [button1 setContentEdgeInsets:UIEdgeInsetsMake(2, 10, 2, 10)];
        [button1 sizeToFit];

        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    }
    self.navigationItem.rightBarButtonItems =rightButtons ;
}
- (void)setNavigationBarTitle:(NSString*)title
{
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.text = title;
    self.navigationItem.titleView = titleView;
}

#pragma mark -
#pragma mark ==================== Keyboard =====================
- (void)configKeyboard{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [inputEndBtn removeFromSuperview];
    }];

}

- (void)removeObsever
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyBoradDidShow:(NSNotification*)note{
    NSDictionary *info=[note userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [inputEndBtn removeFromSuperview];
    inputEndBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    inputEndBtn.frame=CGRectMake(kbRect.size.width-25, kbRect.origin.y-25, 24,24);
    [inputEndBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
    [inputEndBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    [inputEndBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:inputEndBtn];
}

- (void)putOnNavigationBarWithRedCoat
{
//    if (self.navigationController) {
//        UIView *redView = [UIView new];
//        redView.frame = CGRectMake(0, 0, self.view.frame.size.width, isIOS7 ? STATUS_NAV_HEIGHT : NAVBAR_HEIGHT);
////        redView.backgroundColor = RedColor4NavigationBar;
////        UIImage *navBg = [GGUtil makeAShotWithView:redView];
//        if(isIOS7){
//            [self.navigationController.navigationBar setBackgroundImage:navBg forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//            [self.navigationController.navigationBar setTranslucent:NO];
//        }
//        else {
//            [self.navigationController.navigationBar setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];            
//            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//        }
//    }
}

#pragma mark -
#pragma mark ==================== User Action =====================
- (void)press2Back:(id)sender{
    if (backBlock) {
        backBlock();
    }
}

- (void)pressLeft:(id)sender{
    if (leftBlock) {
        leftBlock();
    }
}

- (void)pressRight:(id)sender{
    if (rightBlock) {
        rightBlock();
    }
}
- (void)pressRight1:(id)sender
{
    if (rightBlock2) {
        rightBlock2();
    }
}

-(void)finishAction{
    [self.view endEditing:YES];
}

@end
