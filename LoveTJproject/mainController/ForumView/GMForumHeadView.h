//
//  GMForumHeadView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/29.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollImageView.h"
#import "GMForumHeadViewListView.h"
#define ScrollView_HIGHT 140
@protocol GMForumHeadViewDelegate<NSObject>
@optional
-(void)GMForumHeadViewSubTitleClickIndex:(NSInteger)index;
-(void)GMForumHeadViewScrollImageClickIndex:(NSInteger)index;
@end
@interface GMForumHeadView : UIView<GMForumHeadViewListViewDelegate>
{
    ScrollImageView *headVIew;
    GMForumHeadViewListView *subTitleView;
}
@property(nonatomic,assign)id<GMForumHeadViewDelegate>delegate;
-(void)restLunBoView:(NSMutableArray *)list;
-(void)restSubView:(NSMutableArray *)list;
@end
