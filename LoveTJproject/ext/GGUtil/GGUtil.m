//
//  GGUtil.m
//  Ganguo
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

#import "GGUtil.h"


#import <objc/runtime.h>
#import "NSString+Reverse.h"
#import <MessageUI/MessageUI.h>
#import <AGCommon/UIDevice+Common.h>

@implementation GGUtil

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@YES
                                  forKey:NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        DLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

#pragma mark -
#pragma mark Image
+ (UIImage *)scaleAndRotateImage:(UIImage *)image withSize:(CGSize)size{
    CGFloat  maxWidth=size.width;
    CGFloat  maxHeight=size.height;
	
	CGImageRef imgRef = image.CGImage;
	
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGAffineTransform transform = CGAffineTransformIdentity;
    
	CGRect bounds = CGRectMake(0, 0, width, height);
    
    if (width > maxWidth || height > maxHeight) {
        CGFloat maxRatio = maxWidth/maxHeight;
		CGFloat ratio = width/height;
		if (ratio > maxRatio) {
			bounds.size.width = maxWidth;
			bounds.size.height = bounds.size.width / ratio;
		}
		else {
			bounds.size.height = maxHeight;
			bounds.size.width = bounds.size.height * ratio;
		}
	}
	
	CGFloat scaleRatio = bounds.size.width / width;
    
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = image.imageOrientation;
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
			
		case UIImageOrientationLeftMirrored: //EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRightMirrored: //EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;
			
		default:
			[NSException raise:NSInternalInconsistencyException format:NSLocalizedString(@"Invalid image orientation", @"")];
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	//[self setRotatedImage:imageCopy];
	return imageCopy;
}



+(UIImage *)imageAlpha:(UIImage *)inImage{
    
    CGRect imageRect = CGRectMake(0, 0, inImage.size.width, inImage.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    void* data = malloc(inImage.size.height*inImage.size.width*4);
    
    CGContextRef context = CGBitmapContextCreate(data, imageRect.size.width, imageRect.size.height, 8, imageRect.size.width * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(context, imageRect, inImage.CGImage);
    CGContextSetRGBFillColor(context, 1, 1, 1, 1);
    CGContextFillRect(context, imageRect);
    
    CGImageRef finalImage = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:finalImage];       
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(finalImage);
    
    return returnImage;
}




+(UIImage *)imageMono:(UIImage *)originalImage{    
    
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, originalImage.size.width, originalImage.size.height, 8, originalImage.size.width, colorSapce, kCGImageAlphaNone);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    
    UIImage *returnImage = [UIImage imageWithCGImage:bwImage]; // This is result B/W image.
    CGImageRelease(bwImage);
    

    return returnImage;
}

+ (UIImage *)makeAShotWithView:(UIView*)aView
{
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, YES, [UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *rtImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rtImage;
}


+(CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize{
    CGFloat width=originSize.width;
    CGFloat height=originSize.height;
    
    CGFloat wSize=width/maxSize.width;
    CGFloat hSize=height/maxSize.height;
    
    CGFloat currSize= wSize > hSize ? wSize : hSize;
    
    CGFloat finelWidth=width/currSize;
    CGFloat finelHeight=height/currSize;
    
    return CGSizeMake(finelWidth, finelHeight);
}



#pragma mark -
#pragma mark Controller
+ (void)setTableViewBackgroundColor:(UIViewController *)viewController{
    viewController.navigationController.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

+ (void)setTableViewBackgroundImage:(UITableViewController *)viewController{

        viewController.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_ditu.png"]] autorelease];        

}


+ (void)setTableViewBackgroundImage:(UITableViewController *)viewController withImage:(NSString *)imageName{

        viewController.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imageName]]] autorelease];    
 
}


+ (void)setViewBackgroundColor:(UIViewController *)viewController{
//    [viewController.view setBackgroundColor:RGB(241, 238, 233)];
    
    [viewController.view setBackgroundColor:[UIColor whiteColor]];
    
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            //fprintf(stdout, "%s \n",attribute);
            if (attribute[1] == '@'){
                    return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
            }
        }
    }
    return "";
}

+ (NSMutableDictionary *)getClassPropertys:(id)fromClass {
    NSMutableDictionary *props = [[[NSMutableDictionary alloc] init]autorelease];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([fromClass class], &outCount);
    for(i = 0; i < outCount; i++) {
        //        objc_property_t property = properties[i];
        //        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        const char *propType = getPropertyType(property);
        if(propName) {
            
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            if (propertyType) {
                //DLog(@"propName=%@ propType=%@",propertyName,propertyType);                
                [props setObject:propertyType forKey:propertyName];
            } 
        }
    }
    free(properties);
    return props;
}

