//
//  AddressChoseCell.h
//  arthome
//
//  Created by 海修杰 on 16/7/4.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDetail.h"

@interface AddressChoseCell : UITableViewCell

@property (nonatomic,strong) AddressDetail * addressDetail ;

+(instancetype)addressChoseCellFromTableView:(UITableView *) tableView;

@end
