//
//  TopTitleScrollerView.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTitleModel.h"
@protocol TopTitleScrollerViewDelegate<NSObject>
@optional
-(void)TopTitleScrollerViewDelegate:(NSInteger)index;
@end
@interface TopTitleScrollerView : UIScrollView<UIScrollViewDelegate>
{
   NSString* currentSelectedStr;
    NSMutableArray *btnList;
    UIView *bgView;
}
@property(nonatomic,assign)id<TopTitleScrollerViewDelegate>delegateSelect;
-(void)restTitleScrollSelect:(NSInteger )select;
-(void)restSource:(TopTitleModel *)titleModel;
-(void)titleResourceChange:(TopTitleModel *)model;
@end
