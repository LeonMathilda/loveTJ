//
//  TopTitleScrollerView.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "TopTitleScrollerView.h"

@implementation TopTitleScrollerView
-(id)init
{
    if (self=[super init]) {
        
        btnList=[[NSMutableArray alloc]init];
        bgView=[[UIView alloc]init];
        bgView.backgroundColor=[UIColor darkGrayColor];
        bgView.layer.cornerRadius=10;
        bgView.layer.masksToBounds=YES;
        bgView.frame=CGRectMake(0, 0, 60, 30);
        bgView.opaque=0.6;
        [self addSubview:bgView];
    }
    return self;
}
-(void)restSource:(TopTitleModel *)titleModel
{
    
    [btnList removeAllObjects];
    for (UIView *view  in self.subviews) {
        if (![view isKindOfClass:[bgView class]]) {
            [view removeFromSuperview];
        }
    }
    self.contentSize=CGSizeMake(self.frame.size.width+1, self.frame.size.height);
    float x=0;
    NSInteger index=0;
    for (TopTitleSubListModel *model in titleModel.list) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(x, 0, 60, self.frame.size.height);
        [btn setTitle:model.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        x=btn.frame.size.width+btn.frame.origin.x;
        [btnList addObject:btn];
        if ([model.titID isEqualToString:currentSelectedModel.titID]) {
            index=[titleModel.list indexOfObject:model];
        }
    }
    if (btnList.count) {
        [self clickBtn:[btnList objectAtIndex:index]];
    }
    self.contentSize=CGSizeMake(MAX(x, self.frame.size.width+1), self.frame.size.height);
}
-(void)btnDefaultColor:(UIColor*)color
{
    for (UIButton *btn in btnList) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}
-(void)moveBgView:(CGRect)rect anmation:(BOOL)anmation
{
    if (anmation) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.15];
        bgView.frame=rect;
        [UIView commitAnimations];
    }else
    {
        bgView.frame=rect;
    }
    if (rect.origin.x<self.contentOffset.x) {
        [self setContentOffset:CGPointMake(rect.origin.x, 0) animated:YES];
    }else if (rect.origin.x+rect.size.width>self.contentOffset.x+self.frame.size.width) {
        [self setContentOffset:CGPointMake(MIN(self.contentSize.width-self.frame.size.width, rect.origin.x+rect.size.width-self.frame.size.width),0) animated:YES];
    }
}
-(void)shouldMove:(UIButton *)btn delegate:(BOOL)sendDelegaet
{
    [self btnDefaultColor:[UIColor blackColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGRect bgFrect=CGRectMake(btn.frame.origin.x+(btn.frame.size.width-bgView.frame.size.width)/2, (btn.frame.size.height-bgView.frame.size.height)/2, bgView.frame.size.width, bgView.frame.size.height);
    [self moveBgView:bgFrect anmation:YES];
    
    if (sendDelegaet&&self.delegateSelect&&[self.delegateSelect respondsToSelector:@selector(TopTitleScrollerViewDelegate:)]) {
        [self.delegateSelect TopTitleScrollerViewDelegate:[btnList indexOfObject:btn]];
    }

}
-(void)clickBtn:(UIButton *)btn
{

    [self shouldMove:btn delegate:YES];
}
-(void)restTitleScrollSelect:(NSInteger )select
{
    if (btnList.count>select) {
        [self shouldMove:[btnList objectAtIndex:select] delegate:NO];
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
