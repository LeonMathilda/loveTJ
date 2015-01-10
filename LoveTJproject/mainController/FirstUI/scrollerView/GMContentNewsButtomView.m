//
//  GMContentNewsButtomView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMContentNewsButtomView.h"
#import "GMContentNewsCell.h"
@implementation GMContentNewsButtomView
-(id)init
{
    if (self=[super init]) {
        title=[[UILabel alloc]init];
        title.backgroundColor=[UIColor clearColor];
        title.textColor=[UIColor lightGrayColor];
        title.textAlignment=NSTextAlignmentRight;
        title.font=GMContentNewsCell_ContentFont;
        [self addSubview:title];
        
        titleClase=[[UILabel alloc]init];
        titleClase.backgroundColor=[UIColor clearColor];
        titleClase.textColor=[UIColor redColor];
        titleClase.textAlignment=NSTextAlignmentCenter;
        titleClase.font=GMContentNewsCell_ContentFont;
        titleClase.layer.borderColor=[[UIColor darkGrayColor]CGColor];
        titleClase.layer.borderWidth=0.5;
        
        [self addSubview:titleClase];
        
    }
    return self;
}
-(void)restModel:(GMContentNewsModel *)model;
{
    titleClase.frame=CGRectMake(0, 0, 0, 0);
    if (model.newsClass&&model.newsClass.length&&![model.newsClass isEqualToString:@"无"]) {
         titleClase.text=model.newsClass;
        [titleClase sizeToFit];
        titleClase.frame=CGRectMake(0, 0, titleClase.frame.size.width+3, titleClase.frame.size.height+3);
    }
    NSString  *str=[NSString stringWithFormat:@"%@%@",model.newsImageCount?[NSString stringWithFormat:@"%@图  ",model.newsImageCount]:@"",model.newsReplyCount?[NSString stringWithFormat:@"%@评论",model.newsReplyCount]:@""];
    title.text=str;
    [title sizeToFit];
    [self restFrame:self.frame];
}
-(void)restFrame:(CGRect)frame
{
    titleClase.frame=CGRectMake(frame.size.width-titleClase.frame.size.width, 0, titleClase.frame.size.width, titleClase.frame.size.height);
    titleClase.center=CGPointMake(titleClase.center.x, frame.size.height/2);
    
    title.frame=CGRectMake(titleClase.frame.origin.x-title.frame.size.width-4 , 0, title.frame.size.width, title.frame.size.height);
    title.center=CGPointMake(title.center.x, frame.size.height/2);
}
-(void)setFrame:(CGRect)frame
{
    [self restFrame:frame];
    [super setFrame:frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
