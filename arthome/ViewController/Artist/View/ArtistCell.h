//
//  ArtistCell.h
//  arthome
//
//  Created by 海修杰 on 16/3/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

typedef void(^FocusBlock)();
typedef void (^ArtBlock)(NSInteger index);

@interface ArtistCell : UITableViewCell


+(instancetype)artistCellFromTableView:(UITableView *) tableView;

@property (nonatomic,strong) Artist * artist ;

@property (nonatomic,copy) FocusBlock  focusBlock;

@property (nonatomic,copy) ArtBlock  artBlock;

@property (nonatomic,strong) UIButton * focusBtn ;

@property (nonatomic,strong) UILabel * fansNum ;

@end
