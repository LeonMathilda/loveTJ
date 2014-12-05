//
//  YYCAccount.h
//  YouYanChuApp
//
//  Created by Ron on 13-11-13.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import "MojoModel.h"
#import "JTDateMappings.h"
#import "NSObject+JTObjectMapping.h"
//#import <ShareSDK/ShareSDK.h>
@class YYCAccount;
typedef void(^loginBlock)(YYCAccount *account, BOOL loginFirstTime);

@interface YYCAccount : MojoModel

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *autoToken;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, strong) NSNumber *islogin;
@property (nonatomic, strong) NSString *city;

+ (void)refreshUserInfo;

+ (NSDictionary *)mappingDict;

+ (YYCAccount*)currentAccount;

+ (NSString*)token;

//+ (void)loginWithBlock:(loginBlock)block;

+ (void)logout;

//+ (void)bindShareWithType:(ShareType)shareType withBlock:(SSGetUserInfoEventHandler)resultBlock;

+(void)loiginWithCellPhone:(loginBlock)block :(NSString *)phoneNumber :(NSString*)passWord;

@end
