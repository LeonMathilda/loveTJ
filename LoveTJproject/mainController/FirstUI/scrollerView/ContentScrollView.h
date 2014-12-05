//
//  ContentScrollView.h
//  sinaScrollerView
//
//  Created by yunqi on 14/12/5.
//  Copyright (c) 2014年 yunqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTitleModel.h"
@interface ContentScrollView : UIScrollView
{
    NSMutableArray *list;
}
-(void)restContentView:(TopTitleModel *)model;
-(void)reloadContentViewIndex:(NSInteger )index;
@end
