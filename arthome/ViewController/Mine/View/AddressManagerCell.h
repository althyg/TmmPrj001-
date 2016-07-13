//
//  AddressManagerCell.h
//  arthome
//
//  Created by 海修杰 on 16/6/29.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDetail.h"
typedef void(^BlockDelete)();
typedef void(^BlockEdit)();

@interface AddressManagerCell : UITableViewCell

@property (nonatomic,strong) AddressDetail * addressDetail ;

+(instancetype)addressManagerCellFromTableView:(UITableView *) tableView;

@property (nonatomic,copy) BlockDelete blockDelete ;

@property (nonatomic,copy) BlockEdit blockEdit ;

@end
