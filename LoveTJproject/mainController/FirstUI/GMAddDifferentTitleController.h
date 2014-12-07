//
//  GMAddDifferentTitleController.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "BaceViewController.h"
@protocol GMAddDifferentTitleControllerDelegate<NSObject>
@optional
-(void)GMAddDifferentTitleControllerDelegateBack:(NSMutableArray *)list;
@end
@interface GMAddDifferentTitleController : BaceViewController
@property(nonatomic,retain)NSMutableArray *modelList;
@property(nonatomic,assign)id<GMAddDifferentTitleControllerDelegate>delegate;
@end
