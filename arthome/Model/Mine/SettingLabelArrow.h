//
//  SettingLabelArrow.h
//  weike
//
//  Created by CaiMiao on 15/10/15.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingItem.h"

@interface SettingLabelArrow : SettingItem

@property (nonatomic,assign) Class destVc;

@property (nonatomic,copy) NSString * arrowTitle;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString * )icon arrowTitle:(NSString *)arrowTitle destVc:(Class)destVc;

@end
