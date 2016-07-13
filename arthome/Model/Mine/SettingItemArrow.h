//
//  SettingItemArrow.h
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingItem.h"

@interface SettingItemArrow : SettingItem
@property (nonatomic,assign) Class destVc;
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc;
+(instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc;
@end
