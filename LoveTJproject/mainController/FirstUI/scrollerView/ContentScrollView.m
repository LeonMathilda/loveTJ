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
        [self initData];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}
-(void)initData
{
    if (!list) {
        list=[[NSMutableArray alloc]init];
    }
}
-(void)restContentView:(TopTitleModel *)model
{
    [list removeAllObjects];
    for(UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (TopTitleSubListModel *Submodel in  model.list) {
        [list addObject:[self createContentNewsView:Submodel]];
    }
    [self restContentViewFrame];
}
-(void)restContentViewFrame
{
    self.contentSize=CGSizeMake(self.frame.size.width+1, self.frame.size.height);
    float x=0;
    for (ContentNewsView *view in list) {
        if (![view isDescendantOfView:self]) {
            [self addSubview:view];
        }
        view.frame=CGRectMake(x,0 , self.frame.size.width, self.frame.size.height);
        x=view.frame.size.width+view.frame.origin.x;
    }
     self.contentSize=CGSizeMake(MAX(x, self.frame.size.width+1), self.frame.size.height);
}
-(ContentNewsView *)createContentNewsView:(TopTitleSubListModel *)model
{
    ContentNewsView *contentView=[[ContentNewsView alloc]init];
    contentView.frame=CGRectMake(0,0 , self.frame.size.width, self.frame.size.height);
    [contentView restModel:model];
    return contentView;
}
-(void)reloadContentViewIndex:(NSInteger )index
{
    if (list.count>index) {
        ContentNewsView *contentView=[list objectAtIndex:index];
        [contentView restLoadData];
    }
}
-(void)restHeadData:(NSMutableArray *)listData
{
    for (ContentNewsView *view in list) {
        [view  restHeadData:listData];
    }
}
-(void)ResourceChange:(TopTitleModel *)model
{
    for (ContentNewsView *view in list) {
        [view removeFromSuperview];
    }
    NSMutableArray *newBtnList=[NSMutableArray arrayWithCapacity:0];
    for (TopTitleSubListModel *subModel  in model.list) {
        BOOL has=NO;
        for (ContentNewsView *view in list) {
            
            if ([[view SubModel].title  isEqualToString:subModel.title]) {
                [newBtnList addObject:view];
                has=YES;
                break;
            }
        }
        if (!has) {
            [newBtnList addObject:[self createContentNewsView:subModel]];
        }
    }
    [list removeAllObjects];
    [list addObjectsFromArray:newBtnList];
    [self restContentViewFrame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
