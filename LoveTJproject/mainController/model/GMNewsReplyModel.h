//
//  GMNewsReplyModel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "GMNewsReplySubModel.h"
@interface GMNewsReplyModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *newsMark;//最新评论 热门评论
@property(nonatomic,retain)NSMutableArray *list;//内容列表 content is GMNewsReplyModel
@end
