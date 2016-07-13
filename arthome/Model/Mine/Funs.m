//
//  Funs.m
//  arthome
//
//  Created by 海修杰 on 16/4/25.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "Funs.h"

@implementation Funs

+ (NSArray *)funsGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        Funs * funs = [[Funs alloc]init];
        funs.funsHeadUrl = dict[@"funsHeadUrl"];
        funs.funsName = dict[@"artistName"];
        [arrayM addObject:funs];
    }
    return arrayM;
}

@end
