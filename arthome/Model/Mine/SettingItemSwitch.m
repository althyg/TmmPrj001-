//
//  SettingItemSwitch.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "SettingItemSwitch.h"

@implementation SettingItemSwitch

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    // 根据标题获得开关状态值
    _on = [SaveDataTool boolForKey:title];
}

- (void)setOn:(BOOL)on {
    _on = on;
    [SaveDataTool saveBool:on forKey:self.title];
}


@end
