// -------------------- Common Function --------------------------
#pragma mark - Common Function
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


//AppDelegate
#define appDelegate (GMAppDelegate*)[UIApplication sharedApplication].delegate

//NSString
#define STRING_OR_EMPTY(A)  ({ __typeof__(A) __a = (A); __a ? __a : @""; })


//NSLocalizedString
#define LS(string) NSLocalizedString(string,nil)

//NSUserDefault
#define uDefault [NSUserDefaults standardUserDefaults]

//[NSFileManager defaultManager]
#define fileMng [NSFileManager defaultManager]

//ReachNetWork
#define isInWifi [[Reachability reachabilityForInternetConnection] isReachableViaWiFi]
#define isOnline [GGUtil checkNetworkConnection]


//documents structure of application
#define APP_DOCUMENT                [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_LIBRARY                 [NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_CACHES_PATH             [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_USERINFO_PATH           userInfoPath()


//Version
#define curVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#pragma mark - Device Information

#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define NavigationBar_HEIGHT 44
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - System Information

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



#define isIOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")



// --------------------  Size --------------------------
#define DEVICE_RECT [[UIScreen mainScreen] bounds]
#define APP_RECT [[UIScreen mainScreen] applicationFrame]

#define DEVICE_SIZE [[UIScreen mainScreen] bounds].size
#define APP_SIZE [[UIScreen mainScreen] applicationFrame].size


//UI heights
#define STATUSBAR_HEIGHT 20.0
#define NAVBAR_HEIGHT 44.0
#define STATUS_NAV_HEIGHT 64.0

//Localization
#define LOCALIZABLE_WITHKEY_TABLE(KEY, TABLE) [[NSBundle mainBundle] localizedStringForKey:(KEY) value:(KEY) table:(TABLE)]

#define LOCALIZABLE(NAME) LOCALIZABLE_WITHKEY_TABLE(([NSString stringWithFormat:@"%@_%@", NAME, (([uDefault objectForKey:kCURRENT_LANGUAGE]) ? [uDefault objectForKey:kCURRENT_LANGUAGE] : @"e")]), nil)

// -------------------- Debug Function --------------------------

#ifndef __OPTIMIZE__
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#   define DLog(fmt, ...) NSLog((@"%s [File %s: Line %d] " fmt), __PRETTY_FUNCTION__, __FILE__, __LINE__, ##__VA_ARGS__)
#   define ELog(err) {if(err) DLog(@"%@", err);}
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


//weakself
#define WEAKSELF __weak __typeof(&*self)weakSelf = self;

//Block
typedef void(^voidBlock)();
typedef void(^stringBlock)(NSString *result);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^numberBlock)(NSNumber *result);
