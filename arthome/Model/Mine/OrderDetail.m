//
//  OrderDetail.m
//  arthome
//
//  Created by 海修杰 on 16/3/23.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderDetail.h"

@implementation OrderDetail

+ (NSArray *)orderListsGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in listArr) {
        OrderDetail * detail = [[OrderDetail alloc]init];
        detail.orderId = dict[@"orderId"];
        detail.orderType = dict[@"orderType"];
        detail.artistId = dict[@"artistId"];
        detail.headImg = dict[@"headImg"];
        detail.artistName = dict[@"artistName"];
        detail.artId = dict[@"artId"];
        detail.artImgUrl = dict[@"artImgUrl"];
        detail.picIntr = dict[@"picIntr"];
        detail.price = dict[@"price"];
        [arrayM addObject:detail];
    }
    
    return arrayM;
    
}

@end
