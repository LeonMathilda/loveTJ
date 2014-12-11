//
//  GMmenuItem.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/11.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMmenuItem : UIMenuItem
@property(nonatomic,weak)id tager;
-(id)initWithTitle:(NSString *)title tager:(id)tager action:(SEL)action;
@end
