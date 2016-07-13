//
//  ArticleCell.h
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleCell : UITableViewCell

@property (nonatomic,strong) Article * article ;

+(instancetype)articleCellFromTableView:(UITableView *) tableView;

@end
