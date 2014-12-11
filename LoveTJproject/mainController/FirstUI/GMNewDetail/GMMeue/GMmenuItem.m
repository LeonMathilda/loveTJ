//
//  GMmenuItem.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMmenuItem.h"

@implementation GMmenuItem
@synthesize tager=_tager;
-(id)initWithTitle:(NSString *)title tager:(id)tager action:(SEL)action
{
    if (self=[super initWithTitle:title action:action]) {
        _tager=tager;
    }
    return self;
}
@end
