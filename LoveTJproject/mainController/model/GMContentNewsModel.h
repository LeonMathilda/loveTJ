//
//  GMContentNewsModel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/6.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GMContentNewsModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *newsID;
@property(nonatomic,retain)NSString *newsContent;
@property(nonatomic,retain)NSString *newsTitle;
@property(nonatomic,retain)NSString *newsHeadPath;
@property(nonatomic,retain)NSString *newsClass;
@property(nonatomic,retain)NSMutableArray *newsImages;
@property(nonatomic,retain)NSString *newsImageCount;
@property(nonatomic,retain)NSString *newsReplyCount;
@end
