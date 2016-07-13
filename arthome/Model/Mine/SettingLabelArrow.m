//
//  SettingLabelArrow.m
//  weike
//
//  Created by CaiMiao on 15/10/15.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "SettingLabelArrow.h"

@implementation SettingLabelArrow
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString * )icon arrowTitle:(NSString *)arrowTitle destVc:(Class)destVc{
    SettingLabelArrow *itemLabel = [self itemWithTitle:title icon:nil];
    itemLabel.arrowTitle = arrowTitle;
    itemLabel.destVc=destVc;
    itemLabel.icon=icon;
    return itemLabel;
}

@end
