//
//  GMSearchBar.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/30.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMSearchBar.h"

@implementation GMSearchBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)changeCancleTitle:(NSString *)title
{
    for(id cc in [self subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
}
-(void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated
{
    [super setShowsCancelButton:showsCancelButton animated:animated];
    [self changeCancleTitle:nil];
}
@end
