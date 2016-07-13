//
//  Funs.h
//  arthome
//
//  Created by 海修杰 on 16/4/25.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Funs : NSObject

@property (nonatomic,copy) NSString * funsHeadUrl;

@property (nonatomic,copy) NSString * funsName;

+ (NSArray *)funsGroupFromJosnArray:(NSArray *) listArr;

@end
