//
//  TopTitleView.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTitleModel.h"
#import "TopTitleScrollerView.h"
@protocol TopTitleViewDelegate<NSObject>
-(void)TopTitleViewDelegateClickIndex:(NSInteger)index;
-(void)TopTitleViewDelegateClickAdd;
@end
@interface TopTitleView : UIView<TopTitleScrollerViewDelegate>
{
    TopTitleScrollerView *scrollerView;
    TopTitleModel *titleModel;
    UIButton *btnAdd;
}
@property(nonatomic,assign)id<TopTitleViewDelegate>delegate;
-(void)restTopTitleView:(TopTitleModel *)model;
-(void)restTitleScrollSelect:(NSInteger )select;

-(void)titleResourceChange:(TopTitleModel *)model;
@end
