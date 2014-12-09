//
//  GMNewsReplyView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMContentNewsModel;
@protocol GMNewsReplyViewDelegate<NSObject>
@optional
-(void)GMNewsReplyViewDelegateClickAvatar:(GMContentNewsModel *)replyModel;
-(void)GMNewsReplyViewDelegateClickLocation:(GMContentNewsModel *)replyModel;
@end
@interface GMNewsReplyView : UIView
@property(nonatomic,assign)id<GMNewsReplyViewDelegate>delegate;
-(void)reloadData:(NSString *)newsID;
-(void)restHeadView:(GMNewsDetailModel *)model;
@end
