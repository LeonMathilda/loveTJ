//
//  GMPhotoButtomView.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/15.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMPhotoButtomView.h"
@interface GMPhotoButtomView()
{
    UITextView *textView;
}
@end
@implementation GMPhotoButtomView
-(id)init
{
    self=[super init];
    if (self) {
        [self initData];
    }
    return self;
}
-(void)contentStr:(NSString *)str
{
    textView.text=str;
}
-(void)initData
{
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    textView=[[UITextView alloc]init];
    textView.userInteractionEnabled=YES;
    [textView setEditable:NO];
    textView.font=[UIFont systemFontOfSize:14];
    textView.textColor=[UIColor whiteColor];
    textView.backgroundColor=[UIColor clearColor];
    [self addSubview:textView];
}
-(void)layoutSubviews
{
     textView.frame=CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20);
    [super layoutSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
