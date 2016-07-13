//
//  AddressDetail.h
//  arthome
//
//  Created by 海修杰 on 16/4/11.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressDetail : NSObject
/**
 *  地址id
 */
@property (nonatomic,copy) NSString * locationId;
/**
 *  用户姓名
 */
@property (nonatomic,copy) NSString * userName;
/**
 *  联系号码
 */
@property (nonatomic,copy) NSString * userPhone;
/**
 *  是否默认
 */
@property (nonatomic,copy) NSString * isDefaulted;
/**
 *  收货地址
 */
@property (nonatomic,strong) NSString * shippingAddress ;

+ (NSArray *)addressDetailGroupFromJosnArray:(NSArray *) listArr;

@end
