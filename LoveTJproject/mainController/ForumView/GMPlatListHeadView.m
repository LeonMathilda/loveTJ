//
//  GMPlatListHeadView.m
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "GMPlatListHeadView.h"

@implementation GMPlatListHeadView
-(void)restView:(GMPlatListModel *)platModel
{
    [CustomMethod removeSubview:self];
    float placeX=10;
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.clipsToBounds=YES;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.frame=CGRectMake(placeX, placeX, 80, 80);
    [imageView setImageURL:[NSURL URLWithString:platModel.platImage] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
    [self addSubview:imageView];
    
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(imageView.frame.size.width+imageView.frame.origin.x+placeX, imageView.frame.origin.y, self.frame.size.width-imageView.frame.size.width-imageView.frame.origin.x-placeX-7.5, 25);
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont systemFontOfSize:18];
    title.textColor=[UIColor blackColor];
    title.text=platModel.platTitle;
    [self addSubview:title];
    
    UILabel *follow=[[UILabel alloc]init];
    follow.backgroundColor=[UIColor clearColor];
    follow.font=[UIFont systemFontOfSize:10];
    follow.textColor=[UIColor lightGrayColor];
    follow.frame=CGRectMake(title.frame.origin.x, title.frame.size.height+title.frame.origin.y+5, 100, 0);
    follow.numberOfLines=1;
    follow.text=@"关注";
    [follow sizeToFit];
    follow.frame=CGRectMake(title.frame.origin.x, title.frame.size.height+title.frame.origin.y+5, follow.frame.size.width, follow.frame.size.height);
    [self addSubview:follow];
    
    UILabel *floolwCount=[[UILabel alloc]init];
    floolwCount.backgroundColor=[UIColor clearColor];
    floolwCount.font=[UIFont systemFontOfSize:12];
    floolwCount.textColor=[UIColor redColor];
    floolwCount.frame=CGRectMake(title.frame.origin.x, title.frame.size.height+title.frame.origin.y, 100, 0);
    floolwCount.numberOfLines=1;
    floolwCount.text=platModel.platFlowNum;
    [floolwCount sizeToFit];
    floolwCount.frame=CGRectMake(follow.frame.origin.x+follow.frame.size.width+3, follow.frame.size.height+follow.frame.origin.y-floolwCount.frame.size.height, floolwCount.frame.size.width, floolwCount.frame.size.height);
    [self addSubview:floolwCount];
    
    
    UILabel *plat=[[UILabel alloc]init];
    plat.backgroundColor=[UIColor clearColor];
    plat.font=follow.font;
    plat.textColor=[UIColor lightGrayColor];
    plat.frame=CGRectMake(floolwCount.frame.origin.x+floolwCount.frame.size.width+40, follow.frame.origin.y, follow.frame.size.width, follow.frame.size.height);
    plat.numberOfLines=1;
    plat.text=@"帖子";
    [self addSubview:plat];
    
    UILabel *platCount=[[UILabel alloc]init];
    platCount.backgroundColor=[UIColor clearColor];
    platCount.font=floolwCount.font;
    platCount.textColor=[UIColor redColor];
    platCount.frame=CGRectMake(plat.frame.origin.x, plat.frame.size.height+plat.frame.origin.y, 100, 0);
    platCount.numberOfLines=1;
    platCount.text=platModel.platNum;
    [platCount sizeToFit];
    platCount.frame=CGRectMake(plat.frame.origin.x+plat.frame.size.width+3, plat.frame.size.height+plat.frame.origin.y-platCount.frame.size.height, platCount.frame.size.width, platCount.frame.size.height);
    [self addSubview:platCount];
    
    UIButton *btnFolow=[UIButton buttonWithType:UIButtonTypeCustom];
    btnFolow.frame=CGRectMake(title.frame.origin.x, imageView.frame.size.height+imageView.frame.origin.y-30, 100, 30);
    btnFolow.clipsToBounds=YES;
    btnFolow.layer.cornerRadius=5;
    [btnFolow setBackgroundImage:[CustomMethod createImageWithColor:[UIColor  colorWithRed:226.0f/255.0f green:60.0f/255.0f blue:10.0f/255.0f alpha:1] size:btnFolow.frame.size] forState:UIControlStateNormal];
    [btnFolow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnFolow.titleLabel.font=[UIFont systemFontOfSize:16];
    [btnFolow setTitle:platModel.platIsFollowing.boolValue?@"取消关注":@"+ 关注" forState:UIControlStateNormal];
    [btnFolow addTarget:self action:@selector(clickFollowing) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnFolow];
    
    float y=imageView.frame.size.height+imageView.frame.origin.y+placeX;
    float btnPlace=7.5f;
    if (platModel.platHasNotice.boolValue) {
        UIImageView *noticeImage=[[UIImageView alloc]init];
        noticeImage.frame=CGRectMake(imageView.frame.origin.x, y+btnPlace, 27.5, 27.5);
        noticeImage.backgroundColor=[UIColor blueColor];
        [self addSubview:noticeImage];
        
        UIButton *noticeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        noticeButton.frame=CGRectMake(noticeImage.frame.size.width+noticeImage.frame.origin.x+5, noticeImage.frame.origin.y, self.frame.size.width-noticeImage.frame.origin.x-noticeImage.frame.size.width-7.5-5, noticeImage.frame.size.height);
        noticeButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        noticeButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [noticeButton setTitle:@"本吧公告" forState:UIControlStateNormal];
        [noticeButton setTitleColor:GM_HIGHTTEXT_COLOR forState:UIControlStateNormal];
        [noticeButton addTarget:self action:@selector(clickNotice) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:noticeButton];
        y=noticeButton.frame.size.height+noticeButton.frame.origin.y+btnPlace;
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        line.alpha=0.5;
        line.frame=CGRectMake(imageView.frame.origin.x, y, self.frame.size.width, 0.5);
        [self addSubview:line];
    }
    
    for (GMPlatListTopListModel *topbList in platModel.platTopList) {
        UILabel *top=[[UILabel alloc]init];
        top.backgroundColor=[UIColor clearColor];
        top.font=[UIFont systemFontOfSize:15];
        top.frame=CGRectMake(imageView.frame.origin.x, y+btnPlace, 100, 18);
        top.numberOfLines=1;
        top.textColor=GM_HIGHTTEXT_COLOR;
        top.text=@"置顶";
        [top sizeToFit];
        [self addSubview:top];
        top.frame=CGRectMake(imageView.frame.origin.x, y+btnPlace, top.frame.size.width, 18);
        
        UIButton *topButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        topButton.frame=CGRectMake(top.frame.size.width+top.frame.origin.x+10, y, self.frame.size.width-top.frame.origin.x-top.frame.size.width-7.5-10, top.frame.size.height+btnPlace*2);
        topButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        topButton.titleLabel.font=[UIFont systemFontOfSize:16];
        [topButton setTitle:topbList.platTitle forState:UIControlStateNormal];
        [topButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [topButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        topButton.tag=100+[platModel.platTopList indexOfObject:topbList];
        topButton.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [topButton addTarget:self action:@selector(clickTop:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topButton];
        y=topButton.frame.size.height+topButton.frame.origin.y;
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        line.alpha=0.5;
        line.frame=CGRectMake(imageView.frame.origin.x, y, self.frame.size.width, 0.5);
        [self addSubview:line];

    }
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y+placeX);
    
}
-(void)clickFollowing
{
    
}
-(void)clickNotice
{
    
}
-(void)clickTop:(UIButton *)btn
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
