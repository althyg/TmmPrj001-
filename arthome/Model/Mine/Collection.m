//
//  Collection.m
//  arthome
//
//  Created by 海修杰 on 16/4/27.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "Collection.h"

@implementation Collection

+ (NSArray *)collectionGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        Collection * collection = [[Collection alloc]init];
        collection.artId = [NSString stringWithFormat:@"%@",dict[@"artId"]];
        collection.artImgUrl = [NSString stringWithFormat:@"%@",dict[@"artImgUrl"]];
        collection.artInfo = [NSString stringWithFormat:@"%@",dict[@"artInfo"]];
        collection.artName = [NSString stringWithFormat:@"%@",dict[@"artName"]];
        collection.artPrice = [NSString stringWithFormat:@"%@",dict[@"artPrice"]] ;
        [arrayM addObject:collection];
    }
    return arrayM;
}


@end
