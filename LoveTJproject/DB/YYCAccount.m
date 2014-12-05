    //
//  YYCAccount.m
//  YouYanChuApp
//
//  Created by Ron on 13-11-13.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import "YYCAccount.h"
#import "GGUtil.h"
#import "GGMacros.h"
//#import "APService.h"
//#import "OrderItem.h"

@implementation YYCAccount

+ (void)load
{
    [[NSNotificationCenter defaultCenter] addObserverForName:kNotificationShouldLogout object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if ([YYCAccount currentAccount]) {
            [YYCAccount logout];
        }
    }];
}

+ (NSDictionary *)mappingDict{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"uid",@"id",
            @"username",@"nickname",
            @"avatar",@"avatar",
            @"email",@"email",
            @"cellPhone",@"cellphone",
            nil];
}

+ (YYCAccount*)currentAccount
{
    return [[YYCAccount findByColumn:@"islogin" value:@YES] firstObject];
}

+ (NSString*)token
{
    return [[YYCAccount currentAccount] autoToken];
}
+(void)loiginWithCellPhone:(loginBlock)block :(NSString *)phoneNumber :(NSString*)passWord
{
    if (![GGUtil checkNetworkConnection]) {
        UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:nil message:@"当前无网络连接，请检查网络" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [YYCAccount logout];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:phoneNumber,@"cellphone",passWord,@"password", nil];
    [[APIClient2 sharedClient] POST:cellPhoneLogin parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"******%@",responseObject);
        
        NSString *uid = [responseObject objectForKey:@"id"];
        [MBProgressHUD hideHUDForView:[appDelegate window] animated:YES];
//        [appDelegate updateAliasWithUserID:uid];
        
        YYCAccount *account = [[YYCAccount findByColumn:@"uid" value:uid] firstObject];
        if (!account) {
            account = [YYCAccount new];
        }
        account.username = [responseObject objectForKey:@"name"];
        account.avatar = [[responseObject objectForKey:@"avatars"] objectForKey:@"75x75"];
        account.autoToken = [responseObject objectForKey:@"auth_token"];
        account.islogin = @YES;
        [account setValueFromDictionary:responseObject mapping:[YYCAccount mappingDict]];
        [account save];

        if (block) {
            BOOL loginFirstTime = [[responseObject objectForKey:@"login_first_time"] boolValue];
            block(account, loginFirstTime);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:[appDelegate window] animated:NO];
        NSDictionary *dic = [operation responseObject];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"message"] delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
        if (block) {
            block(nil,NO);
        }
    }];



}
/*

+ (void)loginWithBlock:(loginBlock)block
{
//    [YYCAccount logout];
    [YYCAccount bindShareWithType:ShareTypeSinaWeibo withBlock:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            
            NSMutableDictionary *paramter = [NSMutableDictionary dictionaryWithDictionary:@{@"app_token": [NSString stringWithFormat:@"%@",AppPrivateToken], @"uid" : [userInfo uid],@"nickname" : [userInfo nickname],@"token" : [[userInfo credential] token], @"provider" : @"weibo"}];
            
            if ([userInfo profileImage]) {
                [paramter setObject:[userInfo profileImage] forKey:@"avatar"];
            }
         
        
            [MBProgressHUD showHUDAddedTo:[appDelegate window] animated:YES];
            
            [[APIClient2 sharedClient] POST:LoginUrl parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DLog(@"loginWithBlock responseObject is %@",responseObject);
                NSString *uid = [responseObject objectForKey:@"id"];
                [MBProgressHUD hideHUDForView:[appDelegate window] animated:YES];
//               [appDelegate updateAliasWithUserID:uid];
                
                YYCAccount *account = [[YYCAccount findByColumn:@"uid" value:uid] firstObject];
                if (!account) {
                    account = [YYCAccount new];
                }
                account.autoToken = [responseObject objectForKey:@"auth_token"];
                account.islogin = @YES;
                [account setValueFromDictionary:responseObject mapping:[YYCAccount mappingDict]];
//                account.uid = uid;
//                account.username = [responseObject objectForKey:@"nickname"];
//                account.avatar = [responseObject objectForKey:@"avatar"];
//                account.email = [responseObject objectForKey:@"email"];
//                account.cellPhone = [responseObject objectForKey:@"cellphone"];
                [account save];
                    if (block) {
                    BOOL loginFirstTime = [[responseObject objectForKey:@"login_first_time"] boolValue];
                    block(account, loginFirstTime);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
//                NSDictionary *dic = [operation responseObject];
                
//                DLog(@"\n%@ %@",[[[dic objectForKey:@"errors"] objectForKey:@"email"] objectForKey:@"message"], [dic objectForKey:@"message"]);
                [MBProgressHUD hideHUDForView:[appDelegate window] animated:NO];
                [GGUtil showGGAlert:@"登录失败" title:nil];
                if (block) {
                    block(nil,NO);
                }
            }];
        }
        else {
            if (block) {
                block(nil,NO);
            }
        }
    }];
}
 */
//-(void)setUsername:(NSString *)username
//{
//    _username = username;
//    [self save];
//
//}
+ (void)logout{
    YYCAccount *account = [YYCAccount currentAccount];
    if (account) {
        account.islogin = @NO;
               [account save];
    }
//    [appDelegate setIsuserlogin:NO];
//    [appDelegate updateAliasWithUserID:nil];
//    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
//    [uDefault setBool:NO forKey:OrderForbidShowSmallYellowPoint];
    [uDefault synchronize];
    [APIClient2 setUpToken:[YYCAccount token]];
    [[APIClient2 sharedClient]DELETE:@"/api/fans/logout" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([GGUtil checkNetworkConnection]) {
            if (operation.response.statusCode == 401) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShouldLogout object:nil];
            }
        }
    }];
}

//+ (void)bindShareWithType:(ShareType)shareType withBlock:(SSGetUserInfoEventHandler)resultBlock
//{
//    [ShareSDK getUserInfoWithType:shareType authOptions:[ShareSDK authOptionsWithAutoAuth:YES allowCallback:NO scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleModal viewDelegate:[appDelegate shareViewDelegate] authManagerViewDelegate:nil] result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//        if (resultBlock) {
//            resultBlock(result,userInfo,error);
//        }
//    }];
//
//}

+ (void)refreshUserInfo{
    YYCAccount *currentAccount = [YYCAccount currentAccount];
    if (currentAccount) {
        [APIClient2 setUpToken:currentAccount.autoToken];
        [[APIClient2 sharedClient] GET:UserInfoUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [currentAccount setValueFromDictionary:responseObject mapping:[YYCAccount mappingDict]];
            [currentAccount save];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationDidRefreshAccount object:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (operation.response.statusCode == 401) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShouldLogout object:nil];
            }
        }];
    }
}

@end
