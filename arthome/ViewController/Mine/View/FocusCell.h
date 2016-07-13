//
//  FocusCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Focus.h"

@interface FocusCell : UITableViewCell

+(instancetype)focusCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) Focus * focus ;

@end
