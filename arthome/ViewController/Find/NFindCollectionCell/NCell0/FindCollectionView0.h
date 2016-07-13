//
//  FindCollectionView0.h
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

// 通过代理方法把选中的数据传递

typedef  void (^SelectedCollectionItem) (id);


@interface FindCollectionView0 : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *cc_productArray;


@property (copy, nonatomic) SelectedCollectionItem selectedCollectionItem;

@end
