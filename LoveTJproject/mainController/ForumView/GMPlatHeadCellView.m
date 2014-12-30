//
//  GMPlatHeadCellView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/30.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPlatHeadCellView.h"

@implementation GMPlatHeadCellView
-(void)restView:(NSString *)title show:(BOOL)showRight isOpen:(BOOL)isOpen
{
    [CustomMethod removeSubview:self];
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(9, 0, self.frame.size.width, 34);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    
    [self addSubview:label];
    label.text=title;
    if (showRight) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=2000;
        btn.frame=CGRectMake(self.frame.size.width-10-15, 0, 15, 15);
        btn.center=CGPointMake(btn.center.x, self.frame.size.height/2);
        btn.clipsToBounds=YES;
        [btn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self showRight:isOpen animation:NO];
    }
}
-(void)showRight:(BOOL)isOpen animation:(BOOL)animation
{
    if ([self viewWithTag:2000]) {
        UIButton *btn=(UIButton *)[self viewWithTag:2000];
        if (isOpen) {
            btn.backgroundColor=[UIColor lightGrayColor];
        }else
        {
            btn.backgroundColor=[UIColor darkGrayColor];
        }
    }
}
-(void)clickView:(UIButton *)btn
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMPlatHeadCellViewClickView:)]) {
        [self.delegate GMPlatHeadCellViewClickView:self];
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
