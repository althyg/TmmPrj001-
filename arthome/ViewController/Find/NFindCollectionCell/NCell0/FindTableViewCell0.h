//
//  FindTableViewCell0.h
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindCollectionView0.h"


@interface FindTableViewCell0 : UITableViewCell

@property (strong, nonatomic) FindCollectionView0 *f_CollectionView;
@property (strong, nonatomic) NSArray *tc_productArray;


- (void)setCellData:(NSArray *)tc_productArray;

@end
