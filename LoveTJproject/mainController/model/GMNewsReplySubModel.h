//
//  GMNewsReplySubModel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GMNewsReplySubModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *newsUserID;
@property(nonatomic,retain)NSString *newsUserAvatar;
@property(nonatomic,retain)NSString *newsUserName;

@property(nonatomic,retain)NSString *newsUserSourece;
@property(nonatomic,retain)NSString *newsReplyTime;
@property(nonatomic,retain)NSString *newsPraiseCount;
@property(nonatomic,retain)NSString *newsPraised;
@property(nonatomic,retain)NSString *newsReplyID;
@property(nonatomic,retain)NSString *newsReplyLoaction;
@property(nonatomic,retain)NSString *newsReplyContent;
@end
