//
//  WorkDetailView.h
//  arthome
//
//  Created by 海修杰 on 16/4/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkDetailView : UIView
/**
 *  作品名称
 */
@property (nonatomic,copy) NSString * artName;
/**
 *  作品价格
 */
@property (nonatomic,copy) NSString * artPrice;
/**
 *  作品类型
 */
@property (nonatomic,copy) NSString * artType;
/**
 *  作品信息
 */
@property (nonatomic,copy) NSString * artInfo;
/**
 *  是否装裱
 */
@property (nonatomic,copy) NSString * isPacked;
/**
 *  是否印章
 */
@property (nonatomic,copy) NSString * isSealed;
/**
 *  作品介绍
 */
@property (nonatomic,copy) NSString * artIntro;

@end
