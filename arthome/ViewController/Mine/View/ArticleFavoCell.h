//
//  ArticleFavoCell.h
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleFavo.h"


@interface ArticleFavoCell : UITableViewCell

@property (nonatomic,strong) ArticleFavo * articleFavo ;

+(instancetype)articleFavoCellFromTableView:(UITableView *) tableView;

@end
