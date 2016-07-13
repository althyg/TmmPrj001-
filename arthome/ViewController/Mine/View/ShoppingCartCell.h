//
//  ShoppingCartCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/13.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCart.h"

typedef void(^selectBtnBlock)();

@interface ShoppingCartCell : UITableViewCell

+(instancetype)shoppingCartCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) ShoppingCart * shoppingCart ;

@property (nonatomic,copy) selectBtnBlock selectBtnBlock ;

@end
