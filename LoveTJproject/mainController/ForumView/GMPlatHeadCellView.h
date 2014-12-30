//
//  GMPlatHeadCellView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/30.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMPlatHeadCellView;
@protocol GMPlatHeadCellViewDelegate<NSObject>
@optional
-(void)GMPlatHeadCellViewClickView:(GMPlatHeadCellView *)view;
@end
@interface GMPlatHeadCellView : UIView
@property(nonatomic,assign)id<GMPlatHeadCellViewDelegate>delegate;
-(void)restView:(NSString *)title show:(BOOL)showRight isOpen:(BOOL)isOpen;
-(void)showRight:(BOOL)isOpen animation:(BOOL)animation;
@end
