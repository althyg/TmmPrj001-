//
//  Work.h
//  arthome
//
//  Created by 海修杰 on 16/4/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Work : NSObject
/**
 *  是否喜欢
 */
@property (nonatomic,assign) BOOL  isLiked;
/**
 *  图片链接
 */
@property (nonatomic,copy) NSString * imgUrl;
/**
 *  艺术品名称
 */
@property (nonatomic,copy) NSString * workName;
/**
 *  艺术家名字
 */
@property (nonatomic,copy) NSString * artistName;
/**
 *  艺术品类别
 */
@property (nonatomic,copy) NSString * workType;
/**
 *  艺术品介绍
 */
@property (nonatomic,copy) NSString * workIntro;
/**
 *  艺术品价格
 */
@property (nonatomic,copy) NSString * workPrice;
/**
 *  艺术品id
 */
@property (nonatomic,copy) NSString * artId;



+ (NSArray *)findHomepageGroupFromJosnArray:(NSArray *) listArr;

@end
