//
//  FindTableViewCell2.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindTableViewCell2.h"

@implementation FindTableViewCell2

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
        
        CCViewLayout2 *layout = [[CCViewLayout2 alloc] init];
        layout.layoutDelegate = self.f_CollectionView;
        self.f_CollectionView = [[FindCollectionView2 alloc] initWithFrame:CGRectMake(0,
                                                                                      0,
                                                                                      DEF_DEVICE_WIDTH,
                                                                                      DEF_RESIZE_UI(330))
                                                      collectionViewLayout:layout];
        
        self.f_CollectionView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.f_CollectionView];
    }
    
    return self;
}

- (void)setCellData:(NSArray *)tc_productArray {
    
    self.f_CollectionView.cc_productArray = tc_productArray;
    [self.f_CollectionView reloadData];
}


@end
