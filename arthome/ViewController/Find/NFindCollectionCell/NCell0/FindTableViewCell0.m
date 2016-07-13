//
//  FindTableViewCell0.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindTableViewCell0.h"

@implementation FindTableViewCell0

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemSize = CGSizeMake(100, 160);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        self.f_CollectionView = [[FindCollectionView0 alloc] initWithFrame:CGRectMake(0,0,DEF_DEVICE_WIDTH,DEF_RESIZE_UI(200)) collectionViewLayout:layout];
        
        self.f_CollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.f_CollectionView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    
}

- (void)setCellData:(NSArray *)tc_productArray {
    
    self.f_CollectionView.cc_productArray = tc_productArray;
    [self.f_CollectionView reloadData];
}

@end
