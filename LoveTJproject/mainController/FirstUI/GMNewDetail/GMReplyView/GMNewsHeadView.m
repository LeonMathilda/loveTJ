//
//  GMNewsHeadView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMNewsHeadView.h"
#import "GMCommonAndVideoView.h"
@implementation GMNewsHeadView
-(void)restHeadView:(GMNewsDetailModel *)model
{
    [CustomMethod removeSubview:self];
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(GMCommonAndVideoView_leftPlace, GMCommonAndVideoView_TopPlace, self.frame.size.width-GMCommonAndVideoView_leftPlace*2, 40);
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont boldSystemFontOfSize:20];
    title.textColor=[UIColor blackColor];
    title.textAlignment=NSTextAlignmentLeft;
    title.text=model.newsTitle;
    [self addSubview:title];
    
    UILabel *sourceLabel=[[UILabel alloc]init];
    sourceLabel.frame=CGRectMake(title.frame.origin.x, title.frame.size.height+title.frame.origin.y, title.frame.size.width, 20);
    sourceLabel.backgroundColor=[UIColor clearColor];
    sourceLabel.font=[UIFont systemFontOfSize:14];
    sourceLabel.textColor=[UIColor lightGrayColor];
    sourceLabel.text=[NSString stringWithFormat:@"%@%@%@",model.newsSourse?[NSString stringWithFormat:@"%@  ",model.newsSourse]:@"",model.newsTime?[NSString stringWithFormat:@"%@  ",model.newsTime]:@"",model.newsReplyCount?[NSString stringWithFormat:@"%@评论",model.newsReplyCount]:@""];
    [self addSubview:sourceLabel];
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.5;
    line.frame=CGRectMake(title.frame.origin.x, sourceLabel.frame.size.height+sourceLabel.frame.origin.y+10, title.frame.size.width, 0.5);
    [self addSubview:line];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, line.frame.size.height+line.frame.origin.y);
}
@end
