//
//  SettingItemLabel.m
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "SettingItemLabel.h"

@implementation SettingItemLabel

+(instancetype)itemWithTitle:(NSString *)title value:(NSString *)value{
    SettingItemLabel *itemLabel = [self itemWithTitle:title icon:nil];
    itemLabel.value = value;
    return itemLabel;
}

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon value:(NSString *)value{
    SettingItemLabel *itemLabel = [self itemWithTitle:title icon:icon];
    itemLabel.value = value;
    return itemLabel;
}

@end
