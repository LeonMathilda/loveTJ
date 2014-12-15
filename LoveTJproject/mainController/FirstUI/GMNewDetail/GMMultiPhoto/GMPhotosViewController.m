//
//  GMPhotosViewController.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPhotosViewController.h"
#import "GMPhotoScrollView.h"
#import "GMPhoto.h"
#import "GMNewsReplyView.h"
#import "textKeyBoardView.h"
#import "GMNewsReplySubModel.h"
#define kPadding 10
@interface GMPhotosViewController ()<UIScrollViewDelegate,textKeyBoardViewDelegate,GMPhotoScrollViewDelegate,GMNewsReplyViewDelegate>
{
    UIStatusBarStyle barStyle;
    UIBarStyle navBarStyle;
    BOOL barHiden;
    BOOL navTranslucent;
    GMPhotoScrollView *scroller;
    NSMutableArray *list;
    GMNewsDetailModel *detailModel;
    textKeyBoardView *keyBoardView;
    GMNewsReplyView *replyView;
}
@end

@implementation GMPhotosViewController
-(void)loadView
{
    navTranslucent=self.navigationController.navigationBar.translucent;
    barStyle=[UIApplication sharedApplication].statusBarStyle;
    barHiden=[UIApplication sharedApplication].isStatusBarHidden;
    navBarStyle=self.navigationController.navigationBar.barStyle;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [super loadView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent=navTranslucent;
    [UIApplication sharedApplication].statusBarHidden=barHiden;
    [[UIApplication sharedApplication]setStatusBarStyle:barStyle animated:NO];
    [self.navigationController.navigationBar setBarStyle:navBarStyle];
    [super viewWillDisappear:animated];
}
-(void)loadServerData
{
    [GMHttpRequest newsDetailPhotos:0 usingSuccessBlock:^(BOOL isSuccess, GMNewsDetailModel *result) {
        if (isSuccess&&result.newsImages) {
            for (GMContentNewsScrollModel *model in result.newsImages) {
                GMPhoto *photo=[[GMPhoto alloc]init];
                photo.url=model.newsImagePath;
                photo.title=model.newsTitle;
                [list addObject:photo];
            }
            
            GMPhoto *photo=[[GMPhoto alloc]init];
            replyView=[[GMNewsReplyView alloc]init];
            replyView.frame=CGRectMake(0, 0, self.view.frame.size.width, scroller.frame.size.height);
            [replyView reloadData:result.newsID];
            [replyView restHeadView:result];
            replyView.delegate=self;
            photo.view=replyView;
            [list addObject:photo];
            [scroller show:list];
        }
    }];
}
- (void)viewDidLoad {
    list=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor blackColor];
    CGRect frame = self.view.frame;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);

    scroller=[[GMPhotoScrollView alloc]init];
    scroller.backgroundColor=[UIColor clearColor];
    scroller.frame=CGRectMake(0, 0, frame.size.width, frame.size.height-64-textKeyBoardView_Default_Hight);
    scroller.showsHorizontalScrollIndicator=NO;
    scroller.showsVerticalScrollIndicator=NO;
    scroller.delegateView=self;
    scroller.pagingEnabled=YES;
    scroller.padding=kPadding;
    [self.view addSubview:scroller];
    
    keyBoardView=[textKeyBoardView shar:self y:scroller.frame.size.height+scroller.frame.origin.y];
    [self.view addSubview:keyBoardView];
    [keyBoardView setTextViewLocationTitle:@"点击获取地理位置"];
    [self restTextRigthTitle:0];
    [self showBackButton];
    [super viewDidLoad];
    [self loadServerData];
    
    // Do any additional setup after loading the view.
}
-(void)restTextRigthTitle:(NSInteger)index
{
    if (index==list.count-1) {
        [keyBoardView setTextViewRigthTitle:@"原文"];
    }else
    {
        if (detailModel) {
            [keyBoardView setTextViewRigthTitle:[NSString stringWithFormat:@"%@评",detailModel.newsReplyCount]];
        }else
        {
            
            [keyBoardView setTextViewRigthTitle:[NSString stringWithFormat:@"%@评",self.titleModel.newsReplyCount]];
        }
        
    }

}

-(void)GMPhotoScrollViewDelegateIndex:(NSInteger)index
{
    [self restTextRigthTitle:index];
}
-(void)BaseClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma replyView
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
