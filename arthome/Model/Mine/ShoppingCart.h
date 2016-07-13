//
//  ShoppingCart.h
//  arthome
//
//  Created by 海修杰 on 16/4/13.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCart : NSObject
/**
 *  作品id
 */
@property (nonatomic,copy) NSString * artId;
/**
 *  图像路径
 */
@property (nonatomic,copy) NSString * imgUrl;
/**
 *  作品名称
 */
@property (nonatomic,copy) NSString * workName;
/**
 *  作品介绍
 */
@property (nonatomic,copy) NSString * workIntro;
/**
 *  作品价格
 */
@property (nonatomic,copy) NSString * workPrice;
/**
 *  是否被选中
 */
@property (nonatomic,assign) BOOL  selected;


+ (NSArray *)shoppingCartGroupFromJosnArray:(NSArray *) listArr;

@end
