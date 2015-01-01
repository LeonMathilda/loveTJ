//
//  GMPlatListModel.h
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "GMPlatListTopListModel.h"
#import "GMPlatListSubList.h"
//板块子内容model
@interface GMPlatListModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *platImage;
@property(nonatomic,retain)NSString *platTitle;//板块标题
@property(nonatomic,retain)NSString *platFlowNum;//关注数
@property(nonatomic,retain)NSString *platNum;//帖子数
@property(nonatomic,retain)NSString *platIsFollowing;//是否关注
@property(nonatomic,retain)NSString *platID;
@property(nonatomic,retain)NSString *platHasNotice;//是否有公告
@property(nonatomic,retain)NSMutableArray *platTopList;//置顶列表 content must be GMPlatListTopListModel
@property(nonatomic,retain)NSMutableArray *platList;//普通列表  content must be GMPlatListSubList
@end
