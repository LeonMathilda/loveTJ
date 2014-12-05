//
//  GGGGUtil.h
//  Ganguo
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//


@interface GGUtil : NSObject

+ (NSString *)urlAppendRetina:(NSMutableString *)urlString;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (UIImage *)scaleAndRotateImage:(UIImage *)image withSize:(CGSize)size;
+ (UIImage *)imageAlpha:(UIImage *)inImage;
+ (UIImage *)imageMono:(UIImage *)image ;
+ (CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize;

+ (UIImage *)makeAShotWithView:(UIView*)aView;

+ (void)setTableViewBackgroundColor:(UIViewController *)viewController;

+ (void)setTableViewBackgroundImage:(UIViewController *)viewController;

+ (void)setTableViewBackgroundImage:(UITableViewController *)viewController 
                          withImage:(NSString *)imageName;

+ (void)setViewBackgroundColor:(UIViewController *)viewController;

+ (NSMutableDictionary *)getClassPropertys:(id)fromClass;

+ (void)allTextResignFirstResponder:(id)fromClass component:(NSString *)component;

+ (UIColor *)randomColor;

+ (void) showGGAlert: (NSString *) theMessage title:(NSString *) theTitle;

+ (void)showHUD:(NSString*)message inView:(UIView*)aView hideAfter:(CGFloat)second;

+ (void) cleanCellFooter: (UITableViewController *)tableView ;

+ (NSString *)genToken:(NSNumber *)currTimestamp withPlus:(int)plus;

+ (NSMutableDictionary *)stringToDictionary:(NSString *)sourceString withSeparator:(NSString *)separator;

+ (NSString *)getShowName:(NSString *)username 
            withFirstName:(NSString *)firstName 
             withLastName:(NSString *)lastName;

+ (BOOL)canSendSMS;

+ (NSInteger) getSystemVersionAsAnInteger;

+ (BOOL)checkNetworkConnection;

+ (BOOL)isEnableAPNs;

+ (CGFloat)getScreenWidth;
+ (CGFloat)getScreenHeight;

+ (NSString *)getDistanceText:(double)distance;

+ (void)storeBadge;

+ (int)getStoredBadge;

+ (void)simulateMemoryWarning;

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length;

+ (BOOL)isDate:(NSDate*)aDate inTheSameDayTo:(NSDate*)anotherDate;

+ (NSString*)getLocalYYMMDD;

+ (NSString*)weekNameInChineseFormDate:(NSDate*)date;

+ (NSString*)stringFromDate:(NSDate*)aDate Format:(NSString*)dateFormat;

+ (NSDate*)dateFromString:(NSString*) dateStr Format:(NSString*)dateFormat;

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale;

+ (NSDate*)dateFromString:(NSString*) dateStr format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale;

+ (NSDate *)getToday;
+ (NSString *)timeToText:(NSDate *)time;

+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

+ (NSString *)getLargeSinaAvatar:(NSString *)shortUrl;

+ (NSString *)emptyLazyString:(NSString *)source;

+ (BOOL)stringIsEmpty:(NSString *) aString;
+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;

+(BOOL)isValidateEmail:(NSString *)email;

+(BOOL)isValidateMobile:(NSString *)mobile;

+ (BOOL)isValidZipcode:(NSString*)value;

+ (NSString*)UUID;

+ (NSString *)processTextUrl:(NSString *)source;

+ (NSString *)urlEncodeValue:(NSString *)str;

+ (id)loadNibWithClassStr:(NSString*)classStr;

+ (BOOL)hasLaunchBeforeAtThisVersion;

+ (BOOL)isStrongerThaniPhone4;

@end
