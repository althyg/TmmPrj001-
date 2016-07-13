//
//  Focus.h
//  arthome
//
//  Created by 海修杰 on 16/4/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Focus : NSObject

@property (nonatomic,copy) NSString * artistHeadUrl;

@property (nonatomic,copy) NSString * artistName;

@property (nonatomic,copy) NSString * artistId;

+ (NSArray *)focusGroupFromJosnArray:(NSArray *) listArr;

@end
