//
//  ArtFavoCell.h
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtFavo.h"

@interface ArtFavoCell : UITableViewCell

@property (nonatomic,strong) ArtFavo * artFavo ;

+(instancetype)artFavoCellFromTableView:(UITableView *) tableView;

@end
