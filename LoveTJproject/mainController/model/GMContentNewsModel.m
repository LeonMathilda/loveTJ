//
//  GMContentNewsModel.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/6.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMContentNewsModel.h"

@implementation GMContentNewsModel
- (NSDictionary*)attributeMapDictionary
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"nid",@"newsID"
            ,@"content",@"newsContent"
            ,@"new_title",@"newsTitle"
            ,@"p_pic",@"newsHeadPath"
            ,@"ntype",@"newsClass"
            ,@"pic_news_arr",@"newsImages"
            ,@"modifydate",@"newsTime"
            ,nil];
}
@end
