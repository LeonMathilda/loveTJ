//
//  TopTitleSubListModel.m
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import "TopTitleSubListModel.h"

@implementation TopTitleSubListModel
@synthesize titID=_titID;
@synthesize title=_title;
- (NSDictionary*)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"ncid",@"titID"
            ,@"name",@"title"
            ,@"parent",@"parent"
            ,@"tpl_path_id",@"tpl_path_id"
            ,nil];
}
@end
