//
//  FindCollectionView2.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindCollectionView2.h"

@implementation FindCollectionView2


- (NSArray *)cellSizes_s1 {
    if (!_cellSizes_s1) {
        _cellSizes_s1 = @[
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(140), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(140), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))]
                          
                          
                          ];
    }
    return _cellSizes_s1;
}

- (NSArray *)cellSizes_s2 {
    if (!_cellSizes_s2) {
        _cellSizes_s2 = @[
                          
                          
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(140), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))],
                          [NSValue valueWithCGSize:CGSizeMake(DEF_RESIZE_UI(180), DEF_RESIZE_UI(140))]
                          
                          ];
    }
    return _cellSizes_s2;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        CCViewLayout2 *clayout = (CCViewLayout2 *)layout;
        clayout.layoutDelegate = self;
        [self registerClass:[FindCollectionViewCell2 class] forCellWithReuseIdentifier:@"FindCollectionViewCell2"];
        
    }
    return self;
}

#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //返回一个CollectionView里面的组数
    if (self.cc_productArray.count == 0) {
        return 0;
    }
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindCollectionViewCell2" forIndexPath:indexPath];
    
    NSURL *iURL = [NSURL URLWithString:[[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"artImagUrl"]];
    [cell.fc_headerImageView sd_setImageWithURL:iURL];
    [cell layoutIfNeeded];
    
    return cell;
}



#pragma mark - UICollectionViewDelegateWaterfallLayout


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedCollectionItem([self.cc_productArray objectAtIndex:indexPath.row]);
}



- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(CCViewLayout2 *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [self.cellSizes_s1[indexPath.item % 6] CGSizeValue];
    } else {
        
        return [self.cellSizes_s2[indexPath.item % 6] CGSizeValue];
    }}


@end
