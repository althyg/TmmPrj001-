//
//  ArtStudio.m
//  arthome
//
//  Created by 海修杰 on 16/5/19.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtStudio.h"

@implementation ArtStudio

+ (NSArray *)studionGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        ArtStudio * artStudio = [[ArtStudio alloc]init];
        artStudio.artId = [NSString stringWithFormat:@"%@",dict[@"artId"]];
        artStudio.artImgUrl = [NSString stringWithFormat:@"%@",dict[@"artImgUrl"]];
        [arrayM addObject:artStudio];
    }
    return arrayM;
}

@end
