//
//  OrderConfir.m
//  arthome
//
//  Created by 海修杰 on 16/4/20.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderConfir.h"

@implementation OrderConfir

+ (NSArray *)orderConfirGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        OrderConfir * orderCon = [[OrderConfir alloc]init];
        orderCon.artImgUrl = [NSString stringWithFormat:@"%@",dict[@"artImgUrl"]];
        orderCon.artInfo = [NSString stringWithFormat:@"%@",dict[@"artInfo"]];
        orderCon.artName = [NSString stringWithFormat:@"%@",dict[@"artName"]];
        orderCon.artPrice = [NSString stringWithFormat:@"%@",dict[@"artPrice"]] ;
        [arrayM addObject:orderCon];
    }
    return arrayM;

}

@end
