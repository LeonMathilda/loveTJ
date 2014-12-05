

#import "ITTBaseModelObject.h"
#import <objc/runtime.h>
@implementation ITTBaseModelObject

-(id)initWithDataDic:(NSDictionary*)data{
	if (self = [super init]) {
		[self setAttributes:data];
	}
	return self;
}
-(NSDictionary*)attributeMapDictionary{
	return nil;
}

-(SEL)setSetterSelWithAttibuteName:(NSString*)attributeName{
	NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}
-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName
{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
	NSString *setterSelStr = [NSString stringWithFormat:@"get%@%@:",capital,[attributeName substringFromIndex:1]];
	return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
	return nil;
}

- (NSString *)description{
	NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			if (valueObj) {
				[attrsDesc appendFormat:@" [%@=%@] ",attributeName,valueObj];		
				//[valueObj release];			
			}else {
				[attrsDesc appendFormat:@" [%@=nil] ",attributeName];		
			}
			
		}
	}
	
	NSString *customDesc = [self customDescription];
	NSString *desc;
	
	if (customDesc && [customDesc length] > 0 ) {
		desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
	}else {		
		desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
	}
	
	return desc;
}
-(void)setAttributes:(NSDictionary*)dataDic{
    if (![dataDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL sel = [self setSetterSelWithAttibuteName:attributeName];
		if ([self respondsToSelector:sel]) {
			NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            id value=[dataDic objectForKey:dataDicKey];
            if ([value isKindOfClass:[NSNull class]]) {
                value=nil;
            }
			[self performSelectorOnMainThread:sel 
														 withObject:value
													waitUntilDone:[NSThread isMainThread]];
		}
    }
}
- (id)initWithCoder:(NSCoder *)decoder{
	if( self = [super init] ){
		NSDictionary *attrMapDic = [self attributeMapDictionary];
		if (attrMapDic == nil) {
			return self;
		}
		NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
		id attributeName;
		while ((attributeName = [keyEnum nextObject])) {
			SEL sel = [self setSetterSelWithAttibuteName:attributeName];
			if ([self respondsToSelector:sel]) {
				id obj = [decoder decodeObjectForKey:attributeName];
				[self performSelectorOnMainThread:sel 
															 withObject:obj
														waitUntilDone:[NSThread isMainThread]];
			}
		}
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
	NSDictionary *attrMapDic = [self attributeMapDictionary];
	if (attrMapDic == nil) {
		return;
	}
	NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
	id attributeName;
	while ((attributeName = [keyEnum nextObject])) {
		SEL getSel = NSSelectorFromString(attributeName);
		if ([self respondsToSelector:getSel]) {
			NSMethodSignature *signature = nil;
			signature = [self methodSignatureForSelector:getSel];
			NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
			[invocation setTarget:self];
			[invocation setSelector:getSel];
			NSObject *valueObj = nil;
			[invocation invoke];
			[invocation getReturnValue:&valueObj];
			
			if (valueObj) {
                
				[encoder encodeObject:valueObj forKey:attributeName];	
			}
		}
	}
}

- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);

        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
- (id)copyWithZone:(NSZone *)zone
{
    ITTBaseModelObject *copyModel=[[self.class alloc]init];
    NSDictionary *allPropertiesAndValue=[self getAllPropertiesAndVaules];
    for (int i=0; i<allPropertiesAndValue.allKeys.count; i++) {
        id attributeName=[allPropertiesAndValue.allKeys objectAtIndex:i];
        
        SEL getSel = NSSelectorFromString(attributeName);
        SEL setSel=[self setSetterSelWithAttibuteName:attributeName];
        
        if ([self  respondsToSelector:getSel]) {
            id subProperties=[self performSelector:getSel];
            id subPropertiesValue=[allPropertiesAndValue objectForKey:attributeName];
            
            if ([copyModel respondsToSelector:setSel]) {
                if ([[subProperties class] isSubclassOfClass:[ITTBaseModelObject class]]) {
                    [copyModel performSelectorOnMainThread:setSel withObject:[subPropertiesValue copy] waitUntilDone:[NSThread isMainThread]];
                }else
                {
                    [copyModel performSelectorOnMainThread:setSel withObject:subPropertiesValue  waitUntilDone:[NSThread isMainThread]];
                }
            }
            
        }
    }
    return copyModel;
}
- (NSData*)getArchivedData{
	return [NSKeyedArchiver archivedDataWithRootObject:self];
}
@end
