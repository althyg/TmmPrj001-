//
//  Artist.h
//  arthome
//
//  Created by 海修杰 on 16/3/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArtOfArtist.h"

@interface Artist : NSObject
/**
 *  艺术家id
 */
@property (nonatomic,copy) NSString * artistId;
/**
 *  艺术家头像url
 */
@property (nonatomic,copy) NSString * headImg;
/**
 *  艺术家名称
 */
@property (nonatomic,copy) NSString * artistName;
/**
 *  艺术家签名
 */
@property (nonatomic,copy) NSString * artistSign;
/**
 *  艺术家粉丝
 */
@property (nonatomic,copy) NSString * artistFuns;
/**
 *  是否被关注
 */
@property (nonatomic,copy) NSString * isFocused;
/**
 *  艺术家代表作
 */
@property (nonatomic,strong) NSArray * typicalArts ;


+ (NSArray *)artistHomepageGroupFromJosnArray:(NSArray *) listArr;

@end
