//
//  GMNewsReplyView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMNewsReplyView.h"
#import "GMNewsHeadView.h"
#import "GMNewsReplyModel.h"
#import "GMNewsReplyCell.h"
@interface GMNewsReplyView()<UITableViewDataSource,UITableViewDelegate,GMNewsReplyCellDelegate>
{
    NSInteger newsid;
    UITableView *mTableView;
    NSMutableArray *list;//list 下面是字典  字典 里面（包括标题headview  以及新闻列表）
}
@end
@implementation GMNewsReplyView
-(id)init
{
    if (self= [super init]) {
        [self initData];
    }
    return self;
}
-(void)initData
{
    if (mTableView) {
        return;
    }
    list=[[NSMutableArray alloc]initWithCapacity:0];
    mTableView=[[UITableView alloc]init];
    mTableView.backgroundColor=[UIColor lightGrayColor];
    mTableView.separatorColor=[UIColor clearColor];
    mTableView.delegate=self;
    mTableView.dataSource=self;
    [self addSubview:mTableView];
}
-(void)loadServerData
{
    [GMHttpRequest getNewsReplyDetailList:newsid page:1 usingSuccessBlock:^(BOOL isSuccess, NSMutableArray *result) {
        if (isSuccess) {
            [list removeAllObjects];
            [list addObjectsFromArray:result];
            [mTableView reloadData];
        }
    }];

}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMNewsReplyModel *model=[list objectAtIndex:indexPath.section];
    return [GMNewsReplyCell cellHight:[model.list objectAtIndex:indexPath.row]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return list.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GMNewsReplyModel *model=[list objectAtIndex:section];
    UIView *view =[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, self.frame.size.width, 30);
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(15, 0, self.frame.size.width, 30);
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    label.text=model.newsMark;
    
    [view addSubview:label];
    
    return view;
    
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GMNewsReplyModel *model=[list objectAtIndex:section];
    return model.list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GMNewsReplyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"replyCell"];
    if (!cell) {
        cell=[[GMNewsReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"replyCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate=self;
    }
    GMNewsReplyModel *model=[list objectAtIndex:indexPath.section];
    [cell restCell:[model.list objectAtIndex:indexPath.row]];
    return cell;
}
-(void)setFrame:(CGRect)frame
{
    mTableView.frame=CGRectMake(0,0 , frame.size.width, frame.size.height);
    [super setFrame:frame];
}
-(void)reloadData:(NSString *)newsID
{
    newsid=newsID.integerValue;
    [self loadServerData];
}
-(void)restHeadView:(GMNewsDetailModel *)model
{
    GMNewsHeadView *newsHeadView=[[GMNewsHeadView alloc]init];
    newsHeadView.frame=CGRectMake(0, 0, self.frame.size.width, 0);
    newsHeadView.backgroundColor=[UIColor whiteColor];
    [newsHeadView restHeadView:model];
    mTableView.tableHeaderView=newsHeadView;
}

#pragma cell delegate
-(void)GMNewsReplyCellDelegateClickAvatar:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickAvatar:)]) {
        NSIndexPath *path=[mTableView indexPathForCell:cell];
        GMNewsReplyModel *model=[list objectAtIndex:path.section];
        [self.delegate GMNewsReplyViewDelegateClickAvatar:[model.list objectAtIndex:path.row]];
    }
}
-(void)GMNewsReplyCellDelegateClickLoaction:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickLocation:)]) {
        NSIndexPath *path=[mTableView indexPathForCell:cell];
        GMNewsReplyModel *model=[list objectAtIndex:path.section];
        [self.delegate GMNewsReplyViewDelegateClickLocation:[model.list objectAtIndex:path.row]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
