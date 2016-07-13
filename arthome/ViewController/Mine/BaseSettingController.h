//
//  BaseSettingController.h
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"
#import "SettingGroup.h"
#import "SettingItemArrow.h"
#import "SettingItemLabel.h"
#import "SettingCell.h"
#import "SettingLabelArrow.h"

@interface BaseSettingController : UITableViewController

/**
 *  所有组
 */
@property (nonatomic,strong,readonly) NSMutableArray *groups;

@end
