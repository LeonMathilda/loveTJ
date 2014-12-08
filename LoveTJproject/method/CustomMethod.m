//
//  CustomMethod.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "CustomMethod.h"
#import "PGToast.h"
@implementation CustomMethod
+(void)showWaringMessage:(NSString *)str
{
    if (str.length) {
        [PGToast makeToast:str ];
    }
    
}
+(void)removeSubview:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
}
+(UIImage *) createImageWithColor: (UIColor *) color size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
