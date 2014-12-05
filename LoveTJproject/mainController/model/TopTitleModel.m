//
//  TopTitleModel.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "TopTitleModel.h"

@implementation TopTitleModel
@synthesize list=_list;
-(id)init
{
    if (self= [super init]) {
        _list=[NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
@end