+ (void)allTextResignFirstResponder:(id)fromClass component:(NSString *)component{
    NSMutableDictionary *props=[self getClassPropertys:fromClass];
    NSString *propType;
    for (NSString *prop in props) {
        propType=[props objectForKey:prop];
        //DLog(@"%@ is '%@'",prop, propType);        
       
        if([propType isEqualToString: component])  {
            //DLog(@"in UITextField: %@", propType);
            SEL s = NSSelectorFromString(prop);
            UIControl *tempText=[(UIControl *)fromClass performSelector:s];
            [tempText resignFirstResponder];
        }
     
	}
    
 
    
}


#pragma mark -
#pragma mark Cell
+ (void) cleanCellFooter: (UITableViewController *)tableView {    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.tableView.tableFooterView = footer;
    [footer release];    
}


#pragma mark -
#pragma mark Color
+ (UIColor *)randomColor
{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark -
#pragma mark Dictionary
+ (NSMutableDictionary *)stringToDictionary:(NSString *)sourceString withSeparator:(NSString *)separator{
    NSArray *chunks = [sourceString componentsSeparatedByString: separator];
    NSMutableDictionary *stringDict=[[NSMutableDictionary alloc]init];
    
    //NSArray *keyValue = [[NSArray alloc]init];
    for(NSString *chunk in chunks){        
        NSArray *keyValue=[chunk componentsSeparatedByString: @"="];      
        DLog(@"key:%@", [keyValue objectAtIndex:0]);
        DLog(@"value:%@", [keyValue objectAtIndex:1]);        
        [stringDict setValue:[keyValue objectAtIndex:1] forKey:[keyValue objectAtIndex:0]];
        //[keyValue release];        
    }
    //[keyValue release];
    
    return [stringDict autorelease];
}

#pragma mark -
#pragma mark System Check
+ (BOOL)canSendSMS{
    BOOL canSMS=NO;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));

    DLog(@"can send SMS [%d]", [messageClass canSendText]);
    
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            canSMS=YES;
        } else {
            [GGUtil showGGAlert:NSLocalizedString(@"Device can not use SMS.",@"") 
                      title:NSLocalizedString(@"Warning",@"")];

            // [self alertWithTitle:nil msg:@"设备没有短信功能"];
        }
    } else {
        [GGUtil showGGAlert:NSLocalizedString(@"SMS supported on iOS 4.0 .",@"") 
                  title:NSLocalizedString(@"Warning",@"")];
        //[self alertWithTitle:nil msg:@"iOS版本过低，iOS4.0以上才支持程序内发送短信"];
    }
    return canSMS;

}


+ (NSInteger) getSystemVersionAsAnInteger{
    int index = 0;
    NSInteger version = 0;
    
    NSArray* digits = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSEnumerator* enumer = [digits objectEnumerator];
    NSString* number;
    while (number = [enumer nextObject]) {
        if (index>2) {
            break;
        }
        NSInteger multipler = powf(100, 2-index);
        version += [number intValue]*multipler;
        index++;
    }
    return version;
}

+ (BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL)isEnableAPNs
{
    NSInteger value = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    return value > 3;
}

#pragma mark -
#pragma mark Screen
+ (CGFloat)getScreenWidth{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat width = CGRectGetWidth(screen);
    return width;
    
}

+ (CGFloat)getScreenHeight{
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = CGRectGetHeight(screen);
    return height;    
}



#pragma mark -
#pragma mark Alert
+ (void) showGGAlert: (NSString *) theMessage title:(NSString *) theTitle{
    UIAlertView *av = [[[UIAlertView alloc] initWithTitle:theTitle message:theMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"我知道了", @"") otherButtonTitles: nil] autorelease];
    [av show]; 
}

+ (void)showHUD:(NSString*)message inView:(UIView*)aView hideAfter:(CGFloat)second
{
    [MBProgressHUD hideAllHUDsForView:aView animated:NO];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    [HUD setLabelText:message];
    [HUD setMode:MBProgressHUDModeText];
    [HUD hide:YES afterDelay:second];
}

#pragma mark -
#pragma mark URL
+ (NSString *)urlAppendRetina:(NSMutableString *)urlString{
    if ( isRetina) {
        NSRange range = [urlString rangeOfString:@"?"];
        if (range.length == 0) {
            [urlString appendString:@"?hd=1"];
        } else {
            [urlString appendString:@"&hd=1"];
        }
    }
    return  urlString;
}


#pragma mark -
#pragma mark Badge
+ (void)storeBadge{
    NSString *path = [APP_DOCUMENT stringByAppendingString:@"/badge"];
    NSString *badge = [NSString stringWithFormat:@"%d", [[UIApplication sharedApplication] applicationIconBadgeNumber]];
    [badge writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (int)getStoredBadge{
    NSString *path = [APP_DOCUMENT stringByAppendingString:@"/badge"];
    int badge = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] intValue];
    return badge;
}

