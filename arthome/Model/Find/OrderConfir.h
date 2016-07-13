//
//  OrderConfir.h
//  arthome
//
//  Created by 海修杰 on 16/4/20.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderConfir : NSObject
/**
 *  图像路径
 */
@property (nonatomic,copy) NSString * artImgUrl;
/**
 *  作品名称
 */
@property (nonatomic,copy) NSString * artName;
/**
 *  作品信息
 */
@property (nonatomic,copy) NSString * artInfo;
/**
 *  作品价格
 */
@property (nonatomic,copy) NSString * artPrice;

+ (NSArray *)orderConfirGroupFromJosnArray:(NSArray *) listArr;

@end
