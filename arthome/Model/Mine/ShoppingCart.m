//
//  ShoppingCart.m
//  arthome
//
//  Created by 海修杰 on 16/4/13.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ShoppingCart.h"

@implementation ShoppingCart

+ (NSArray *)shoppingCartGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray array];
            for (NSDictionary *dict in listArr) {
                ShoppingCart * cart = [[ShoppingCart alloc]init];
                cart.imgUrl = dict[@"artImgUrl"];
                cart.workName = dict[@"artName"];
                cart.workIntro = dict[@"artInfo"];
                cart.workPrice = dict[@"artPrice"];
                cart.artId = dict[@"artId"];
                [arrayM addObject:cart];
            }

      return arrayM;
}

@end
