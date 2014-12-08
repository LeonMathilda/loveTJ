//
//  ContentScrollView.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTitleModel.h"
@protocol ContentScrollViewDelegate<NSObject>
@optional
-(void)ContentScrollViewDelegateSelect:(GMContentNewsModel *)subModel;
@end
@interface ContentScrollView : UIScrollView
{
    NSMutableArray *list;
}
@property(nonatomic,assign)id<ContentScrollViewDelegate>delegateNews;
-(void)restContentView:(TopTitleModel *)model;
-(void)reloadContentViewIndex:(NSInteger )index;
-(void)restHeadData:(NSMutableArray *)listData;
-(void)ResourceChange:(TopTitleModel *)model;//数据源改变
@end
