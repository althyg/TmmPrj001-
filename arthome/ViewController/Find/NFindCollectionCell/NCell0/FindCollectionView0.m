//
//  FindCollectionView0.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindCollectionView0.h"
#import "FindCollectionViewCell0.h"

@implementation FindCollectionView0

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[FindCollectionViewCell0 class] forCellWithReuseIdentifier:@"FindCollectionViewCell0"];
        
    }
    return self;
}

#pragma mark - UICollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //返回一个CollectionView里面的组数
    if (self.cc_productArray.count == 0) {
        return 0;
    }
    return self.cc_productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCollectionViewCell0 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindCollectionViewCell0" forIndexPath:indexPath];
    ;
    
    
    NSURL *iURL = [NSURL URLWithString:[[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"artistHeardImaUrl"]];
    [cell.fc_headerImageView sd_setImageWithURL:iURL];
    
    cell.fc_nameLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"artistName"];
    cell.fc_introduceLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"artistDesc"];
    
    return cell;
}

#pragma mark - PLCollectionViewDelegateWaterfallLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSLog(@"选中的 item %ld", (long)indexPath.row);
    
    
    self.selectedCollectionItem([self.cc_productArray objectAtIndex:indexPath.row]);
    
}

@end
