//
//  GMHttpRequest.m
//  LoveTJproject
//
//  Created by yunqi on 14/12/7.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#import "GMHttpRequest.h"
#import "AFNetworking.h"
#import "TopTitleModel.h"
#import "GMContentNewsModel.h"
#import "GMContentNewsScrollModel.h"
#import "GMNewsReplyModel.h"
#import "GMForumModel.h"
#import "GMPlateModel.h"
@implementation GMHttpRequest
//获取Dictionary数据
+ (void)getDictionaryWithStringURL:(NSString *)stringURL usingSuccessBlock:(void (^)(NSDictionary *resultDictionary))successBlock andFailureBlock:(void (^)(NSError *resultError))failureBlock
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[stringURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    __weak AFHTTPRequestOperation*weakOperation = operation;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //if ([NSJSONSerialization isValidJSONObject:weakOperation.responseString]) {
        if (weakOperation.responseData) {
            
            NSDictionary *value=[NSJSONSerialization JSONObjectWithData:weakOperation.responseData options:NSJSONReadingMutableContainers error:nil];
            
            successBlock(value);
        }else
        {
            failureBlock(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    [operation start];
}
//post上传
+(void)postValue:(NSString *)strUrl dic:(NSDictionary *)dic fileDic:(NSDictionary *)fileDic usingSuccessBlock:(void (^)(NSDictionary *resultDictionary))successBlock andFailureBlock:(void (^)(NSError *resultError))failureBlock
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData)  {
        for (NSString *key in [dic allKeys]) {
            if ([[dic objectForKey:key] isKindOfClass:[NSString class]]) {
                [formData appendPartWithFormData:[[dic objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding]  name:key];
                
            }
        }
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    }];
    [httpClient enqueueHTTPRequestOperation:operation];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id value = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        successBlock(value);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        successBlock(nil);
        
        failureBlock(error);
    }];
}

