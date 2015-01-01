//
//  GMPlatListSubList.h
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GMPlatListSubList : ITTBaseModelObject
@property(nonatomic,retain)NSString *paltID;
@property(nonatomic,retain)NSString *platTitle;
@property(nonatomic,retain)NSString *platContent;
@property(nonatomic,retain)NSMutableArray *platImageList;
@property(nonatomic,retain)NSString *platImageTotalCount;
@property(nonatomic,retain)NSString *platIsPrasied;

//user
@property(nonatomic,retain)NSString *platUserID;
@property(nonatomic,retain)NSString *PlatUserName;
@property(nonatomic,retain)NSString *platUserTime;
@property(nonatomic,retain)NSString *platUserAvatar;

@end
