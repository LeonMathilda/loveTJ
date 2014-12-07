//
//  ContentNewsView.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ContentNewsView.h"
#import "GMContentNewsModel.h"
#import "GMContentNewsCell.h"
@implementation ContentNewsView
-(id)init
{
    if (self=[super init]) {
        dataList=[[NSMutableArray alloc]init];
        headList=[[NSMutableArray alloc]initWithCapacity:0];
        mtableview=[[UITableView alloc]init];
        mtableview.separatorColor=[UIColor clearColor];
        mtableview.backgroundColor=[UIColor clearColor];
        mtableview.delegate=self;
        mtableview.dataSource=self;
        [self addSubview:mtableview];
    }
    return self;
}
-(void)createHeadView
{
    if (!headVIew) {
        headVIew=[[ScrollImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
    }
}
-(void)loadServerData
{
    [dataList removeAllObjects];
    [GMHttpRequest getTitleDetailList:subModel.titID.integerValue usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
        if (isSuccess) {
            [dataList addObjectsFromArray:result];
            [mtableview reloadData];
        }
    }];
}
-(void)restHeadData:(NSMutableArray *)list
{
    [self createHeadView];
    [headList removeAllObjects];
    
    if (list.count) {
        [headVIew SetImageList:list];
        mtableview.tableHeaderView=headVIew;
        [headList addObjectsFromArray:list];
    }else
    {
        mtableview.tableHeaderView=nil;
    }
}
-(TopTitleSubListModel *)SubModel
{
    return subModel;
}
-(void)restLoadData
{
    
}
-(void)restModel:(TopTitleSubListModel *)model;
{
    subModel=model;
    [self loadServerData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GMContentNewsCell cellHight:[dataList objectAtIndex:indexPath.row]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMContentNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[GMContentNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell restModel:[dataList objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)setFrame:(CGRect)frame
{
    mtableview.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    [super setFrame:frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
