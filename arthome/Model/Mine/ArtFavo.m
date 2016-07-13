//
//  ArtFavo.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtFavo.h"

@implementation ArtFavo

+ (NSArray *)artFavoGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in listArr) {
        ArtFavo * artFavo = [[ArtFavo alloc]init];
        artFavo.artImgUrl = dict[@"artImgUrl"];
        artFavo.artName = dict[@"artName"];
        artFavo.artInfo = dict[@"artInfo"];
        artFavo.artPrice = dict[@"artPrice"];
        artFavo.artId = dict[@"artId"];
        [arrayM addObject:artFavo];
    }
    return arrayM;
}

@end
