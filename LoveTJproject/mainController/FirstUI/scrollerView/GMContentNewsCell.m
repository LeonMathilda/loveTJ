//
//  GMContentNewsCell.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/6.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMContentNewsCell.h"
#import "GMContentImagesView.h"
#import "GMContentNewsDefaultView.h"
@implementation GMContentNewsCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        line=[[UIView alloc]init];
        line.frame=CGRectMake(GMContentNewsCell_Default_left, 0, [UIScreen mainScreen].bounds.size.width-GMContentNewsCell_Default_left, 0.5);
        line.backgroundColor=[UIColor lightGrayColor];
        line.alpha=0.5;
        [self addSubview:line];
    }
    return self;
}
-(void)restModel:(GMContentNewsModel *)model
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (model.newsImages.count) {
        GMContentImagesView *imagesView=[[GMContentImagesView alloc]init];
        [imagesView restModel:model];
        imagesView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [GMContentNewsCell cellHight:model]);
        [self.contentView addSubview:imagesView];
    }else
    {
        GMContentNewsDefaultView *defaultView=[[GMContentNewsDefaultView alloc]init];
        [defaultView restModel:model];
        defaultView.backgroundColor=[UIColor clearColor];
        defaultView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [GMContentNewsCell cellHight:model]);
        [self.contentView addSubview:defaultView];
    }
}
+(float)cellHight:(GMContentNewsModel *)model
{
    if (model.newsImages.count) {
        return GMContentNewsCell_images_Top*2+GMContentNewsCell_images_Width;
    }else
    {
        return GMContentNewsCell_Default_Top*2+GMContentNewsCell_Default_image;
    }
}
-(void)layoutSubviews
{
    line.frame=CGRectMake(line.frame.origin.x, self.frame.size.height-line.frame.size.height, line.frame.size.width, line.frame.size.height);
    [super layoutSubviews];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
