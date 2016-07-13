//
//  FindTableViewCell1.h
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindCollectionView1.h"

@interface FindTableViewCell1 : UITableViewCell

@property (strong, nonatomic) FindCollectionView1 *f_CollectionView;


- (void)setCellData:(NSArray *)tc_productArray;


@property (strong, nonatomic) NSString *type;

@end
