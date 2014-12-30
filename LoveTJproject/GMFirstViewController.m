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
#import "GMPlateModel.h"
#import "GMPlatCell.h"
#import "GMPlatHeadCellView.h"
@interface GMFirstViewController ()<UITableViewDataSource,UITableViewDelegate,GMForumHeadViewDelegate,UISearchBarDelegate,GMPlatHeadCellViewDelegate>
{
    UISegmentedControl *_segmentedControl;
    UITableView *mTableView;
    NSMutableArray *list;
    GMForumHeadView *headView;
    UISearchBar *mSearchBar;
    BOOL _isSearch;
    NSMutableArray *_searchList;
}
@end

@implementation GMFirstViewController

- (void)viewDidLoad
{
    list=[[NSMutableArray alloc]init];
    _isSearch=NO;
    _searchList=[[NSMutableArray alloc]initWithCapacity:0];
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
    
    mSearchBar = [[UISearchBar alloc]
                                initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 45)];
    mSearchBar.delegate = self;
    mSearchBar.showsCancelButton = NO;
    mSearchBar.barStyle=UIBarStyleDefault;
    mSearchBar.keyboardType=UIKeyboardTypeDefault;
    mSearchBar.placeholder=@"搜吧，搜帖";
    mSearchBar.keyboardType=UIKeyboardTypeNamePhonePad;
    [mSearchBar setContentMode:UIViewContentModeLeft];
    
   
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
    
    [self restHeadViewData];
}
-(void)restHeadViewData
{
    [self restmTableView];
    if (_segmentedControl.selectedSegmentIndex==0) {
        [self loadHeadViewData];
    }
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
    if (_segmentedControl.selectedSegmentIndex==0) {
        mTableView.tableHeaderView=headView;
        mTableView.tableHeaderView.frame=CGRectMake(0, 0, headView.frame.size.width, headView.frame.size.height);
    }else
    {
        mTableView.tableHeaderView=mSearchBar;
        mTableView.tableHeaderView.frame=CGRectMake(0, 0,mSearchBar.frame.size.width, mSearchBar.frame.size.height);
    }
   
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
    if (_segmentedControl.selectedSegmentIndex==0) {
        [GMHttpRequest getForumList:[self getSelectID] page:1 usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
            [list removeAllObjects];
            [_searchList removeAllObjects];
            if (isSuccess) {
                [list addObjectsFromArray:result];
            }
             [mTableView reloadData];
        }];
    }else
    {
        [GMHttpRequest getBanKuaiList:[self getSelectID] page:1 usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
            [list removeAllObjects];
            [_searchList removeAllObjects];
            
            if (isSuccess) {
                [list addObjectsFromArray:result];
            }
            [mTableView reloadData];
        }];
    }
    
}

-(BOOL)currentIsSeach
{
    if (_segmentedControl.selectedSegmentIndex==0) {
        return NO;
    }
    return _isSearch;
}
-(GMForumModel *)getCurrentIndex:(NSInteger)index
{
    GMForumModel *forum;
    if ([self currentIsSeach]) {
        forum=[_searchList objectAtIndex:index];
    }else
    {
        forum=[list objectAtIndex:index];
    }
    return forum;
}
-(GMPlateModel *)getCurrentPlatIndex:(NSInteger)index
{
    GMPlateModel *plat;
    if ([self currentIsSeach]) {
        plat=[_searchList objectAtIndex:index];
    }else
    {
        plat=[list objectAtIndex:index];
    }
    return plat;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_segmentedControl.selectedSegmentIndex==0) {
        GMForumModel *forum=[self getCurrentIndex:section];
        return forum.list.count;
    }else
    {
        GMPlateModel *plat=[self getCurrentPlatIndex:section];
        return plat.list.count;
    }
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self currentIsSeach]) {
        return _searchList.count;
    }
    return list.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segmentedControl.selectedSegmentIndex==0) {
        GMForumModel *forum=[self getCurrentIndex:indexPath.section];
        return [GMContentNewsCell cellHight:[forum.list objectAtIndex:indexPath.row]];
    }else
    {
        GMPlateModel *plat=[self getCurrentPlatIndex:indexPath.section];
        if (plat.isOpen) {
            return [GMPlatCell cellHigth:[plat.list objectAtIndex:indexPath.row]];
        }
        return 0;
    }

}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GMPlatHeadCellView *view =[[GMPlatHeadCellView alloc]init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, 34);
    view.backgroundColor=[UIColor colorWithRed:144.0f/255.0f green:144.0f/255.0f blue:144.0f/255.0f alpha:0.6];
    view.delegate=self;
    view.tag=100+section;
    if (_segmentedControl.selectedSegmentIndex==0) {
        GMForumModel *forum=[self getCurrentIndex:section];
        [view restView:forum.newsMark show:NO isOpen:NO];
    }else
    {
        GMPlateModel *plat=[self getCurrentPlatIndex:section];
        [view restView:plat.title show:YES isOpen:plat.isOpen];
    }
    BOOL isLast=NO;
    if ([self currentIsSeach]) {
        if (section!=_searchList.count-1) {
            isLast=YES;
        }
    }else
    {
        if (section!=list.count-1) {
            isLast=YES;
        }
    }
    if (isLast) {
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=[UIColor lightGrayColor];
        line.alpha=0.7;
        line.frame=CGRectMake(0, view.frame.size.height-0.5, self.view.frame.size.width, 0.5);
        [view addSubview:line];
    }
    return view;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_segmentedControl.selectedSegmentIndex==0) {
        GMContentNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[GMContentNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        GMForumModel *model=[self getCurrentIndex:indexPath.section];
        [cell restModel:[model.list objectAtIndex:indexPath.row]];
        return cell;
    }else
    {
        GMPlatCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PlatCell"];
        if (!cell) {
            cell=[[GMPlatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlatCell"];
        }
        [CustomMethod removeSubview:cell.contentView];
        GMPlateModel *plat=[self getCurrentPlatIndex:indexPath.section];
        if (plat.isOpen) {
            [cell restView:[plat.list objectAtIndex:indexPath.row]];
        }
        return cell;
    }
}
#pragma delegate
-(void)GMPlatHeadCellViewClickView:(GMPlatHeadCellView *)view
{
    if (_segmentedControl.selectedSegmentIndex==1) {
        GMPlateModel *plat=[self getCurrentPlatIndex:view.tag-100];
        plat.isOpen=!plat.isOpen;
        [mTableView reloadData];
    }
}
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
#pragma SearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
}
@end
