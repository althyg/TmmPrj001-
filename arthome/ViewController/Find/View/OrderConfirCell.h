//
//  OrderConfirCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/20.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderConfir.h"

@interface OrderConfirCell : UITableViewCell

+(instancetype)orderConfirCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) OrderConfir * orderConfir ;

@end
