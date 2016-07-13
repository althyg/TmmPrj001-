//
//  FindCollectionView1.h
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindCollectionViewCell1.h"

typedef  void (^SelectedCollectionItem) (id);

@interface FindCollectionView1 : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *cc_productArray;

@property (strong, nonatomic) NSString *type;


@property (copy, nonatomic) SelectedCollectionItem selectedCollectionItem;

@end
