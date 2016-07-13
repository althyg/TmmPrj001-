//
//  SettingItemLabel.h
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingItem.h"

@interface SettingItemLabel : SettingItem

/**
 *  文本标签要显示的内容
 */
@property (nonatomic,copy) NSString *value;

+(instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon value:(NSString *)value;

@end
