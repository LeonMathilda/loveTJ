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
    
    
    TopTitleModel *topModel=[[TopTitleModel alloc]init];
    for (int i=0; i<8; i++) {
        TopTitleSubListModel *subModel=[[TopTitleSubListModel alloc]init];
        subModel.titID=[NSString stringWithFormat:@"%i",i+1];
        subModel.title=[NSString stringWithFormat:@"标题%d",i+1];
        [topModel.list addObject:subModel];
    }
    
    successBlock(YES,topModel);
    return;
    
    NSString *stringURL = @"";
    
    [GMHttpRequest getDictionaryWithStringURL:stringURL usingSuccessBlock:^(NSDictionary *resultDictionary) {
        
        if (1 == [resultDictionary [@"s"] integerValue]) {
            successBlock(YES,nil);
        }else{
            successBlock(NO,nil);
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
@end
