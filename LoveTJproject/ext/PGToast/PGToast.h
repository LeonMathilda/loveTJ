//
//  PGToast.h
//  iToastDemo
//
//  Created by gong Pill on 12-5-21.
//  Copyright (c) 2012年 ceo softcenters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface PGToast : NSObject 

- (void)show;
+ (PGToast *)makeToast:(NSString *)text;

@end
