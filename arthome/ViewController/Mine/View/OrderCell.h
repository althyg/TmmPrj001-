//
//  OrderCell.h
//  arthome
//
//  Created by 海修杰 on 16/3/23.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetail.h"
typedef void(^BlockHead)();
typedef void(^BlockRightBtn)();
typedef void(^BlockLeftBtn)();

@interface OrderCell : UITableViewCell

+(instancetype)orderCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) OrderDetail * detail ;

@property (nonatomic,copy) BlockHead blockHead;

@property (nonatomic,copy) BlockRightBtn blockRightBtn;

@property (nonatomic,copy) BlockLeftBtn blockLeftBtn;

@end
