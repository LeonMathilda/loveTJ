//
//  CostumTextField.m
//  YouYanChuApp
//
//  Created by 李 昂 on 14-4-5.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import "CostumTextField.h"

@implementation CostumTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    [[UIColor colorWithRed:99.0/225.0 green:99.0/255.0 blue:101.0/255.0 alpha:1.0] setFill];
    
    [[self placeholder] drawInRect:CGRectMake(rect.origin.x, rect.origin.y+7, rect.size.width, rect.size.height) withFont:[UIFont systemFontOfSize:16]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
