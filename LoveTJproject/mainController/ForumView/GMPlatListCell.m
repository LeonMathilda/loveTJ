//
//  GMPlatListCell.m
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "GMPlatListCell.h"
#define cell_left 10
#define cell_top 10
#define cell_image_hight 40
#define cell_place_image 10
#define cell_image_title 16
#define cell_title_higth 20
#define cell_right_place 7.5
#define cell_imageList_place 3
#define cell_content_font [UIFont systemFontOfSize:13]
#define cell_pirase_place 15
#define cell_pirase_higth 20

@implementation GMPlatListCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        line.alpha=0.5;
        [self addSubview:line];
    }
    return self;
}
-(void)restCell:(GMPlatListSubList *)subModel
{
    float placeX=cell_left;
    float placeY=cell_top;
    [CustomMethod removeSubview:self.contentView];
    UIImageView *headImage=[[UIImageView alloc]init];
    headImage.clipsToBounds=YES;
    headImage.layer.cornerRadius=5;
    headImage.frame=CGRectMake(placeX, placeY+cell_place_image, cell_image_hight, cell_image_hight);
    [headImage setImageURL:[NSURL URLWithString:subModel.platUserAvatar] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
    [headImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAvatar)]];
    [self.contentView addSubview:headImage];
    
    UILabel *name=[[UILabel alloc]init];
    name.frame=CGRectMake(headImage.frame.size.width+headImage.frame.origin.x+placeX, headImage.frame.origin.y, [UIScreen mainScreen].bounds.size.width-headImage.frame.size.width-headImage.frame.origin.x-placeX-cell_right_place, headImage.frame.size.height/2);
    name.backgroundColor=[UIColor clearColor];
    name.font=[UIFont systemFontOfSize:15];
    name.textColor=[UIColor blackColor];
    [self.contentView addSubview:name];
    name.text=subModel.PlatUserName;
    
    UILabel *time=[[UILabel alloc]init];
    time.frame=CGRectMake(headImage.frame.size.width+headImage.frame.origin.x+placeX, name.frame.origin.y+name.frame.size.height, [UIScreen mainScreen].bounds.size.width-headImage.frame.size.width-headImage.frame.origin.x-placeX-cell_right_place, headImage.frame.size.height/2);
    time.backgroundColor=[UIColor clearColor];
    time.font=[UIFont systemFontOfSize:12];
    time.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:time];
    time.text=subModel.platUserTime;
    
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(headImage.frame.origin.x, headImage.frame.size.height+headImage.frame.origin.y+cell_image_title, [UIScreen mainScreen].bounds.size.width-cell_left-cell_right_place, cell_title_higth);
    title.backgroundColor=[UIColor clearColor];
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:15];
    title.text=subModel.platTitle;
    [self.contentView addSubview:title];
    
    UILabel *content=[[UILabel alloc]init];
    content.frame=CGRectMake(headImage.frame.origin.x, title.frame.size.height+title.frame.origin.y+cell_top, [UIScreen mainScreen].bounds.size.width-cell_left-cell_right_place, [GGUtil  text:subModel.platContent sizeWithFont:cell_content_font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-cell_left-cell_right_place, MAXFLOAT) ].height);
    content.backgroundColor=[UIColor clearColor];
    content.textColor=[UIColor blackColor];
    content.numberOfLines=0;
    content.font=cell_content_font;
    content.text=subModel.platContent;
    [self.contentView addSubview:content];
    
    float y=content.frame.size.height+content.frame.origin.y;
    if (subModel.platImageList.count) {
        float width=([UIScreen mainScreen].bounds.size.width-cell_left-cell_right_place-cell_imageList_place*2)/3;
        float x=cell_left;
        for (int i=0; i<3; i++) {
            if (subModel.platImageList.count>i) {
                UIImageView *image=[[UIImageView alloc]init];
                image.contentMode=UIViewContentModeScaleAspectFill;
                image.clipsToBounds=YES;
                [image setImageURL:[NSURL URLWithString:[subModel.platImageList objectAtIndex:i]] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
                image.frame=CGRectMake(x, content.frame.size.height+content.frame.origin.y+cell_top , width, width);
                [self.contentView addSubview:image];
                x=image.frame.size.width+image.frame.origin.x+cell_imageList_place;
                y=image.frame.size.height+image.frame.origin.y;
            }
        }
    }
    
    UIButton *reply=[UIButton buttonWithType:UIButtonTypeCustom];
    reply.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-60-cell_right_place, y+cell_pirase_place, 60, cell_pirase_higth);
    [reply setImage:[UIImage imageNamed:@"luntan_pinglun_@2x"] forState:UIControlStateNormal];
    
    reply.imageEdgeInsets=UIEdgeInsetsMake(0, 0,0,reply.frame.size.width- cell_pirase_higth);
    reply.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    reply.backgroundColor=[UIColor clearColor];
    [reply setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [reply setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [reply setTitle:@"回复" forState:UIControlStateNormal];
    reply.titleLabel.font=[UIFont systemFontOfSize:16];
    reply.titleLabel.textAlignment=NSTextAlignmentLeft;
    [reply addTarget:self action:@selector(clickReply) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:reply];
    
    
    UIButton *piase=[UIButton buttonWithType:UIButtonTypeCustom];
    piase.frame=CGRectMake(reply.frame.origin.x-reply.frame.size.width-10, reply.frame.origin.y, reply.frame.size.width, reply.frame.size.height);
    piase.imageEdgeInsets=reply.imageEdgeInsets;
    [piase setImage:[UIImage imageNamed:@"luntan_dianzan_@2x"] forState:UIControlStateNormal];
    piase.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    piase.backgroundColor=[UIColor clearColor];
    [piase setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [piase setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [piase setTitle:@"赞" forState:UIControlStateNormal];
    piase.titleLabel.font=[UIFont systemFontOfSize:16];
    piase.titleLabel.textAlignment=NSTextAlignmentLeft;
    [piase addTarget:self action:@selector(clickPiase) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:piase];
    
}
+(float)cellHigth:(GMPlatListSubList *)subModel
{
    float width=subModel.platImageList.count?([UIScreen mainScreen].bounds.size.width-cell_left-cell_right_place-cell_imageList_place*2)/3:0;
    float higth=cell_top+cell_place_image+cell_image_hight+cell_image_title+cell_title_higth+cell_top+[GGUtil text:subModel.platContent  sizeWithFont:cell_content_font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-cell_left-cell_right_place, MAXFLOAT) ].height+cell_top+width+cell_pirase_place+cell_pirase_higth;
    return higth+cell_top;;
}
-(void)clickAvatar
{
    
}
-(void)clickReply
{
    
}
-(void)clickPiase
{
    
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)layoutSubviews
{
    line.frame=CGRectMake(cell_left, self.frame.size.height-0.5, self.frame.size.width-cell_left, 0.5);
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
