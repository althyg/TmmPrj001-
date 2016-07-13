
//  一个Province模型对象代表一个省份

#import <Foundation/Foundation.h>

#import "City.h"

@interface Province : NSObject
/**
 * 该省的所有城市
 */
@property(nonatomic,strong) NSArray *cities;
/**
 *  省份的名字
 */
@property(nonatomic,copy) NSString *name;

+(NSArray *)provinces;
@end
