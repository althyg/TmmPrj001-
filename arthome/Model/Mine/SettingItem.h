//
//  SettingItem.h
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject

/**
 *  图标
 */
@property (nonatomic,copy) NSString * icon;

/**
 * 标题
 */
@property (nonatomic,copy) NSString * title;

/**
 *  子标题
 */
@property (nonatomic,copy) NSString * subTitle;

//@property (nonatomic,assign) CZSettingItemType itemType;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+(instancetype)itemWithTitle:(NSString *)title;

@end
