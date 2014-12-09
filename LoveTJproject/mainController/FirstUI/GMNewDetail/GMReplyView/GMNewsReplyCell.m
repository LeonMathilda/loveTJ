//
//  GMNewsReplyCell.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMNewsReplyCell.h"
#define GMNewsReplyCell_topPlace 20
#define GMNewsReplyCell_leftPlace 9
#define GMNewsReplyCell_avatarHight 40
#define GMNewsReplyCell_avatar_contentPlace 10

#define GMNewsReplyCell_content_loactionPlace 10

#define GMNewsReplyCell_loactionHigth 15

#define GMNewsReplyCell_buttomPlace 10

#define GMNewsReplyCell_contentFont [UIFont systemFontOfSize:14]
@implementation GMNewsReplyCell
-(void)restCell:(GMNewsReplySubModel *)model
{
    self.contentView.backgroundColor=[UIColor whiteColor];
    [CustomMethod removeSubview:self.contentView];
    UIImageView *headView=[[UIImageView alloc]init];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAvatar)];
    [headView addGestureRecognizer:tap];
    headView.frame=CGRectMake(GMNewsReplyCell_leftPlace*2, GMNewsReplyCell_topPlace, GMNewsReplyCell_avatarHight, GMNewsReplyCell_avatarHight);
    headView.contentMode=UIViewContentModeScaleAspectFill;
    headView.layer.masksToBounds=YES;
    headView.layer.cornerRadius=8;
    [headView setImageURL:[NSURL URLWithString:model.newsUserAvatar] placeholder:nil];
    [self.contentView addSubview:headView];
    
    float contentWidth=[UIScreen mainScreen].bounds.size.width-GMNewsReplyCell_leftPlace*5-GMNewsReplyCell_avatarHight;
    UILabel *name=[[UILabel alloc]init];
    name.frame=CGRectMake(headView.frame.size.width+headView.frame.origin.x+GMNewsReplyCell_leftPlace,headView.frame.origin.y, contentWidth, 0);
    name.backgroundColor=[UIColor clearColor];
    name.font=[UIFont systemFontOfSize:15];
    name.textColor=[UIColor blackColor];
    name.text=model.newsUserName;
    name.numberOfLines=1;
    [name sizeToFit];
    name.frame=CGRectMake(name.frame.origin.x, name.frame.origin.y, contentWidth, name.frame.size.height);
    [self.contentView addSubview:name];
    
    
    UILabel *source=[[UILabel alloc]init];
    source.frame=CGRectMake(headView.frame.size.width+headView.frame.origin.x+GMNewsReplyCell_leftPlace,headView.frame.origin.y, contentWidth, 0);
    source.backgroundColor=[UIColor clearColor];
    source.font=[UIFont systemFontOfSize:14];
    source.textColor=[UIColor lightGrayColor];
    source.text=[NSString stringWithFormat:@"%@%@",model.newsUserSourece?[NSString stringWithFormat:@"%@  ",model.newsUserSourece]:@"",model.newsReplyTime?model.newsReplyTime:@""];
    source.numberOfLines=1;
    [source sizeToFit];
    source.frame=CGRectMake(source.frame.origin.x, headView.frame.origin.y+headView.frame.size.height-source.frame.size.height, contentWidth, source.frame.size.height);
    [self.contentView addSubview:source];
    
    UILabel *content=[[UILabel alloc]init];
    content.numberOfLines=0;
    content.frame=CGRectMake(name.frame.origin.x, headView.frame.size.height+headView.frame.origin.y+GMNewsReplyCell_avatar_contentPlace, contentWidth, [GGUtil text:model.newsReplyContent sizeWithFont:GMNewsReplyCell_contentFont constrainedToSize:CGSizeMake(contentWidth,MAXFLOAT)].height);
    content.backgroundColor=[UIColor clearColor];
    content.textColor=[UIColor blackColor];
    content.text=model.newsReplyContent;
    content.font=GMNewsReplyCell_contentFont;
    [self.contentView addSubview:content];
    
    float y=content.frame.size.height+content.frame.origin.y;
    if (model.newsReplyLoaction) {
        UILabel *location=[[UILabel alloc]init];
        location.font=[UIFont systemFontOfSize:12];
        location.frame=CGRectMake(name.frame.origin.x, content.frame.size.height+content.frame.origin.y+GMNewsReplyCell_content_loactionPlace, contentWidth, GMNewsReplyCell_loactionHigth);
        location.backgroundColor=[UIColor clearColor];
        location.text=model.newsReplyLoaction;
        location.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:location];
        y=location.frame.size.height+location.frame.origin.y;
        location.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapLocation=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLocation)];
        [location addGestureRecognizer:tapLocation];
    }
    UIView *line=[[UIView alloc]init];
    line.frame=CGRectMake(headView.frame.origin.x, y+GMNewsReplyCell_buttomPlace-0.5, [UIScreen mainScreen].bounds.size.width-GMNewsReplyCell_leftPlace*4, 0.5);
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.5;
    [self.contentView addSubview:line];
}
+(float)cellHight:(GMNewsReplySubModel *)model
{
    float higth=GMNewsReplyCell_topPlace+GMNewsReplyCell_avatarHight+GMNewsReplyCell_avatar_contentPlace;
    float contentWidth=[UIScreen mainScreen].bounds.size.width-GMNewsReplyCell_leftPlace*5-GMNewsReplyCell_avatarHight;
    if (model.newsReplyContent ) {
        higth+=[GGUtil text:model.newsReplyContent sizeWithFont:GMNewsReplyCell_contentFont constrainedToSize:CGSizeMake(contentWidth,MAXFLOAT)].height;
    }
    if (model.newsReplyLoaction) {
        higth+=(GMNewsReplyCell_loactionHigth+GMNewsReplyCell_content_loactionPlace);
    }
    higth+=GMNewsReplyCell_buttomPlace;
    return higth;
}
-(void)clickAvatar
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyCellDelegateClickAvatar:)]) {
        [self.delegate GMNewsReplyCellDelegateClickAvatar:self];
    }
}
-(void)clickLocation
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyCellDelegateClickLoaction:)]) {
        [self.delegate GMNewsReplyCellDelegateClickLoaction:self];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
