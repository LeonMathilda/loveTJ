//
//  GMPhotoScrollView.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/15.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GMPhotoScrollViewDelegate<NSObject>
-(void)GMPhotoScrollViewDelegateIndex:(NSInteger)index;
@end
@interface GMPhotoScrollView : UIScrollView
@property(nonatomic,assign)id<GMPhotoScrollViewDelegate>delegateView;;
@property(nonatomic,assign)float padding;
-(void)show:(NSMutableArray *)list;
@end
