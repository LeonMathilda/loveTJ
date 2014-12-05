//
//  HomePageViewController.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "HomePageViewController.h"
#import "TopTitleScrollerView.h"
#import "TopTitleModel.h"
#import "TopTitleView.h"
@interface HomePageViewController ()<UIScrollViewDelegate,TopTitleViewDelegate>
{
    TopTitleView *titleView;
    ContentScrollView *contentScroll;
    BOOL mNeedUseDelegate;
}
@end

@implementation HomePageViewController

-(void)restSource
{
    TopTitleModel *topModel=[[TopTitleModel alloc]init];
    for (int i=0; i<10; i++) {
        TopTitleSubListModel *subModel=[[TopTitleSubListModel alloc]init];
        subModel.titID=[NSString stringWithFormat:@"%i",i+1];
        subModel.title=[NSString stringWithFormat:@"标题%d",i+1];
        [topModel.list addObject:subModel];
    }
    [titleView restTopTitleView:topModel];
    [contentScroll restContentView:topModel];
    
}
- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];
    titleView=[[TopTitleView alloc]init];
    titleView.frame=CGRectMake(0, 20, self.view.frame.size.width, 40);
    titleView.backgroundColor=[UIColor lightGrayColor];
    titleView.delegate=self;
    [self.view addSubview:titleView];
    
    contentScroll=[[ContentScrollView alloc]initWithFrame:CGRectMake(0, titleView.frame.size.height+titleView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-titleView.frame.size.height-titleView.frame.origin.y)];
    contentScroll.pagingEnabled = YES;
    contentScroll.showsHorizontalScrollIndicator=NO;
    contentScroll.showsVerticalScrollIndicator=NO;
    contentScroll.delegate=self;
    [self.view addSubview:contentScroll];
    
    [self restSource];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (mNeedUseDelegate) {
        float  x= contentScroll.contentOffset.x;
        int i=x/self.view.frame.size.width;
        [titleView restTitleScrollSelect:i];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    mNeedUseDelegate=YES;
}
-(void)TopTitleViewDelegateClickIndex:(NSInteger)index
{

    mNeedUseDelegate=NO;
    [contentScroll setContentOffset:CGPointMake(index*contentScroll.frame.size.width, 0) animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
    [super viewWillDisappear:animated];
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
