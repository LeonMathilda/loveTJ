//
//  GMNewsReplyCell.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMNewsReplySubModel.h"
@class GMNewsReplyCell;
@protocol GMNewsReplyCellDelegate<NSObject>
@optional
-(void)GMNewsReplyCellDelegateClickAvatar:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyCellDelegateClickLoaction:(GMNewsReplyCell *)cell;
@end
@interface GMNewsReplyCell : UITableViewCell
@property(nonatomic,assign)id<GMNewsReplyCellDelegate>delegate;
-(void)restCell:(GMNewsReplySubModel *)model;
+(float)cellHight:(GMNewsReplySubModel *)model;
@end
