#import <UIKit/UIKit.h>
@interface ITTBaseModelObject :NSObject <NSCoding,NSCopying> {

}
-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;
@end
