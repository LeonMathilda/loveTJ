//
//  ContentScrollView.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ContentScrollView.h"
#import "ContentNewsView.h"
@implementation ContentScrollView
-(id)init
{
    if (self=[super init]) {
        list=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)restContentView:(TopTitleModel *)model
{
    [list removeAllObjects];
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.contentSize=CGSizeMake(self.frame.size.width+1, self.frame.size.height);
    float x=0;
    for (TopTitleSubListModel *Submodel in  model.list) {
        ContentNewsView *contentView=[[ContentNewsView alloc]init];
        contentView.frame=CGRectMake(x,0 , self.frame.size.width, self.frame.size.height);
        [contentView restModel:Submodel];
        [self addSubview:contentView];
        x=contentView.frame.size.width+contentView.frame.origin.x;
        [list addObject:contentView];
    }
    self.contentSize=CGSizeMake(MAX(x, self.frame.size.width+1), self.frame.size.height);

}
-(void)reloadContentViewIndex:(NSInteger )index
{
    if (list.count>index) {
        ContentNewsView *contentView=[list objectAtIndex:index];
        [contentView restLoadData];
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
