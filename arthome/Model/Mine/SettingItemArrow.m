//
//  SettingItemArrow.m
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "SettingItemArrow.h"

@implementation SettingItemArrow

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc{
    SettingItemArrow *itemArrow = [self itemWithTitle:title icon:icon];
    itemArrow.destVc = destVc;
    return itemArrow;
}
+(instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc{
    return [self itemWithTitle:title icon:nil destVc:destVc];
}
@end
