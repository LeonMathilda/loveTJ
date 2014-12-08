//
//  GMNewsDetailModel.h
//  LoveTJproject
//
//  Created by yunqi on 14/12/8.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "ITTBaseModelObject.h"
#import "GMContentNewsModel.h"
#import "GMContentNewsScrollModel.h"
typedef enum
{
    GMNewsDetailType_common=0,//普通
    GMNewsDetailType_iamges,//多图
    GMNewsDetailType_video,//视频
    GMNewsDetailType_topic //专题
}GMNewsDetailType;
@interface GMNewsDetailModel : ITTBaseModelObject
@property(nonatomic,retain)NSString *newsID;
@property(nonatomic,assign)GMNewsDetailType newsType;
@property(nonatomic,retain)NSString *newsSourse;
@property(nonatomic,retain)NSString *newsTime;
@property(nonatomic,retain)NSString *newsReplyCount;
@property(nonatomic,retain)NSString *newsTitle;
@property(nonatomic,retain)NSString *newsContent;
@property(nonatomic,retain)NSString *newsUrl;
@property(nonatomic,retain)NSString *newsTopImage;//普通新闻的时候顶部图片
@property(nonatomic,retain)NSMutableArray *newsRelated;//相关新闻列表 内容是  GMContentNewsModel
@property(nonatomic,retain)NSString *newsVidelUrl;//视频路径
@property(nonatomic,retain)NSString *newsVideoImage;
@property(nonatomic,retain)NSMutableArray *newsImages;//多图新闻数据  content is GMContentNewsScrollModel
@end
