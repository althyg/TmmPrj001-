//
//  FindTableViewCell2.h
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindCollectionView2.h"
#import "CCViewLayout2.h"

@interface FindTableViewCell2 : UITableViewCell

@property (strong, nonatomic) FindCollectionView2 *f_CollectionView;


- (void)setCellData:(NSArray *)tc_productArray;

@end
