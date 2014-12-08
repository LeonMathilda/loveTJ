//
//  GMRelatedNews.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMRelatedNews.h"
#import "GMContentNewsModel.h"
@implementation GMRelatedNews
-(UIView *)createAboutView:(GMContentNewsModel *)model y:(float)y tag:(NSInteger)tag
{
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, y, self.frame.size.width, 55);
    view.backgroundColor=[UIColor clearColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 2, view.frame.size.width, view.frame.size.height-4);
    [btn addTarget:self action:@selector(clickAboutNews:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[CustomMethod createImageWithColor:[UIColor lightGrayColor] size:btn.frame.size] forState:UIControlStateHighlighted];
    [view addSubview:btn];
    btn.tag=tag;
    
    
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(0, 5, view.frame.size.width,20);
    title.backgroundColor=[UIColor clearColor];
    title.textColor=[UIColor darkGrayColor];
    title.font=[UIFont systemFontOfSize:16];
    title.text=model.newsTitle;
    [btn addSubview:title];
    title.userInteractionEnabled=NO;
    
    UILabel *content=[[UILabel alloc]init];
    content.frame=CGRectMake(0, title.frame.size.height+title.frame.origin.y, view.frame.size.width,20);
    content.backgroundColor=[UIColor clearColor];
    content.textColor=[UIColor darkGrayColor];
    content.font=[UIFont systemFontOfSize:10];
    content.text=[NSString stringWithFormat:@"%@%@",model.newsSourece?[NSString stringWithFormat:@"%@  ",model.newsSourece]:@"",model.newsTime?model.newsTime:@""];
    content.userInteractionEnabled=NO;
    [btn addSubview:content];
    
    UIView *line=[[UIView alloc]init];
    line.frame=CGRectMake(0, view.frame.size.height-0.5, view.frame.size.width,0.5 );
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.5;
    [view addSubview:line];
    
    [self addSubview:view];
    return view;
}
-(void)restRelatedNews:(NSMutableArray *)newsList
{
    float y=0;
    [CustomMethod removeSubview:self];
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(0, y, self.frame.size.width,40);
    title.backgroundColor=[UIColor lightGrayColor];
    title.textColor=[UIColor darkGrayColor];
    title.font=[UIFont systemFontOfSize:17];
    title.text=@"相关新闻";
    [self addSubview:title];
    y=title.frame.size.height+title.frame.origin.y;
    y+=2;
    for (GMContentNewsModel *model in newsList) {
        UIView *view=[self createAboutView:model y:y tag:100+[newsList indexOfObject:model]];
        y=view.frame.size.height+view.frame.origin.y;
    }
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
}
-(void)clickAboutNews:(UIButton *)btn
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMRelatedNewsDelegateClickIndex:)]) {
        [self.delegate GMRelatedNewsDelegateClickIndex:btn.tag-100];
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
