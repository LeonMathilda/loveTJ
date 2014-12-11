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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *_cellArray = [mTableView visibleCells];
    if([_cellArray count] > 0)
    {
        [_cellArray makeObjectsPerformSelector:@selector(hiddenMenu)];
    }
}
-(void)scrollerCell:(GMNewsReplyCell *)cell
{
    [mTableView scrollToRowAtIndexPath:[mTableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
-(GMNewsReplySubModel *)getIndexModel:(GMNewsReplyCell *)cell
{
    NSIndexPath *path=[mTableView indexPathForCell:cell];
    GMNewsReplyModel *model=[list objectAtIndex:path.section];
    return [model.list objectAtIndex:path.row];
}
-(void)GMNewsReplyCellDelegateClickAvatar:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickAvatar:)]) {
       
        [self.delegate GMNewsReplyViewDelegateClickAvatar:[self getIndexModel:cell]];
    }
}
-(void)GMNewsReplyCellDelegateClickLoaction:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickLocation:)]) {
        [self.delegate GMNewsReplyViewDelegateClickLocation:[self getIndexModel:cell]];
    }
}
-(void)GMNewsReplyCellDelegateClickCopy:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickCopy:cell:)]) {
        [self.delegate GMNewsReplyViewDelegateClickCopy:[self getIndexModel:cell] cell:cell];
    }
}
-(void)GMNewsReplyCellDelegateClickParese:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickParese:cell:)]) {
        [self.delegate GMNewsReplyViewDelegateClickParese:[self getIndexModel:cell] cell:cell];
    }
}
-(void)GMNewsReplyCellDelegateClickReply:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickReply:cell:)]) {
        [self.delegate GMNewsReplyViewDelegateClickReply:[self getIndexModel:cell] cell:cell];
    }
}
-(void)GMNewsReplyCellDelegateClickReport:(GMNewsReplyCell *)cell
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(GMNewsReplyViewDelegateClickReport:cell:)]) {
        [self.delegate GMNewsReplyViewDelegateClickReport:[self getIndexModel:cell] cell:cell];
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
