//
//  ScreeningCell.h
//  arthome
//
//  Created by qzwh on 16/7/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockButton)();

@interface ScreeningCell : UITableViewCell

+(instancetype)screeningCellFromTableView:(UITableView *) tableView;

@property (nonatomic, copy) BlockButton buttonBlock;

@property (nonatomic,strong) UIButton *myBtn;

@property (nonatomic) BOOL isSelected;

@end
