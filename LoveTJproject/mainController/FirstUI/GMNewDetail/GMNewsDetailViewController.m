//
//  GMNewsDetailViewController.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMNewsDetailViewController.h"
#import "GMNewsDetailModel.h"
#import "GMNewsReplyView.h"
#import "GMCommonAndVideoView.h"
#import "textKeyBoardView.h"
#import "GMNewsReplySubModel.h"
@interface GMNewsDetailViewController ()<GMCommonAndVideoViewDelegate,GMNewsReplyViewDelegate,textKeyBoardViewDelegate,UIScrollViewDelegate>
{
    GMNewsDetailModel *detailModel;
    UIScrollView *scroller;
    GMNewsReplyView *replyView;
    GMCommonAndVideoView *commonAndVideoView;
    textKeyBoardView *keyBoardView;
}
@end

@implementation GMNewsDetailViewController
-(void)loadServerData
{
    [GMHttpRequest newsDetail:self.titleModel.newsID.integerValue usingSuccessBlock:^(BOOL isSuccess, GMNewsDetailModel *result) {
        if (isSuccess) {
            detailModel=result;
            [self reloadView];
            [self scrollViewDidScroll:scroller];
        }
    }];
}
-(void)createView
{
    if (!replyView) {
        replyView=[[GMNewsReplyView alloc]init];
        replyView.delegate=self;
    }
    if (!commonAndVideoView) {
        commonAndVideoView =[[GMCommonAndVideoView alloc]init];
        commonAndVideoView.delegateClcik=self;
    }
}
-(void)reloadView
{
    [self createView];
    if (![replyView isDescendantOfView:scroller]) {
        [scroller addSubview:replyView];
    }
    if (![commonAndVideoView isDescendantOfView:scroller]) {
        [scroller addSubview:commonAndVideoView];
        commonAndVideoView.backgroundColor=[UIColor clearColor];
    }
    commonAndVideoView.frame=CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height);
    replyView.frame=CGRectMake(scroller.frame.size.width, 0, scroller.frame.size.width, scroller.frame.size.height);
    [commonAndVideoView restView:detailModel];
    [replyView restHeadView:detailModel];
    [replyView reloadData:detailModel.newsID];
    scroller.contentSize=CGSizeMake(scroller.frame.size.width*2, scroller.frame.size.height);
}
- (void)viewDidLoad {
    [self showBackButton];
    scroller=[[UIScrollView alloc]init];
    scroller.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-NAVBARHIGHT(self)-textKeyBoardView_Default_Hight);
    scroller.delegate=self;
    scroller.backgroundColor=[UIColor clearColor];
    scroller.showsHorizontalScrollIndicator=NO;
    scroller.showsVerticalScrollIndicator=NO;
    scroller.pagingEnabled=YES;
    scroller.bounces=NO;
    [self.view addSubview:scroller];
    
    keyBoardView=[textKeyBoardView shar:self y:scroller.frame.size.height+scroller.frame.origin.y];
    [self.view addSubview:keyBoardView];
    [self setTextViewTitle:0];
    [keyBoardView setTextViewLocationTitle:@"点击获取地理位置"];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [super viewDidLoad];
    [self loadServerData];
    // Do any additional setup after loading the view.
}
-(void)setTextViewTitle:(NSInteger)index
{
    if (index==0) {
        if (!detailModel) {
            [keyBoardView setTextViewRigthTitle:[NSString stringWithFormat:@"%@评",self.titleModel.newsReplyCount]];
        }else
        {
            [keyBoardView setTextViewRigthTitle:[NSString stringWithFormat:@"%@评",detailModel.newsReplyCount]];
        }
    }
    if (index==1) {
        [keyBoardView setTextViewRigthTitle:@"原文"];
    }
}
-(void)textKeyBoardViewSendMessageForDefault:(NSString *)str info:(id)info
{
    if (str.length) {
        [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
    }
    [keyBoardView hiden];
}
-(void)textkeyBoardViewKeyboardClickLocation
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
-(void)textkeyBoardViewKeyboardClickRigthBtn
{
    int i=scroller.contentOffset.x/scroller.frame.size.width;
    if (i==0) {
        [keyBoardView show:nil];
    }else
    {
        [scroller setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int i=scroller.contentOffset.x/scroller.frame.size.width;
    [self setTextViewTitle:i];
}

#pragma common Video delegate
-(void)GMCommonAndVideoViewDelegateClickImage
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
-(void)GMCommonAndVideoViewDelegateClickAboutNewsIndex:(NSInteger)index
{
    if (detailModel.newsRelated.count>index) {
        GMNewsDetailViewController *newsDetailController=[[GMNewsDetailViewController alloc]init];
        newsDetailController.titleModel=[detailModel.newsRelated objectAtIndex:index];
        [self.navigationController pushViewController:newsDetailController animated:YES];
    }else
    {
        [CustomMethod showWaringMessage:NSLocalizedString(@"数据错误", nil)];
    }
    
}
-(void)GMCommonAndVideoViewDelegateClickPlayVideo
{
    
}
#pragma cell Delegate
-(void)GMNewsReplyViewDelegateClickAvatar:(GMNewsReplySubModel *)replyModel
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
-(void)GMNewsReplyViewDelegateClickLocation:(GMNewsReplySubModel *)replyModel
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}

-(void)GMNewsReplyViewDelegateClickCopy:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell
{
     [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待—copy", nil)];
   
}
-(void)GMNewsReplyViewDelegateClickParese:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待—顶", nil)];

}
-(void)GMNewsReplyViewDelegateClickReply:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell
{
     [replyView scrollerCell:cell ];
    [keyBoardView show:replyModel];
    [keyBoardView setTextViewPlaceTitle:[NSString stringWithFormat:@"回复:%@",replyModel.newsUserName]];
}
-(void)GMNewsReplyViewDelegateClickReport:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待—举报", nil)];

}
-(void)BaseClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
