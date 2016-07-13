//
//  SettingCell.h
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;

@interface SettingCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) SettingItem *item;
// 是否隐藏分割线
@property (nonatomic,assign) BOOL showLine;

@end
