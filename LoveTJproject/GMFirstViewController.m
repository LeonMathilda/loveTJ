//
//  GMFirstViewController.m
//  LoveTJproject
//
//  Created by 李昂 on 14-9-9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMFirstViewController.h"
#import "GMmainLoginViewViewController.h"
#import "GMForumModel.h"
#import "GMContentNewsCell.h"
#import "GMForumHeadView.h"

@interface GMFirstViewController ()<UITableViewDataSource,UITableViewDelegate,GMForumHeadViewDelegate>
{
    UISegmentedControl *_segmentedControl;
    UITableView *mTableView;
    NSMutableArray *list;
    GMForumHeadView *headView;
}
@end

@implementation GMFirstViewController

- (void)viewDidLoad
{
    list=[[NSMutableArray alloc]init];
    mTableView=[[UITableView alloc]init];
    mTableView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.toolbar.frame.size.height);
    mTableView.delegate=self;
    mTableView.backgroundColor=[UIColor clearColor];
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.dataSource=self;
    [self.view addSubview:mTableView];
    self.view.backgroundColor=[UIColor whiteColor];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"热点",@"板块", nil]];
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = [UIColor lightGrayColor];
    _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [_segmentedControl addTarget:self action:@selector(SelectCourseType) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
    [super viewDidLoad];
    ;
    headView=[[GMForumHeadView alloc]init];
    headView.frame=CGRectMake(0, 0, self.view.frame.size.width, ScrollView_HIGHT);
    headView.clipsToBounds=YES;
    headView.delegate=self;
    headView.backgroundColor=[UIColor clearColor];
    [self restmTableView];
    
    [self SelectCourseType];
	// Do any additional setup after loading the view, typically from a nib.
//    GMmainLoginViewViewController *GMmainLoginVC = [[GMmainLoginViewViewController alloc] initWithNibName:@"GMmainLoginViewViewController" bundle:nil];
//    [self.navigationController pushViewController:GMmainLoginVC animated:YES];
//    [self.navigationController presentViewController: animated:YES completion:^{
    
//    }];

}
-(void)SelectCourseType
{
    [self loadData];
    [self loadHeadViewData];
}
-(NSInteger)getSelectID
{
    if (_segmentedControl.selectedSegmentIndex==0) {
        return 0;
    }
    return 0;
}
-(void)restmTableView
{
    mTableView.tableHeaderView=headView;
    mTableView.tableHeaderView.frame=CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height);
}
-(void)loadHeadViewData
{
    [GMHttpRequest getForumLunBoList:[self getSelectID] usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
        if (isSuccess) {
            [headView restLunBoView:result];
            [self restmTableView];
        }
    }];
    [GMHttpRequest getForumSubList:[self getSelectID] usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
        if (isSuccess) {
            [headView restSubView:result];
            [self restmTableView];
        }
    }];
    
}
-(void)loadData
{
    [GMHttpRequest getForumList:[self getSelectID] page:1 usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
        if (isSuccess) {
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [mTableView reloadData];
        }
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GMForumModel *forum=[list objectAtIndex:section];
    return forum.list.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return list.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMForumModel *model=[list objectAtIndex:indexPath.section];
    return [GMContentNewsCell cellHight:[model.list objectAtIndex:indexPath.row]];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GMForumModel *model=[list objectAtIndex:section];
    UIView *view =[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, 30);
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(9, 0, self.view.frame.size.width, 30);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    label.text=model.newsMark;
    view.backgroundColor=[UIColor colorWithRed:144.0f/255.0f green:144.0f/255.0f blue:144.0f/255.0f alpha:0.6];
    [view addSubview:label];
    
    return view;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMContentNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[GMContentNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    GMForumModel *model=[list objectAtIndex:indexPath.section];
    [cell restModel:[model.list objectAtIndex:indexPath.row]];
    return cell;

}
#pragma delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
-(void)GMForumHeadViewSubTitleClickIndex:(NSInteger)index
{
    [CustomMethod showWaringMessage:NSLocalizedString(@"敬请期待", nil)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
