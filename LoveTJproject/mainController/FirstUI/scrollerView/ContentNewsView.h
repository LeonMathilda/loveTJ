//
//  ContentNewsView.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTitleSubListModel.h"
#import "ScrollImageView.h"
#import "GMContentNewsScrollModel.h"
@interface ContentNewsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    TopTitleSubListModel *subModel;
    UITableView *mtableview;
    NSMutableArray *dataList;
    ScrollImageView *headVIew;
}
-(void)restLoadData;
-(void)restModel:(TopTitleSubListModel *)model;
@end
