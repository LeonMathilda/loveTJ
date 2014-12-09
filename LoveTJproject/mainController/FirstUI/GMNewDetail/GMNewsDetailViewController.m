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
@interface GMNewsDetailViewController ()<GMCommonAndVideoViewDelegate,GMNewsReplyViewDelegate>
{
    GMNewsDetailModel *detailModel;
    UIScrollView *scroller;
    GMNewsReplyView *replyView;
    GMCommonAndVideoView *commonAndVideoView;
    
}
@end

@implementation GMNewsDetailViewController
-(void)loadServerData
{
    [GMHttpRequest newsDetail:self.titleModel.newsID.integerValue usingSuccessBlock:^(BOOL isSuccess, GMNewsDetailModel *result) {
        if (isSuccess) {
            detailModel=result;
            [self reloadView];
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
    scroller.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-NAVBARHIGHT(self));
    NSLog(@"%@",NSStringFromCGRect(self.navigationController.navigationBar.frame));
    scroller.backgroundColor=[UIColor clearColor];
    scroller.showsHorizontalScrollIndicator=NO;
    scroller.showsVerticalScrollIndicator=NO;
    scroller.pagingEnabled=YES;
    scroller.bounces=NO;
    [self.view addSubview:scroller];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [super viewDidLoad];
    [self loadServerData];
    // Do any additional setup after loading the view.
}
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
-(void)GMNewsReplyViewDelegateClickAvatar:(GMContentNewsModel *)replyModel
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
-(void)GMNewsReplyViewDelegateClickLocation:(GMContentNewsModel *)replyModel
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
-(void)GMCommonAndVideoViewDelegateClickPlayVideo
{
    
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
