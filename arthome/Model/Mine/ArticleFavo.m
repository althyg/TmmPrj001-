//
//  ArticleFavo.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//


#import "ArticleFavo.h"

@implementation ArticleFavo

+ (NSArray *)articleFavoGroupFromJosnArray:(NSArray *) listArr{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in listArr) {
        ArticleFavo * articleFavo = [[ArticleFavo alloc]init];
        articleFavo.articleTitle = dict[@"articleTitle"];
        articleFavo.articleSource = dict[@"articleSource"];
        articleFavo.articleNo = dict[@"articleNo"];
        articleFavo.articleDate = dict[@"articleDate"];
        articleFavo.articleId = dict[@"articleId"];
        [arrayM addObject:articleFavo];
    }
    return arrayM;
}

@end
