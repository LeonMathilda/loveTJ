//
//  UIImageView+CircleAndBorder.m
//  YouYanChuApp
//
//  Created by Ron on 14-2-10.
//  Copyright (c) 2014年 HGG. All rights reserved.
//

#import "UIImageView+CircleAndBorder.h"

@implementation UIImageView(CircleAndBorder)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addCircleWithColor:(UIColor*)color BorderWidth:(CGFloat)width
{
    NSAssert(self.frame.size.width == self.frame.size.height, @"the width and height of this UIImageView Must be the same !");
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGPathRef maskPath = CGPathCreateWithEllipseInRect(self.bounds, NULL);
    maskLayer.bounds = self.bounds;
	maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    CGPoint point = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    maskLayer.position = point;
	[self.layer setMask:maskLayer];
    
    CGFloat circleWidth = self.frame.size.width + 0.5;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleWidth, circleWidth), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1].CGColor);
    CGContextStrokeEllipseInRect(context, CGRectMake(width/2, width/2, circleWidth - width, circleWidth - width));
    UIImage *rtImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *img = [[UIImageView alloc] initWithImage:rtImage];
    img.layer.position = point;
    [self.layer addSublayer:img.layer];
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
