//
//  ArticleFavo.h
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleFavo : NSObject

@property (nonatomic,copy) NSString * articleTitle ;

@property (nonatomic,copy) NSString * articleSource ;

@property (nonatomic,copy) NSString * articleNo ;

@property (nonatomic,copy) NSString * articleDate ;

@property (nonatomic,copy) NSString * articleId ;

+ (NSArray *)articleFavoGroupFromJosnArray:(NSArray *) listArr;

@end
