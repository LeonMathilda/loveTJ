//
//  GMContentNewsDefaultView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMContentNewsDefaultView.h"
#import "GMContentNewsCell.h"
#import "GMContentNewsButtomView.h"
@implementation GMContentNewsDefaultView
-(void)restModel:(GMContentNewsModel *)model
{
    
    UIImageView *iamgeView=[[UIImageView alloc]init];
    iamgeView.contentMode=UIViewContentModeScaleAspectFill;
    iamgeView.clipsToBounds=YES;
    [iamgeView setImageURL:[NSURL URLWithString:model.newsHeadPath] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
    iamgeView.frame=CGRectMake(GMContentNewsCell_Default_left, GMContentNewsCell_Default_Top, GMContentNewsCell_Default_image, GMContentNewsCell_Default_image);
    [self addSubview:iamgeView];

    
    UILabel *title=[[UILabel alloc]init];
    title.backgroundColor=[UIColor clearColor];
    title.font=GMContentNewsCell_TitleFont;
    title.textColor=[UIColor blackColor];
    title.frame=CGRectMake(iamgeView.frame.size.width+iamgeView.frame.origin.x+5 , iamgeView.frame.origin.x , [UIScreen mainScreen].bounds.size.width-iamgeView.frame.size.width-iamgeView.frame.origin.x-5-GMContentNewsCell_Default_left, iamgeView.frame.size.height/3);
    title.text=model.newsTitle;
    [self addSubview:title];
    
    UILabel *content=[[UILabel alloc]init];
    content.backgroundColor=[UIColor clearColor];
    content.font=GMContentNewsCell_ContentFont;
    content.textColor=[UIColor lightGrayColor];
    content.frame=CGRectMake(title.frame.origin.x , title.frame.size.height+title.frame.origin.y , title.frame.size.width, 0);
    content.numberOfLines=2;
    content.text=model.newsContent;
    [content sizeToFit];
    content.frame=CGRectMake(content.frame.origin.x, content.frame.origin.y, title.frame.size.width, MIN(content.frame.size.height,iamgeView.frame.size.height-title.frame.size.height));
    [self addSubview:content];
    
    GMContentNewsButtomView *buttomView=[[GMContentNewsButtomView alloc]init];
    buttomView.backgroundColor=[UIColor clearColor];
    [buttomView restModel:model];
    buttomView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-150-GMContentNewsCell_Default_left, iamgeView.frame.size.height+iamgeView.frame.origin.x-15, 150, 20);
    [self addSubview:buttomView];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
