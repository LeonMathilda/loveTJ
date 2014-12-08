//
//  CustomMethod.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomMethod : NSObject
+(void)showWaringMessage:(NSString *)str;
+(void)removeSubview:(UIView *)view;
+(UIImage *) createImageWithColor: (UIColor *) color size:(CGSize)size;
@end
