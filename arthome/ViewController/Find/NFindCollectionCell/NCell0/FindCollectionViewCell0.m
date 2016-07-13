//
//  FindCollectionViewCell0.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindCollectionViewCell0.h"

@implementation FindCollectionViewCell0

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.fc_headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
        //self.fc_headerImageView.layer.cornerRadius = CGRectGetWidth(self.fc_headerImageView.frame)/2;
        self.fc_headerImageView.layer.cornerRadius = 50;
        self.fc_headerImageView.layer.masksToBounds = YES;
        [self addSubview:self.fc_headerImageView];
        
        
        
        self.fc_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.fc_headerImageView.frame),frame.size.width,20)];
        
        self.fc_nameLabel.font = [UIFont systemFontOfSize:14];
        self.fc_nameLabel.frame = CGRectMake(30, 100, 80, 20);
        //self.fc_introduceLabel.textAlignment = NSTextAlignmentCenter;
        //self.fc_nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.fc_nameLabel];
        
        
        
        
        self.fc_introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.fc_nameLabel.frame), 100, 45)];
        self.fc_introduceLabel.font = [UIFont systemFontOfSize:12];
        self.fc_introduceLabel.textColor = COLOR_cccccc;
        //self.fc_introduceLabel.textAlignment = NSTextAlignmentCenter;
        self.fc_introduceLabel.numberOfLines = 3;
        [self addSubview:self.fc_introduceLabel];
    }
    return self;
}



@end
