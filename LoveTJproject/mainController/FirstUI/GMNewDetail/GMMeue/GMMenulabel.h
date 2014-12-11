//
//  GMMenulabel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMmenuItem.h"
@interface GMMenulabel : UILabel
{
    NSMutableArray              *_menuItems;
    UIColor                     *_oldBackgroundColor;
    UIColor                     *_touchuBackgroundHighlightColor;
}
-(void)showMenuItem:(NSArray *)menuItemList;//must be GMmenuItem
-(void)WillmenuHiden;//ios 7上的一个bug  移动的scroller的时候先调用一下 其他版本可以不调用；
@end
