//
//  GMNewsReplyModel.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/9.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMNewsReplyModel.h"

@implementation GMNewsReplyModel
-(id)init
{
    self=[super init];
    if (self) {
        _list=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
@end
