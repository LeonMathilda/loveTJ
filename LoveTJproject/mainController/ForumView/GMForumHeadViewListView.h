//
//  GMForumHeadViewListView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/29.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GMForumHeadViewListViewDelegate<NSObject>
@optional
-(void)GMForumHeadViewListViewClickIndex:(NSInteger)index;
@end
@interface GMForumHeadViewListView : UIView
@property(nonatomic,assign)id<GMForumHeadViewListViewDelegate>delegate;
-(void)restList:(NSMutableArray *)list;
@end
