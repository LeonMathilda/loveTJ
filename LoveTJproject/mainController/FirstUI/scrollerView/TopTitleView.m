//
//  TopTitleView.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "TopTitleView.h"

@implementation TopTitleView
-(id)init
{
    self=[super init];
    if (self) {
        scrollerView=[[TopTitleScrollerView alloc]init];
        scrollerView.showsHorizontalScrollIndicator=NO;
        scrollerView.showsVerticalScrollIndicator=NO;
        scrollerView.delegateSelect=self;
        scrollerView.pagingEnabled = YES;
        scrollerView.backgroundColor=[UIColor clearColor];
        [self addSubview:scrollerView];
        btnAdd=[UIButton buttonWithType:UIButtonTypeContactAdd];
        btnAdd.frame=CGRectMake(0, 0, 30, 0);
        [btnAdd addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnAdd];
    }
    return self;
}
-(void)clickAdd
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(TopTitleViewDelegateClickAdd)]) {
        [self.delegate TopTitleViewDelegateClickAdd];
    }
}
-(void)setFrame:(CGRect)frame
{
    scrollerView.frame=CGRectMake(0, 0, frame.size.width-btnAdd.frame.size.width, frame.size.height);
    btnAdd.frame=CGRectMake(frame.size.width-btnAdd.frame.size.width, 0, btnAdd.frame.size.width, frame.size.height);
    [super setFrame:frame];
}
-(void)restTopTitleView:(TopTitleModel *)model
{
    titleModel=model;
    [scrollerView restSource:model];
}
-(void)restTitleScrollSelect:(NSInteger )select
{
    [scrollerView restTitleScrollSelect:select];
}
-(void)titleResourceChange:(TopTitleModel *)model
{
    [scrollerView titleResourceChange:model];
}
-(void)TopTitleScrollerViewDelegate:(NSInteger)index
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(TopTitleViewDelegateClickIndex:)]) {
        [self.delegate TopTitleViewDelegateClickIndex:index];
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
