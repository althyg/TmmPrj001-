//
//  FindCollectionView1.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindCollectionView1.h"

@implementation FindCollectionView1

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[FindCollectionViewCell1 class] forCellWithReuseIdentifier:@"FindCollectionViewCell"];
        
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
    FindCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindCollectionViewCell" forIndexPath:indexPath];
    
    NSURL *iURL = [[NSURL alloc] init];
    
    
    if ([self.type isEqualToString:@"calligraphy"]) {
        
        iURL = [NSURL URLWithString:[[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"calligraphyUrl"]];
        [cell.fc_headerImageView sd_setImageWithURL:iURL];
        
        cell.fc_nameLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"calligraphyName"];
        cell.fc_introduceLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"calligraphyAuthor"];
        
    } else if ([self.type isEqualToString:@"countriesdraw"]) {
        
        iURL = [NSURL URLWithString:[[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"countriesdrawUrl"]];
        [cell.fc_headerImageView sd_setImageWithURL:iURL];
        
        cell.fc_nameLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"countriesdrawName"];
        cell.fc_introduceLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"countriesdrawAuthor"];
    } else if ([self.type isEqualToString:@"miscellaneous"]) {
        
        iURL = [NSURL URLWithString:[[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"oildrawUrl"]];
        [cell.fc_headerImageView sd_setImageWithURL:iURL];
        
        cell.fc_nameLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"miscellaneousName"];
        cell.fc_introduceLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"miscellaneousAuthor"];
    } else if ([self.type isEqualToString:@"oildraw"]) {
        
        iURL = [NSURL URLWithString:[[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"oildrawUrl"]];
        [cell.fc_headerImageView sd_setImageWithURL:iURL];
        
        cell.fc_nameLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"oildrawName"];
        cell.fc_introduceLabel.text = [[self.cc_productArray objectAtIndex:indexPath.row] objectForKey:@"oildrawAuthor"];
    }
    
    
    return cell;
}


#pragma mark - PLCollectionViewDelegateWaterfallLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中的 item %ld", (long)indexPath.row);
    
    self.selectedCollectionItem([self.cc_productArray objectAtIndex:indexPath.row]);
}

@end
