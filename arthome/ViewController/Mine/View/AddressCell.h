//
//  AddressCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/11.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDetailFrame.h"

@interface AddressCell : UITableViewCell

+(instancetype)addressCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) AddressDetailFrame * addressDetailFrame ;

@property (nonatomic,assign) BOOL  isDefault;

@end
