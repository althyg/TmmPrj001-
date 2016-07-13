//
//  AddressDetail.m
//  arthome
//
//  Created by 海修杰 on 16/4/11.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AddressDetail.h"

@implementation AddressDetail

+ (NSArray *)addressDetailGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in listArr) {
        AddressDetail * detail = [[AddressDetail alloc]init];
        detail.userName = dict[@"receName"];
        detail.userPhone = dict[@"recePhone"];
        detail.shippingAddress = dict[@"receLocation"];
        detail.locationId = dict[@"locationId"];
        detail.isDefaulted = dict[@"isDefaulted"];
        [arrayM addObject:detail];
    }
    return arrayM;
}

@end
