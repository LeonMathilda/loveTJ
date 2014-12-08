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
@protocol ContentNewsViewDelegate<NSObject>
@optional
-(void)ContentNewsViewDelegateSelectNews:(GMContentNewsModel *)subModel;
@end
@interface ContentNewsView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    TopTitleSubListModel *subModel;
    UITableView *mtableview;
    NSMutableArray *dataList;
    ScrollImageView *headVIew;
    NSMutableArray *headList;
}
@property(nonatomic,assign)id<ContentNewsViewDelegate>delegate;
-(TopTitleSubListModel *)SubModel;
-(void)restLoadData;
-(void)restModel:(TopTitleSubListModel *)model;
-(void)restHeadData:(NSMutableArray *)list;
@end
