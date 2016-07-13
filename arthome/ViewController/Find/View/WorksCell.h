//
//  WorksCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Work.h"
typedef void(^BlockButton)();
typedef  void(^AddCart)();

@interface WorksCell : UITableViewCell

+(instancetype)worksCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) Work * work ;

@property (nonatomic, copy) BlockButton buttonBlock;

@property (nonatomic,copy) AddCart addCartBlock;

@end
