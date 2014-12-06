//
//  GMContentImagesView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMContentImagesView.h"
#import "GMContentNewsCell.h"
#import "GMContentNewsButtomView.h"
@implementation GMContentImagesView
-(void)restModel:(GMContentNewsModel *)model
{
    UILabel *title=[[UILabel alloc]init];
    title.backgroundColor=[UIColor clearColor];
    title.font=GMContentNewsCell_TitleFont;
    title.textColor=[UIColor blackColor];
    title.frame=CGRectMake(GMContentNewsCell_Default_left, 0, [UIScreen mainScreen].bounds.size.width, GMContentNewsCell_images_Top);
    title.text=model.newsTitle;
    float x=GMContentNewsCell_Default_left;
    [self addSubview:title];
    for (int i=0; i<3; i++) {
        if (model.newsImages.count>i) {
            UIImageView *iamgeView=[[UIImageView alloc]init];
            iamgeView.contentMode=UIViewContentModeScaleAspectFill;
            iamgeView.clipsToBounds=YES;
            [iamgeView setImageURL:[NSURL URLWithString:[model.newsImages objectAtIndex:i]] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
            iamgeView.frame=CGRectMake(x, GMContentNewsCell_images_Top, GMContentNewsCell_images_Width, GMContentNewsCell_images_Width);
            [self addSubview:iamgeView];
            x=iamgeView.frame.size.width+iamgeView.frame.origin.x+GMContentNewsCell_images_place;
        }
       
    }
    GMContentNewsButtomView *buttomView=[[GMContentNewsButtomView alloc]init];
    buttomView.backgroundColor=[UIColor clearColor];
    [buttomView restModel:model];
    buttomView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-150-GMContentNewsCell_Default_left, GMContentNewsCell_images_Top+GMContentNewsCell_images_Width, 150, GMContentNewsCell_images_Top);
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
