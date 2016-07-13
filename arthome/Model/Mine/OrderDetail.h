//
//  OrderDetail.h
//  arthome
//
//  Created by 海修杰 on 16/3/23.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetail : NSObject

/**
 *  订单id
 */
@property (nonatomic,copy) NSString * orderId;
/**
 *  订单类型
 */
@property (nonatomic,copy) NSString * orderType;
/**
 *  艺术家id
 */
@property (nonatomic,copy) NSString * artistId;
/**
 *  艺术家头像
 */
@property (nonatomic,copy) NSString * headImg;
/**
 *  艺术家名字
 */
@property (nonatomic,copy) NSString * artistName;
/**
 *  艺术品id
 */
@property (nonatomic,copy) NSString * artId;
/**
 *  艺术品图片url
 */
@property (nonatomic,copy) NSString * artImgUrl;
/**
 *  作品介绍
 */
@property (nonatomic,copy) NSString * picIntr;
/**
 *  作品价格
 */
@property (nonatomic,copy) NSString * price;

+ (NSArray *)orderListsGroupFromJosnArray:(NSArray *) listArr;

@end
