//
//  ContentNewsView.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "ContentNewsView.h"

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
-(void)loadServerData
{
    [dataList removeAllObjects];
    for (int i=0; i<10; i++) {
        [dataList addObject:@"data"];
    }
    [mtableview reloadData];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=@"ccc";
    return cell;
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
