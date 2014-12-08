//
//  GMCommonAndVideoView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMCommonAndVideoView.h"
#import "GMRelatedNews.h"
#define GMCommonAndVideoView_leftPlace 10
#define GMCommonAndVideoView_TopPlace 10
#define GMCommonAndVideoView_MaxImageHight 250
@interface GMCommonAndVideoView()<GMRelatedNewsDelegate,ALMoviePlayerControllerDelegate>
{
    CGRect defaultFrame;
    UIImageView *topVideoImage;
}
@end
@implementation GMCommonAndVideoView
-(void)dealloc
{
    [self.moviePlayer stop];
    self.moviePlayer=nil;
}
-(void)createPlayer:(CGRect)frame
{
    if (self.moviePlayer) {
        return;
    }
    self.moviePlayer = [[ALMoviePlayerController alloc] initWithFrame:frame];
    self.moviePlayer.view.alpha = 1.0;
    self.moviePlayer.delegate = self;
    
    //create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:self.moviePlayer style:ALMoviePlayerControlsStyleDefault];
    [movieControls setBarColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [movieControls setTimeRemainingDecrements:YES];
    [movieControls setBarHeight:45.f];
    [self.moviePlayer setControls:movieControls];
    [self addSubview:self.moviePlayer.view];
}
-(void)restView:(GMNewsDetailModel *)model
{
    [CustomMethod removeSubview:self];
    UILabel *title=[[UILabel alloc]init];
    title.frame=CGRectMake(GMCommonAndVideoView_leftPlace, GMCommonAndVideoView_TopPlace, self.frame.size.width-GMCommonAndVideoView_leftPlace*2, 40);
    title.backgroundColor=[UIColor clearColor];
    title.font=[UIFont boldSystemFontOfSize:20];
    title.textColor=[UIColor blackColor];
    title.textAlignment=NSTextAlignmentLeft;
    title.text=model.newsTitle;
    [self addSubview:title];
    
    UILabel *sourceLabel=[[UILabel alloc]init];
    sourceLabel.frame=CGRectMake(title.frame.origin.x, title.frame.size.height+title.frame.origin.y, title.frame.size.width, 20);
    sourceLabel.backgroundColor=[UIColor clearColor];
    sourceLabel.font=[UIFont systemFontOfSize:14];
    sourceLabel.textColor=[UIColor lightGrayColor];
    sourceLabel.text=[NSString stringWithFormat:@"%@%@%@",model.newsSourse?[NSString stringWithFormat:@"%@  ",model.newsSourse]:@"",model.newsTime?[NSString stringWithFormat:@"%@  ",model.newsTime]:@"",model.newsReplyCount?[NSString stringWithFormat:@"%@评论",model.newsReplyCount]:@""];
    [self addSubview:sourceLabel];
    
    UIView *line=[[UIView alloc]init];
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.5;
    line.frame=CGRectMake(title.frame.origin.x, sourceLabel.frame.size.height+sourceLabel.frame.origin.y+10, title.frame.size.width, 0.5);
    [self addSubview:line];
    float y=line.frame.size.height+line.frame.origin.y+20;
    if (model.newsType==GMNewsDetailType_common&&model.newsTopImage) {
        UIImageView *topImage=[[UIImageView alloc]init];
        topImage.frame=CGRectMake(GMCommonAndVideoView_leftPlace, y, title.frame.size.width, GMCommonAndVideoView_MaxImageHight);
        topImage.contentMode=UIViewContentModeScaleAspectFill;
        topImage.clipsToBounds=YES;
        [topImage setImageURL:[NSURL URLWithString:model.newsTopImage] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
        [topImage addGestureRecognizer:tap];
        [self addSubview:topImage];
        y=topImage.frame.size.height+topImage.frame.origin.y+20;
    }
    if (model.newsType==GMNewsDetailType_video&&model.newsVidelUrl) {
        [self cancelPlay];
        topVideoImage=[[UIImageView alloc]init];
        topVideoImage.frame=CGRectMake(GMCommonAndVideoView_leftPlace, y, title.frame.size.width, GMCommonAndVideoView_MaxImageHight);
        topVideoImage.contentMode=UIViewContentModeScaleAspectFill;
        topVideoImage.clipsToBounds=YES;
        [topVideoImage setImageURL:[NSURL URLWithString:model.newsVideoImage] placeholder:[UIImage imageNamed:GMDefaultImageLoading]];
        
        UIButton *playView=[UIButton buttonWithType:UIButtonTypeCustom];
        [playView setBackgroundImage:[UIImage imageNamed:@"gm_play.jpg"] forState:UIControlStateNormal];
        
        playView.frame=CGRectMake(0, 0, 70, 70);
        playView.center=CGPointMake(topVideoImage.frame.size.width/2, topVideoImage.frame.size.height/2);
        [topVideoImage addSubview:playView];
        [playView addTarget:self action:@selector(clickPlay) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:topVideoImage];
        defaultFrame=topVideoImage.frame;
        y=topVideoImage.frame.size.height+topVideoImage.frame.origin.y+20;
    }
    UILabel *content=[[UILabel alloc]init];
    content.frame=CGRectMake(title.frame.origin.x, y, title.frame.size.width, 0);
    content.backgroundColor=[UIColor clearColor];
    content.font=[UIFont systemFontOfSize:15];
    content.textColor=[UIColor lightGrayColor];
    content.numberOfLines=0;
    content.text=model.newsContent;
    [self addSubview:content];
    [content sizeToFit];
    content.frame=CGRectMake(content.frame.origin.x, content.frame.origin.y, title.frame.size.width, content.frame.size.height);
    GMRelatedNews *relatedNews=[[GMRelatedNews alloc]init];
    relatedNews.frame=CGRectMake(title.frame.origin.x, content.frame.size.height+content.frame.origin.y+20, title.frame.size.width, 0);
    relatedNews.delegate=self;
    [relatedNews restRelatedNews:model.newsRelated];
    [self addSubview:relatedNews];
    
    self.contentSize=CGSizeMake(self.frame.size.width, MAX(self.frame.size.height+1, relatedNews.frame.size.height+relatedNews.frame.origin.y+20));
}
-(void)cancelPlay
{
    topVideoImage.hidden=NO;
    [self.moviePlayer stop];
    self.moviePlayer.view.hidden=YES;
}
-(void)showPlay
{
    topVideoImage.hidden=YES;
    self.moviePlayer.view.hidden=NO;
}
-(void)clickImage
{
    if (self.delegateClcik&&[self.delegateClcik respondsToSelector:@selector(GMCommonAndVideoViewDelegateClickImage)]) {
        [self.delegateClcik GMCommonAndVideoViewDelegateClickImage];
    }
}
- (void)localFile {
    [self.moviePlayer stop];
    [self.moviePlayer setContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"popeye" ofType:@"mp4"]]];
    [self.moviePlayer play];
}
-(void)clickPlay
{

    [self createPlayer:defaultFrame];
    [self showPlay];
    [self localFile];
//    if (self.delegateClcik&&[self.delegateClcik respondsToSelector:@selector(GMCommonAndVideoViewDelegateClickPlayVideo)]) {
//        [self.delegateClcik GMCommonAndVideoViewDelegateClickPlayVideo];
//    }
}
-(void)GMRelatedNewsDelegateClickIndex:(NSInteger)index
{
    if (self.delegateClcik&&[self.delegateClcik respondsToSelector:@selector(GMCommonAndVideoViewDelegateClickAboutNewsIndex:)]) {
        [self.delegateClcik GMCommonAndVideoViewDelegateClickAboutNewsIndex:index];
    }
}
- (void)movieTimedOut {
    [self cancelPlay];
}
- (void)moviePlayerWillMoveFromWindow {
    if (![self.subviews containsObject:self.moviePlayer.view])
    {
        [self addSubview:self.moviePlayer.view];
    }
    [self.moviePlayer setFrame:defaultFrame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
