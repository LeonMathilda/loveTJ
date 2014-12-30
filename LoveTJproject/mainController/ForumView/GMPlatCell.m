//
//  GMPlatCell.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/30.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPlatCell.h"
#define cell_Higth 44+10+9
@implementation GMPlatCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)restView:(GMPlateSubModel*)subModel
{
    [CustomMethod removeSubview:self.contentView ];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.clipsToBounds=YES;
    imageView.frame=CGRectMake(9, 5, 44, 44);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [imageView setImageURL:[NSURL URLWithString:subModel.image] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
    [self.contentView addSubview:imageView];
    
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+5, imageView.frame.origin.y, [UIScreen mainScreen].bounds.size.width-imageView.frame.size.width-imageView.frame.origin.x-10, 20);
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont systemFontOfSize:18];
    title.textColor=[UIColor blackColor];
    title.text=subModel.title;
    [self.contentView addSubview:title];
    
    UILabel *content=[[UILabel alloc]init];
    content.backgroundColor=[UIColor clearColor];
    content.textColor=[UIColor lightGrayColor];
    content.font=[UIFont systemFontOfSize:15];
    content.frame=CGRectMake(title.frame.origin.x, imageView.frame.size.height+imageView.frame.origin.y-(18-9), title.frame.size.width, 18);
    content.text=subModel.subTitle;
    [self.contentView addSubview:content];
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.5;
    line.frame=CGRectMake(title.frame.origin.x, cell_Higth, [UIScreen mainScreen].bounds.size.width-title.frame.origin.x, 0.5);
    [self.contentView addSubview:line];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(float)cellHigth:(GMPlateSubModel *)subModel
{
    return cell_Higth;
}
@end
