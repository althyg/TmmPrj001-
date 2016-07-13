//
//  CCViewLayout2.m
//  arthome
//
//  Created by qzwh on 16/7/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "CCViewLayout2.h"

@interface CCViewLayout2()

@property (assign, nonatomic) CGFloat row1_X;
@property (assign, nonatomic) CGFloat row2_X;

@property (assign, nonatomic) NSInteger cellCount; // cell个数
@property (assign, nonatomic) NSInteger s2_cellCount;
@property (assign, nonatomic) CGFloat   s_itemHeight; // cell 的固定高度
@property (assign, nonatomic) CGFloat   insert; // 间距


@end

@implementation CCViewLayout2

/**
 *  初始化layout后自动调动，可以在该方法中初始化一些自定义的变量参数
 */
- (void)prepareLayout {
    
    [super prepareLayout];
    
    // 初始化参数
    _cellCount = [self.collectionView numberOfItemsInSection:0];   // cell个数，直接从collectionView中获得
    _s2_cellCount = [self.collectionView numberOfItemsInSection:1];
    _insert = 8; // 设置间距
    _s_itemHeight = (self.collectionView.frame.size.height -30)/2;  // item 固定高度
}

/**
 *  设置UICollectionView的内容大小，道理与UIScrollView的contentSize类似
 *
 *  @return 返回设置的UICollectionView的内容大小
 */
- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(MAX(_row1_X, _row2_X), self.collectionView.frame.size.height);
}

/**
 *  初始Layout外观
 *
 *  @param rect 所有元素的布局属性
 *
 *  @return 所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    _row1_X = _insert;
    _row2_X = _insert;
    
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.cellCount; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    for (int i = 0; i < self.s2_cellCount; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}

/**
 *  根据不同的indexPath，给出布局
 *
 *  @param indexPath
 *
 *  @return 布局
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取代理中返回的每一个cell的大小
    CGSize itemSize = [self.layoutDelegate collectionView:self.collectionView collectionViewLayout:self sizeOfItemAtIndexPath:indexPath];
    
    
    
    // 防止代理中给的size.width大于(或小于)layout中定义的width，所以等比例缩放size
    CGFloat itemWidth = floorf(itemSize.width * self.s_itemHeight / itemSize.height);
    
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    
    // 判断当前的item应该在左侧还是右侧
    if (attributes.indexPath.section == 0) {
        
        attributes.frame = CGRectMake(_row1_X, 8, itemWidth, _s_itemHeight);
        _row1_X += itemWidth + _insert;
        
        //        NSLog(@"itemIndex: %@ itemFrame: %@", attributes.indexPath, NSStringFromCGRect(attributes.frame));
    } else {
        
        attributes.frame = CGRectMake(_row2_X, 16+_s_itemHeight, itemWidth, _s_itemHeight);
        _row2_X += itemWidth + _insert;
        //        NSLog(@"itemIndex: %@ itemFrame: %@", attributes.indexPath, NSStringFromCGRect(attributes.frame));
    }
    
    return attributes;
}


@end
