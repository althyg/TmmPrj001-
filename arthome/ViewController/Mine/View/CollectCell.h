//
//  CollectCell.h
//  arthome
//
//  Created by 海修杰 on 16/4/27.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collection.h"

@interface CollectCell : UITableViewCell

@property (nonatomic,strong) Collection * collection ;

+(instancetype)collectionCellFromTableView:(UITableView *) tableView;

@end
