//
//  GMNewsReplyView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMNewsReplySubModel;
@class GMNewsReplyCell;
@protocol GMNewsReplyViewDelegate<NSObject>
@optional
-(void)GMNewsReplyViewDelegateClickAvatar:(GMNewsReplySubModel *)replyModel;
-(void)GMNewsReplyViewDelegateClickLocation:(GMNewsReplySubModel *)replyModel;

-(void)GMNewsReplyViewDelegateClickParese:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell ;
-(void)GMNewsReplyViewDelegateClickReply:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyViewDelegateClickReport:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell;
-(void)GMNewsReplyViewDelegateClickCopy:(GMNewsReplySubModel *)replyModel cell:(GMNewsReplyCell *)cell;
@end
@interface GMNewsReplyView : UIView
@property(nonatomic,assign)id<GMNewsReplyViewDelegate>delegate;
-(void)reloadData:(NSString *)newsID;
-(void)restHeadView:(GMNewsDetailModel *)model;
-(void)scrollerCell:(GMNewsReplyCell *)cell;
@end
