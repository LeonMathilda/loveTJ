//
//  appConfig.h
//  MIDIProject
//
//  Created by 李昂 on 14-7-22.
//  Copyright (c) 2014年 com.Leon. All rights reserved.
//

#ifndef MIDIProject_appConfig_h
#define MIDIProject_appConfig_h

//#define STAGING 1
#ifndef STAGING
#define API_HOST @"https://youyanchu.com/api/festivals/midi/"
#define API_HOST2 @"https://youyanchu.com"
#define API_HOST_HTTP @"http://youyanchu.com"
#else
#define API_HOST @"http://youyanchu.gaiamagic.com/api/festivals/midi/"
#define API_HOST2 @"http://youyanchu.gaiamagic.com"
#define API_HOST_HTTP @"http://youyanchu.gaiamagic.com"
#endif

#define AppPrivateToken @"7uGWrosKxQZwKPCDY4xp"


#define FestivalID @"midi"

#define UmengKey_1login @"1login"

#define UMENG_APPKEY @"54009ab6fd98c50a1f01cd80"


#define kNotificationDidLogoutAccount @"NotificationDidLogoutAccount"
#define kNotificationDidLoginAccount @"NotificationDidLoginAccount"
#define kNotificationDidRefreshAccount @"NotificationDidRefreshAccount"
#define kNotificationShouldBindMobilePhone @"NotificationShouldBindMobilePhone"
#define kNotificationDidMadeOrder @"NotificationDidMadeOrder"
#define kNotificationGo2OrderPage @"NotificationGo2OrderPage"
#define kNotificationDidPayOrder @"NotificationDidPayOrder"
#define kNotificationShouldLogout @"NotificationShouldLogout"
#define kNotificationDidnotPay @"NotificationDidnotPay"
#define kNotificationOrderPayed @"NotificationOrderPayed"
#endif
