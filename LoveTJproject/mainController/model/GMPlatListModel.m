//
//  GMPlatListModel.m
//  LoveTJproject
//
//  Created by yunqi on 15/1/1.
//  Copyright (c) 2015年 com.Leon. All rights reserved.
//

#import "GMPlatListModel.h"


@implementation GMPlatListModel
-(id)init
{
    if (self=[super init]) {
        _platList=[NSMutableArray arrayWithCapacity:0];
        _platTopList=[NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
@end
