//
//  Work.m
//  arthome
//
//  Created by 海修杰 on 16/4/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "Work.h"

@implementation Work

+ (NSArray *)findHomepageGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:listArr.count];
    for (NSDictionary * dict in listArr) {
        Work * work = [[Work alloc]init];
        work.artId = dict[@"artId"];
        work.imgUrl = dict[@"imgUrl"];
        work.workName = dict[@"artName"];
        work.artistName = dict[@"artist"];
        work.workType = dict[@"artType"];
        work.workIntro = dict[@"artIntro"];
        work.workPrice = dict[@"artPrice"];
        [arrayM addObject:work];
    }
    return arrayM;
}

@end
