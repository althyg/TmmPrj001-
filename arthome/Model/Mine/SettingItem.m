//
//  SettingItem.m
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    SettingItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    SettingItem *item = [self itemWithTitle:title icon:nil];
    item.subTitle = subTitle;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

@end
