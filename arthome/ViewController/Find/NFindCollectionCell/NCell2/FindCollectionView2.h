//
//  FindCollectionView2.h
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindCollectionViewCell2.h"
#import "CCViewLayout2.h"

typedef  void (^SelectedCollectionItem) (id);

@interface FindCollectionView2 : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionViewLayoutDelegate>

@property (strong, nonatomic) NSArray *cc_productArray;

@property (copy, nonatomic) SelectedCollectionItem selectedCollectionItem;


@property (nonatomic, strong) NSArray *cellSizes_s1;
@property (nonatomic, strong) NSArray *cellSizes_s2;
@end

