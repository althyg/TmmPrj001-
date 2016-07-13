//
//  FunsCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Funs.h"

@interface FunsCell : UITableViewCell

+(instancetype)funsCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) Funs * funs ;

@end
