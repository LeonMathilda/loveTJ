//
//  GMForumModel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/29.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "GMContentNewsModel.h"
@interface GMForumModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *newsMark;//like 热门。。
@property(nonatomic,retain)NSMutableArray *list;//内容列表 content is GMContentNewsModel（暂定）
@end
