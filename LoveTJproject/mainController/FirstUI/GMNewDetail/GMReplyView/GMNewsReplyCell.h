//
//  GMNewsReplyCell.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMNewsReplySubModel.h"
#import "GMMenulabel.h"
@class GMNewsReplyCell;
@protocol GMNewsReplyCellDelegate<NSObject>
@optional
-(void)GMNewsReplyCellDelegateClickAvatar:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyCellDelegateClickLoaction:(GMNewsReplyCell *)cell;

-(void)GMNewsReplyCellDelegateClickParese:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyCellDelegateClickReply:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyCellDelegateClickReport:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyCellDelegateClickCopy:(GMNewsReplyCell *)cell;
@end
@interface GMNewsReplyCell : UITableViewCell
{
    GMMenulabel *content;
}
@property(nonatomic,assign)id<GMNewsReplyCellDelegate>delegate;
-(void)restCell:(GMNewsReplySubModel *)model;
+(float)cellHight:(GMNewsReplySubModel *)model;
-(void)hiddenMenu;
@end
