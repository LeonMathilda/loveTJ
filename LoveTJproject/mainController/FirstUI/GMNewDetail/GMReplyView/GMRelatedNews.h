//
//  GMRelatedNews.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GMRelatedNewsDelegate<NSObject>
@optional
-(void)GMRelatedNewsDelegateClickIndex:(NSInteger)index;
@end
@interface GMRelatedNews : UIView
@property(nonatomic,assign)id<GMRelatedNewsDelegate>delegate;
-(void)restRelatedNews:(NSMutableArray *)newsList;
@end
