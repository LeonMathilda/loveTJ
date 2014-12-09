//
//  GMCommonAndVideoView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMNewsDetailModel.h"
#import "ALMoviePlayerController.h"
#define GMCommonAndVideoView_leftPlace 10
#define GMCommonAndVideoView_TopPlace 10
#define GMCommonAndVideoView_MaxImageHight 250
@protocol GMCommonAndVideoViewDelegate<NSObject>
-(void)GMCommonAndVideoViewDelegateClickImage;
-(void)GMCommonAndVideoViewDelegateClickPlayVideo;
-(void)GMCommonAndVideoViewDelegateClickAboutNewsIndex:(NSInteger)index;
@end
@interface GMCommonAndVideoView : UIScrollView
@property (nonatomic, strong) ALMoviePlayerController *moviePlayer;
@property(nonatomic,assign)id<GMCommonAndVideoViewDelegate>delegateClcik;
-(void)restView:(GMNewsDetailModel *)model;
@end
