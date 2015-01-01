//
//  GMPlatListController.m
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "GMPlatListController.h"
#import "GMPlatListModel.h"
#import "GMPlatListHeadView.h"
#import "GMPlatListCell.h"
@interface GMPlatListController ()<UITableViewDataSource,UITableViewDelegate>
{
    GMPlatListModel *listModel;
    UITableView *mTableView;
    GMPlatListHeadView *headView;
    
}
@end

@implementation GMPlatListController
-(void)loadServerData
{
    [GMHttpRequest getPlatList:self.subModel.platID.integerValue usingSuccessBlock:^(BOOL isSuccess, GMPlatListModel *result) {
        if (isSuccess) {
            listModel=result;
            [self reloadData];
        }
    }];
}
-(void)reloadData
{
    [self restTableViewHeadView];
    [mTableView reloadData];
    
}
-(void)restTableViewHeadView
{
    [headView restView:listModel];
    mTableView.tableHeaderView=headView;
}
-(void)BaseClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [self showBackButton];
    self.title=self.subModel.title;
    self.view.backgroundColor=[UIColor whiteColor];
    mTableView=[[UITableView alloc]init];
    mTableView.backgroundColor=[UIColor clearColor];
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.delegate=self;
    mTableView.dataSource=self;
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(IOS7_OR_LATER?64:44));
    [self.view addSubview:mTableView];
    headView=[[GMPlatListHeadView alloc]init];
    headView.frame=CGRectMake(0, 0, self.view.frame.size.width, 0);
    [super viewDidLoad];
    [self loadServerData];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listModel.platList.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GMPlatListCell cellHigth:[listModel.platList objectAtIndex:indexPath.row]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMPlatListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"platCell"];
    if (!cell) {
        cell=[[GMPlatListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"platCell"];
    }
    [cell restCell:[listModel.platList objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