#pragma mark -
#pragma mark String
+ (BOOL)stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO; 
}

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } 
    
    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO; 
}

+ (NSString*)UUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [[uuidString autorelease] lowercaseString];
}

#pragma mark -
#pragma mark Text
+ (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        CGRect frame = [text boundingRectWithSize:size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        return frame.size;
    }
    else
    {
        return [text sizeWithFont:font constrainedToSize:size];
    }
}

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length{
    NSString* returnString=string;
    if([string length]>length) {
        returnString=[NSString stringWithFormat:@"%@...",[string substringToIndex:length-3]];
    }
    DLog(@"limitString length:%d :%@",[returnString length],returnString);
    return returnString;
}



+ (NSString *)getDistanceText:(double)distance{
    NSString* distanceText=@"";
    if (distance<1000) {
        distanceText=[NSString stringWithFormat:@"%d00米", ((int)distance/100)+1];
    }else{
        distanceText=[NSString stringWithFormat:@"%dkm", ((int)distance/1000)];
    }
    return distanceText;    
}

+ (NSString *)getShowName:(NSString *)username withFirstName:(NSString *)firstName withLastName:(NSString *)lastName{
    if ((firstName && [firstName length]>0) ||  (lastName && [lastName length]>0 )) {
        //DLog(@"username:%@  firstname:%@  lastname:%@ = %@ %@", username,firstName,lastName,firstName,lastName);
        return [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    }else{
        //DLog(@"username:%@  firstname:%@  lastname:%@ = %@ ", username,firstName,lastName,username);
        return username;
    }
}

+ (NSString *)emptyLazyString:(NSString *)source{
    DLog(@"in emptyLazyString: %@ length:%d",source,[source length]);
    //source=@"";
    if ([GGUtil stringIsEmpty:source shouldCleanWhiteSpace:YES]) {
        DLog(@"in emptyLazyString return: %@ ",LS(@"This guy is lazy and have nothing left."));
        return LS(@"This guy is lazy and have nothing left.");
    }else{
        DLog(@"in emptyLazyString return: %@ ",source);
        return source;
    }
}


+ (NSString *)processTextUrl:(NSString *)source{
    
    NSArray *urls = [source componentsMatchedByRegex:@"\\s*(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+\\s+"];
    
   // NSString *returnText = source;
    
    for (NSString *url in urls) {
        DLog(@"tweet find url: %@",url);
        
//       returnText = [returnText stringByReplacingOccurrencesOfString:[dict objectForKey:@"url_long"] withString:[dict objectForKey:@"url_short"]];
        
    } 
    return @"";
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark -
#pragma mark Date
+ (BOOL)isDate:(NSDate*)aDate inTheSameDayTo:(NSDate*)anotherDate
{
    NSString *aDateStr = [GGUtil stringFromDate:aDate Format:@"yyyyMMdd"];
    NSString *antherDateStr = [GGUtil stringFromDate:anotherDate Format:@"yyyyMMdd"];
    return [aDateStr isEqualToString:antherDateStr];
}

+ (NSString*)weekNameInChineseFormDate:(NSDate*)date
{
    NSString *weekNameInEnglish = [GGUtil stringFromDate:date Format:@"E"];
    return weekNameInEnglish;
    if ([weekNameInEnglish isEqualToString:@"Sunday"]) {
       return @"周日";
    }
    else if ([weekNameInEnglish isEqualToString:@"Monday"]) {
        return @"周一";
    }
    else if ([weekNameInEnglish isEqualToString:@"Tuesday"]) {
        return @"周二";
    }
    else if ([weekNameInEnglish isEqualToString:@"Wednesday"]) {
        return @"周三";
    }
    else if ([weekNameInEnglish isEqualToString:@"Thursday"]) {
        return @"周四";
    }
    else if ([weekNameInEnglish isEqualToString:@"Friday"]) {
        return @"周五";
    }
    else if ([weekNameInEnglish isEqualToString:@"Saturday"]) {
        return @"周六";
    }
    return nil;
}

+ (NSString*)getLocalYYMMDD
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *localDateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    return localDateString;
}

+ (NSString*)stringFromDate:(NSDate*)aDate Format:(NSString*)dateFormat
{
    return [GGUtil stringFromDate:aDate format:dateFormat timeZone:[NSTimeZone localTimeZone] dateLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSDate*)dateFromString:(NSString*) dateStr Format:(NSString*)dateFormat
{
    return [GGUtil dateFromString:dateStr format:dateFormat timeZone:[NSTimeZone localTimeZone] dateLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setLocale:locale];
    NSString *localDateString = [dateFormatter stringFromDate:aDate];
    [dateFormatter release];
    return localDateString;
}

+ (NSDate*)dateFromString:(NSString*) dateStr format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter release];
    return date;
}


