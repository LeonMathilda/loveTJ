//
//  TouchView.h
//  TouchDemo
//
//  Created by Zer0 on 13-10-11.
//  Copyright (c) 2013年 Zer0. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTitleSubListModel.h"
#define KOrderButtonFrameOriginX 257.0
#define KOrderButtonFrameOriginY 20
#define KOrderButtonFrameSizeX 63
#define KOrderButtonFrameSizeY 45
//以上是OrderButton的frame值
#define KOrderButtonImage @"topnav_orderbutton.png"
#define KOrderButtonImageSelected @"topnav_orderbutton_selected_unselected.png"
//以上是OrderButton的背景图片
#define KDefaultCountOfUpsideList 10
//默认订阅频道数
#define KTableStartPointX 25
#define KTableStartPointY 60
//已订阅的按钮起始的位置
#define KButtonWidth 54
#define KButtonHeight 40
@interface TouchView : UIImageView
{
    CGPoint _point;
    CGPoint _point2;
    NSInteger _sign;
    @public
    
    NSMutableArray * _array;
    NSMutableArray * _viewArr11;
    NSMutableArray * _viewArr22;
}
@property (nonatomic,retain) UILabel * label;
@property (nonatomic,retain) UILabel * moreChannelsLabel;
@property(nonatomic,copy)NSString *cantMoveStr;
@property(nonatomic,retain)TopTitleSubListModel *model;
@end