+(void)getDifferentTitle:(NSInteger)uid usingSuccessBlock:(void (^)(BOOL isSuccess,TopTitleModel  *result))successBlock
{
    NSString *stringURL = [NSString stringWithFormat:@"%@/getncate",MAIN_HEAD_URL];
    [GMHttpRequest getDictionaryWithStringURL:stringURL usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if ([resultDictionary objectForKey:@"s"]&&0 == [[resultDictionary objectForKey:@"s" ]  integerValue]) {
            TopTitleModel *topModel=[[TopTitleModel alloc]init];
            for (NSDictionary *dic in [resultDictionary objectForKey:@"data"]) {
                TopTitleSubListModel *subModel=[[TopTitleSubListModel alloc]initWithDataDic:dic];
                [topModel.list addObject:subModel];
            }
            successBlock(YES,topModel);
        }else{
            successBlock(NO,nil);
            [CustomMethod showWaringMessage:[resultDictionary objectForKey:@"msg"]];
        }
        
    } andFailureBlock:^(NSError *resultError) {
        successBlock(NO,nil);
    }];
}
+(void)getTitleDetailList:(NSInteger)titleID usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray  arrayWithCapacity:0];
    for (int i=0; i<10; i++) {
        GMContentNewsModel *model=[[GMContentNewsModel alloc]init];
        model.newsTitle=@"测试数据标题";
        model.newsID=[NSString stringWithFormat:@"%d",i+1];
        model.newsHeadPath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        model.newsReplyCount=@"303.3万";
        model.newsContent=@"dafadsfjalsdjfalskdjflaksjdflkasjdflkasjdflka";
        if (i%5==0) {
            model.newsImages=[NSMutableArray arrayWithObjects:@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg",@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg",@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg", nil];
            model.newsImageCount=@"8";
        }
        if (i%3==0) {
            model.newsClass=@"独家";
        }
        [list addObject:model];
    }
    successBlock(YES,list);

}
+(void)getLunBoList:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<4;i++) {
        GMContentNewsScrollModel *scrollModel=[[GMContentNewsScrollModel alloc]init];
        scrollModel.newsTitle=@"测试测试";
        scrollModel.newsImagePath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        [list addObject:scrollModel];
    }
    successBlock(YES,list);
}
+(void)newsDetail:(NSInteger)newsID usingSuccessBlock:(void (^)(BOOL isSuccess,GMNewsDetailModel  *result))successBlock
{
    GMNewsDetailModel *detailModel=[[GMNewsDetailModel alloc]init];
    detailModel.newsContent=@"12月6日上午，4个外地人以打工无果、没钱买票回家为由，在重庆沙坪坝三峡广场寻求资助时，被热心市民举报。民警将4人带回派出所调查，让人诧异的是，这几个声称没钱回家的外地打工者，竟然是从南昌搭乘飞机前去重庆行乞赚过年钱的，其中一人用的手机还是iPhone 6 Plus  12月6日上午11点左右，重庆热心市民熊大姐报警称，有外地人在三峡广场冒充没钱回家的打工者，四处行骗要钱。民警迅速赶往现场，将4人带回沙坪坝区公安分局渝碚路派出所进行调查.\r\n经查，4人均来自安徽某县，平时在家务农，农闲时节便相邀出门行乞，主要方式就是冒充外来务工人员，钱不够买票回家，寻求资助。由于每次要钱的数额很小，一般是三五元，最多十来元，很多好心人不慎上当受骗。\r\n据交代，4人11月28日从南昌乘飞机到重庆，1个星期多时间先后到过沙坪坝、解放碑、南坪、大渡口等地的人流密集区域，除去开销，每人已经赚了七八百元。\r\n\r\n民警对4人的随身物品进行了清点，发现他们不仅衣着光鲜，手表、戒指一应俱全，还有3人使用的是苹果手机，其中一人用的还是最新上市的iPhone 6 Plus。\r\n\r\n\r\n民警对4人进行了严厉的批评教育。4人认识到错误，写下检讨书，表示将尽快返回家乡，不再行乞骗人。据《重庆晚报》";
    detailModel.newsTitle=@"重大新闻,敬请留意";
    detailModel.newsTime=@"2014/09/20";
    detailModel.newsSourse=@"中国青年网";
    detailModel.newsReplyCount=@"2222";
    detailModel.newsType=GMNewsDetailType_common;
    if (newsID%2==0) {
        detailModel.newsType=GMNewsDetailType_video;
        detailModel.newsVideoImage=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        detailModel.newsVidelUrl=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
    }
    detailModel.newsTopImage=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
    NSMutableArray *aboutNewsList=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<4; i++) {
        GMContentNewsModel *aboutModel=[[GMContentNewsModel alloc]init];
        aboutModel.newsSourece=@"中国青年网";
        aboutModel.newsTitle=@"相关新闻标题";
        aboutModel.newsTime=@"2014-12-8";
        aboutModel.newsID=@"3";
        [aboutNewsList addObject:aboutModel];
    }
    detailModel.newsRelated=aboutNewsList;
    successBlock(YES,detailModel);
    
}
+(void)getNewsReplyDetailList:(NSInteger)newsID page:(NSInteger)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    GMNewsReplyModel *reply1=[[GMNewsReplyModel alloc]init];
    reply1.newsMark=@"热门评论";
    for (int i=0; i<10; i++) {
        GMNewsReplySubModel *subModel=[[GMNewsReplySubModel alloc]init];
        subModel.newsPraiseCount=@"88";
        subModel.newsPraised=@"0";
        subModel.newsReplyID=@"1";
        subModel.newsReplyTime=@"一小时前";
        subModel.newsUserAvatar=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        subModel.newsUserName=@"腾讯组";
        subModel.newsUserSourece=@"山东聊城";
        subModel.newsReplyContent=@"天上飘来五个字：那都是不是事。 奔跑吧奔跑吧兄弟奔跑吧兄弟兄弟。angelaBaby I love you so much";
        subModel.newsReplyLoaction=@"发表于地球村南村镇中医院癌症专区";
        [reply1.list addObject:subModel];
    }
    [list addObject:reply1];
    
    GMNewsReplyModel *reply2=[[GMNewsReplyModel alloc]init];
    reply2.newsMark=@"最新评论";
    for (int i=0; i<10; i++) {
        GMNewsReplySubModel *subModel=[[GMNewsReplySubModel alloc]init];
        subModel.newsPraiseCount=@"88";
        subModel.newsPraised=@"0";
        subModel.newsReplyID=@"1";
        subModel.newsReplyTime=@"一小时前";
        subModel.newsUserAvatar=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        subModel.newsUserName=@"腾讯组";
        subModel.newsUserSourece=@"山东聊城";
        subModel.newsReplyContent=@"天上飘来五个字：那都是不是事。 奔跑吧兄弟 奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟。angelaBaby I love you so much";
        subModel.newsReplyLoaction=@"发表于地球村南村镇中医院癌症专区";
        [reply2.list addObject:subModel];
    }
    [list addObject:reply2];
    
    successBlock(YES,list);
}
+(void)newsDetailPhotos:(NSInteger)newsID usingSuccessBlock:(void (^)(BOOL isSuccess,GMNewsDetailModel  *result))successBlock
{
    GMNewsDetailModel *detailModel=[[GMNewsDetailModel alloc]init];
    detailModel.newsContent=@"";
    detailModel.newsTitle=@"重大新闻,敬请留意";
    detailModel.newsTime=@"2014/09/20";
    detailModel.newsSourse=@"中国青年网";
    detailModel.newsReplyCount=@"2222";
    detailModel.newsType=GMNewsDetailType_common;
    if (newsID%2==0) {
        detailModel.newsType=GMNewsDetailType_video;
        detailModel.newsVideoImage=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        detailModel.newsVidelUrl=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
    }
    
    detailModel.newsTopImage=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
    NSMutableArray *aboutNewsList=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<4; i++) {
        GMContentNewsScrollModel *aboutModel=[[GMContentNewsScrollModel alloc]init];
        aboutModel.newsImagePath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        aboutModel.newsTitle=@"天上飘来五个字：那都是不是事。 奔跑吧兄弟 奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟天上飘来五个字：那都是不是事。 奔跑吧兄弟 奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟天上飘来五个字：那都是不是事。 奔跑吧兄弟 奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟天上飘来五个字：那都是不是事。 奔跑吧兄弟 奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟奔跑吧兄弟";
        aboutModel.newsID=@"3";
        [aboutNewsList addObject:aboutModel];
    }
    detailModel.newsImages=aboutNewsList;
    successBlock(YES,detailModel);
}
+(void)getForumList:(NSInteger)forumID page:(NSInteger)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<5; i++) {
        GMForumModel *forumModel=[[GMForumModel alloc]init];
        forumModel.newsMark=@"测试";
        [list addObject:forumModel];
        for (int k=0; k<10; k++) {
            GMContentNewsModel *model=[[GMContentNewsModel alloc]init];
            [forumModel.list addObject:model];
            model.newsTitle=@"测试数据标题";
            model.newsID=[NSString stringWithFormat:@"%d",i+1];
            model.newsHeadPath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
            model.newsReplyCount=@"303.3万";
            model.newsContent=@"dafadsfjalsdjfalskdjflaksjdflkasjdflkasjdflka";
            if (k%5==0) {
                model.newsImages=[NSMutableArray arrayWithObjects:@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg",@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg",@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg", nil];
                model.newsImageCount=@"8";
            }
            if (k%3==0) {
                model.newsClass=@"独家";
            }
            
        }
        
    }
    successBlock(YES,list);
}
+(void)getBanKuaiList:(NSInteger)forumID page:(NSInteger)page usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<4; i++) {
        GMPlateModel *model=[[GMPlateModel alloc]init];
        model.title=[NSString stringWithFormat:@"板块数据%d",i+1];
        if (i%2==0) {
            model.isOpen=YES;
        }
        for (int k=0; k<3; k++) {
            GMPlateSubModel *subModel=[[GMPlateSubModel alloc]init];
            subModel.image=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
            subModel.title=[NSString stringWithFormat:@"板块数据子内容%d",i+1];
            subModel.subTitle=[NSString stringWithFormat:@"板块数据子内容副标题%d",i+1];
            [model.list addObject:subModel];
        }
        [list addObject:model];
    }
    successBlock(YES,list);
}
+(void)getForumLunBoList:(NSInteger)forumID  usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<4;i++) {
        GMContentNewsScrollModel *scrollModel=[[GMContentNewsScrollModel alloc]init];
        scrollModel.newsTitle=@"测试测试";
        scrollModel.newsImagePath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        [list addObject:scrollModel];
    }
    successBlock(YES,list);
}
+(void)getForumSubList:(NSInteger)forumID  usingSuccessBlock:(void (^)(BOOL isSuccess,NSMutableArray  *result))successBlock
{
    NSMutableArray *list=[NSMutableArray arrayWithCapacity:0];
    for (int i=0;i<4;i++) {
        GMContentNewsScrollModel *scrollModel=[[GMContentNewsScrollModel alloc]init];
        scrollModel.newsTitle=@"测试测试";
        scrollModel.newsImagePath=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        [list addObject:scrollModel];
    }
    successBlock(YES,list);
}
+(void)getPlatList:(NSInteger )platID usingSuccessBlock:(void (^)(BOOL isSuccess,GMPlatListModel  *result))successBlock
{
    GMPlatListModel *platList=[[GMPlatListModel alloc]init];
    platList.platID=@"1";
    platList.platFlowNum=@"2345";
    platList.platIsFollowing=@"0";
    platList.platHasNotice=@"1";
    platList.platNum=@"6666";
    platList.platTitle=@"天津杂谈";
    platList.platImage=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
    for (int i=0; i<5; i++) {
        GMPlatListTopListModel *topModel=[[GMPlatListTopListModel alloc]init];
        topModel.platTitle=[NSString stringWithFormat:@"【置顶数据】测试数据-测试数据-测试数据%d",i+1];
        topModel.platID=@"2";
        [platList.platTopList addObject:topModel];
    }
    for (int i=0; i<10; i++) {
        GMPlatListSubList *suBlist=[[GMPlatListSubList alloc]init];
        suBlist.platImageTotalCount=@"4";
        suBlist.platIsPrasied=@"0";
        suBlist.platTitle=@"【标题内容】";
        suBlist.platUserAvatar=@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg";
        suBlist.platUserID=@"1";
        suBlist.PlatUserName=@"Jerry Li";
        suBlist.platUserTime=@"一小时前";
        suBlist.platContent=@"这里有什么好玩的，大叔，你要带我去哪里，带我飞吗.这里有什么好玩的，大叔，你要带我去哪里，带我飞吗.这里有什么好玩的，大叔，你要带我去哪里，带我飞吗。。fly to sky";
        if (i%3==0) {
            for (int k=0; k<3; k++) {
                [suBlist.platImageList addObject:@"http://wenwen.soso.com/p/20100620/20100620142034-985774128.jpg"];
            }
        }
        [platList.platList addObject:suBlist];
    }
    successBlock(YES,platList);
    
}
@end