+ (NSDate *)getToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;

    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *suppliedDate = [calendar dateFromComponents:comps];
    

    
    return suppliedDate;
}

+ (NSString *)timeToText:(NSDate *)time{
    NSString *timeText=@"";
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:(NSYearCalendarUnit | 
                                                         NSMonthCalendarUnit | 
                                                         NSDayCalendarUnit | 
                                                         NSHourCalendarUnit | 
                                                         NSMinuteCalendarUnit | 
                                                         NSSecondCalendarUnit) 
                                               fromDate:time
                                                 toDate:[NSDate date] options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    if ([components year]) {
        timeText = [[formatter stringFromDate:time] substringToIndex:10];
    } else if ([components month]) {
        timeText = [[formatter stringFromDate:time] substringToIndex:10];
    } else if ([components day]) {
        if ([components day] > 7) {
            timeText = [[formatter stringFromDate:time] substringToIndex:10];
        } else {
            timeText = [NSString stringWithFormat:@"%d天前", [components day]];
        }
    } else if ([components hour]) {
        timeText = [NSString stringWithFormat:@"%d小时前", [components hour]];
    } else if ([components minute]) {
        if ([components minute] < 0) {
            timeText = @"刚刚";
        } else {
            timeText = [NSString stringWithFormat:@"%d分钟前", [components minute]];
        }
    } else if ([components second]) {
        if ([components second] < 0) {
            timeText = @"刚刚";
        } else {
            timeText = [NSString stringWithFormat:@"%d秒前", [components second]];
        }
    } else {
        timeText = @"刚刚";
    }
    
    [formatter release];

    return timeText;
}

#pragma mark -
#pragma mark Memory
+ (void)simulateMemoryWarning
{
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), 
                                         (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
#endif
}


//+ (NSString *)genToken:(NSNumber *)currTimestamp withPlus:(int)plus{
//    NSNumber* timeStamp=[NSNumber numberWithInt:[currTimestamp intValue]+plus];
//    NSString* timeStampString=[[NSString stringWithFormat:@"%d",[timeStamp intValue]] reverseString] ;
//    return [NSString base64encode:timeStampString] ;   
//}


#pragma mark -
#pragma mark URL
+ (NSString *)getLargeSinaAvatar:(NSString *)shortUrl{
    NSString *largeUrl=shortUrl;
    NSRange textRange = [shortUrl rangeOfString:@"sinaimg"];
    if(textRange.location != NSNotFound) {
        largeUrl = [shortUrl stringByReplacingOccurrencesOfString:@"/50/" withString:@"/180/"];   
        DLog(@"short url:%@",shortUrl);
        DLog(@"large url:%@",largeUrl);
    }
    return largeUrl;
}

+ (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
    return [result autorelease];
}

+ (id)loadNibWithClassStr:(NSString*)classStr
{
    NSString *suffix = @"";
    if (isPad) {
        suffix = @"-pad";
    }
    else if(isiPhone5){
        suffix = @"-568h";
    }
    return [[[NSClassFromString(classStr) alloc] initWithNibName:[NSString stringWithFormat:@"%@%@",classStr,suffix] bundle:nil] autorelease];
}


+ (BOOL)hasLaunchBeforeAtThisVersion
{
    static BOOL isFirstLaunch = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *str = [NSString stringWithFormat:@"hasLaunchBeforeAt%@",curVersion];
        if ([uDefault boolForKey:str]) {
            isFirstLaunch = YES;
        }
        else {
            [uDefault setBool:YES forKey:str];
            [uDefault synchronize];
            isFirstLaunch = NO;
        }
    });
    return isFirstLaunch;
}

+ (BOOL)isStrongerThaniPhone4
{
    NSString *deviceModel = [[UIDevice currentDevice] deviceModel];
    if([deviceModel isEqualToString:@"x86_64"]){
        return YES;
    }
    if(!isPad){
        if ([deviceModel rangeOfString:@"iPhone"].location != NSNotFound) {
            NSString *modelValue = [deviceModel substringWithRange:NSMakeRange(6, 1)];
            if (modelValue.integerValue > 3) {
                return YES;
            }
        }
        else if([deviceModel rangeOfString:@"iPod"].location != NSNotFound){
            NSString *modelValue = [deviceModel substringWithRange:NSMakeRange(4, 1)];
            if (modelValue.integerValue > 4) {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}


@end
