//
//  ArtFavo.h
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtFavo : NSObject

@property (nonatomic,copy) NSString * artImgUrl ;

@property (nonatomic,copy) NSString * artName ;

@property (nonatomic,copy) NSString * artInfo ;

@property (nonatomic,copy) NSString * artPrice ;

@property (nonatomic,copy) NSString * artId ;

+ (NSArray *)artFavoGroupFromJosnArray:(NSArray *) listArr;

@end
