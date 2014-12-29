//
//  GMForumHeadView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/29.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMForumHeadView.h"

@implementation GMForumHeadView
-(id)init
{
    if (self=[super init]) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView
{
    headVIew=[[ScrollImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ScrollView_HIGHT)];
    [self addSubview:headVIew];
    
    subTitleView=[[GMForumHeadViewListView alloc]init];
    subTitleView.delegate=self;
    subTitleView.frame=CGRectMake(0, headVIew.frame.size.height+headVIew.frame.origin.y, headVIew.frame.size.width, 0);
    [self addSubview:subTitleView];
    
}
-(void)restLunBoView:(NSMutableArray *)list
{
    [headVIew SetImageList:list];
    [self restFrame];
}
-(void)restSubView:(NSMutableArray *)list
{
    [subTitleView restList:list];
    [self restFrame];
}
-(void)restFrame
{
    self.frame=CGRectMake(0, 0, self.frame.size.width, subTitleView.frame.size.height+subTitleView.frame.origin.y);
}
-(void)GMForumHeadViewListViewClickIndex:(NSInteger)index
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMForumHeadViewSubTitleClickIndex:)]) {
        [self.delegate GMForumHeadViewSubTitleClickIndex:index];
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
