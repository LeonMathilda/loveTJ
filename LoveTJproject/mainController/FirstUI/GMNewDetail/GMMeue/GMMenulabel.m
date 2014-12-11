//
//  GMMenulabel.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMMenulabel.h"

@implementation GMMenulabel
-(id)init
{
    if (self=[super init]) {
        [self initData];
    }
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)initData
{
    _menuItems              = [[NSMutableArray array]init];
    _touchuBackgroundHighlightColor=[UIColor lightGrayColor];
    _oldBackgroundColor=[UIColor clearColor];
}
-(void)addLongPressed
{
    if (!self.gestureRecognizers.count) {
        
        UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressed:)];
        press.minimumPressDuration=0.3;
        [self addGestureRecognizer:press];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(menuHiden) name:UIMenuControllerWillHideMenuNotification object:Nil];
    }
}
-(void)menuHiden
{
    self.backgroundColor=_oldBackgroundColor;
}
-(void)showMenuItem:(NSArray *)menuItemList
{
    [_menuItems removeAllObjects];
    if (menuItemList&&menuItemList.count) {
        [_menuItems  addObjectsFromArray:menuItemList];
    }
    _oldBackgroundColor=self.backgroundColor;
    self.userInteractionEnabled=YES;
    [self addLongPressed];
}
-(void)longPressed:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state==UIGestureRecognizerStateBegan) {
        self.backgroundColor=_touchuBackgroundHighlightColor;
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:_menuItems];
        [menu setTargetRect:self.bounds inView: self];
        [menu setMenuVisible:YES animated:YES];
    }
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    NSMutableArray *list=[NSMutableArray array];
    for (UIMenuItem *menu in _menuItems) {
        if (menu.action) {
            [list addObject:NSStringFromSelector(menu.action)];
        }
    }
    if ([list containsObject:NSStringFromSelector(action)]) {
        return YES;
    }
    return NO;
}
-(void)WillmenuHiden
{
    if ([UIDevice currentDevice].systemVersion.floatValue>=7)
    {
        if ([self canBecomeFirstResponder])
        {
            if ([self isFirstResponder])
            {
                [self resignFirstResponder];
            }
        }
        UIMenuController *menu = [UIMenuController sharedMenuController];
        if ([menu isMenuVisible])  {
            [menu setMenuVisible:NO animated:YES];
        }
    }
}
- (BOOL)canBecomeFirstResponder{
    
    return YES;
    
}
-(GMmenuItem *)getMenuItemClick:(SEL )sel
{
    for (id menu  in _menuItems) {
        if ([menu isKindOfClass:[GMmenuItem class]]&&((GMmenuItem*)menu).action==sel) {
            return menu;
        }
    }
    return nil;
}
-(void)menuItemClick:(SEL)sel
{
    
    GMmenuItem *menu=[self getMenuItemClick:sel];
    if (menu) {
        [menu.tager performSelector:sel];
    }
}
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature=[self  methodSignatureForSelector:@selector(menuItemClick:)];
        return signature;
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL selector = [invocation selector];
    if ([self respondsToSelector:selector]) {
        [invocation invokeWithTarget:self];
    }else
    {
        [self menuItemClick:invocation.selector];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
