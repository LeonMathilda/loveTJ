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
    for (int i=0; i<10; i++) {
        GMContentNewsModel *model=[[GMContentNewsModel alloc]init];
        model.newsTitle=@"测试数据标题";
        model.newsHeadPath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        model.newsReplyCount=@"303.3万";
        model.newsContent=@"dafadsfjalsdjfalskdjflaksjdflkasjdflkasjdflka";
        if (i%5==0) {
            model.newsImages=[NSMutableArray arrayWithObjects:@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg",@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg",@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg", nil];
            model.newsImageCount=@"8";
        }
        if (i%3==0) {
            model.newsClass=@"独家";
        }
        [dataList addObject:model];
    }
    [mtableview reloadData];
}
-(void)restHeadData
{
    [self createHeadView];
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<4;i++) {
        GMContentNewsScrollModel *scrollModel=[[GMContentNewsScrollModel alloc]init];
        scrollModel.newsTitle=@"测试测试";
        scrollModel.newsImagePath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        [list addObject:scrollModel];
    }
    if (list.count) {
        [headVIew SetImageList:list];
        mtableview.tableHeaderView=headVIew;
    }else
    {
        mtableview.tableHeaderView=nil;
    }
}
-(void)restLoadData
{
    
}
-(void)restModel:(TopTitleSubListModel *)model;
{
    subModel=model;
    [self loadServerData];
    [self restHeadData];
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
