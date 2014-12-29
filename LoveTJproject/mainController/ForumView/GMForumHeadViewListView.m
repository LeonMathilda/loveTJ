//
//  GMForumHeadViewListView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/29.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMForumHeadViewListView.h"
#import "GMContentNewsScrollModel.h"
@implementation GMForumHeadViewListView
-(void)restList:(NSMutableArray *)list
{
    [CustomMethod removeSubview:self];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(9, 9, self.frame.size.width-18, 0);
    view.backgroundColor=[UIColor colorWithRed:144.0f/255.0f green:144.0f/255.0f blue:144.0f/255.0f alpha:0.2];
    [self addSubview:view];
    for (int i=0; i<list.count; i++) {
        GMContentNewsScrollModel *model=[list objectAtIndex:i];
        UIButton *btn=[[UIButton alloc]init];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        btn.frame=CGRectMake(view.frame.size.width/2*(i%2),35*(i/2), view.frame.size.width/2, 35);
        [btn setTitle:model.newsTitle forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
//        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:btn];
        view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, btn.frame.size.height+btn.frame.origin.y);
        if (i%2==1) {
            UIView *line=[[UIView alloc]init];
            line.frame=CGRectMake(btn.frame.size.width, btn.frame.origin.y+6, 0.5, btn.frame.size.height-12);
            line.backgroundColor=[UIColor lightGrayColor];
            [view addSubview:line];
        }
        if (i%2==0&&i<list.count-2) {
            UIView *line=[[UIView alloc]init];
            line.frame=CGRectMake(0, btn.frame.origin.y+btn.frame.size.height, view.frame.size.width, 0.5);
            line.backgroundColor=[UIColor lightGrayColor];
            [view addSubview:line];
        }
    }
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, view.frame.size.height+view.frame.origin.y+9);
}
-(void)click:(UIButton *)btn
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMForumHeadViewListViewClickIndex:)]) {
        [self.delegate GMForumHeadViewListViewClickIndex:btn.tag-100];
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
