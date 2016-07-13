//
//  CCViewLayout2.h
//  arthome
//
//  Created by qzwh on 16/7/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCViewLayout2;

@protocol CustomCollectionViewLayoutDelegate <NSObject>

/**
 * 通过代理获取 size
 */
@required
- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(CCViewLayout2 *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CCViewLayout2 : UICollectionViewLayout

@property (assign, nonatomic) id<CustomCollectionViewLayoutDelegate> layoutDelegate;


@end
