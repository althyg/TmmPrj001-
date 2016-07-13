//
//  ArtStudio.h
//  arthome
//
//  Created by 海修杰 on 16/5/19.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtStudio : NSObject
/**
 *  作品id
 */
@property (nonatomic,copy) NSString * artId;
/**
 *  作品imgUrl
 */
@property (nonatomic,copy) NSString * artImgUrl;

+ (NSArray *)studionGroupFromJosnArray:(NSArray *) listArr;

@end
