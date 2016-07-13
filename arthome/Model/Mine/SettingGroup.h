//
//  SettingGroup.h
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject

@property (nonatomic,strong) NSArray *items;
/**
 *  组的头部描述
 */
@property (nonatomic,copy) NSString * headerTitle;
/**
 *  组的尾部描述
 */
@property (nonatomic,copy) NSString * footerTitle;

@end
