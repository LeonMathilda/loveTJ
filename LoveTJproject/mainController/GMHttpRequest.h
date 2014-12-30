//
//  GMHttpRequest.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopTitleModel.h"
#import "GMNewsDetailModel.h"
@interface GMHttpRequest : NSObject
//获取分类
+(void)getDifferentTitle:(NSInteger)uid usingSuccessBlock:(void (^)(BOOL isSuccess,TopTitleModel  *result))successBlock;

+(void)getTitleDetailList:(NSInteger)titleID usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;

+(void)getLunBoList:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;

+(void)newsDetail:(NSInteger)newsID usingSuccessBlock:(void (^)(BOOL isSuccess,GMNewsDetailModel  *result))successBlock;
+(void)newsDetailPhotos:(NSInteger)newsID usingSuccessBlock:(void (^)(BOOL isSuccess,GMNewsDetailModel  *result))successBlock;

+(void)getNewsReplyDetailList:(NSInteger)newsID page:(NSInteger)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;

+(void)getForumList:(NSInteger)forumID page:(NSInteger)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;
+(void)getBanKuaiList:(NSInteger)forumID page:(NSInteger)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;
+(void)getForumLunBoList:(NSInteger)forumID  usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;
+(void)getForumSubList:(NSInteger)forumID  usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock;
@end
