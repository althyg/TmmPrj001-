//
//  Focus.m
//  arthome
//
//  Created by 海修杰 on 16/4/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "Focus.h"

@implementation Focus

+ (NSArray *)focusGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        Focus * focus = [[Focus alloc]init];
        focus.artistHeadUrl = dict[@"artistHeadUrl"];
        focus.artistName = dict[@"artistName"];
        focus.artistId = dict[@"artistId"];
        [arrayM addObject:focus];
    }
    return arrayM;

}

@end
