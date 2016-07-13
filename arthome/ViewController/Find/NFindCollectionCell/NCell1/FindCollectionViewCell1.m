//
//  FindCollectionViewCell1.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindCollectionViewCell1.h"

@implementation FindCollectionViewCell1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //作品图片
        //self.fc_headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(frame) - DEF_RESIZE_UI(80))/2,6,DEF_RESIZE_UI(120),DEF_RESIZE_UI(120))];
        self.fc_headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,-30,DEF_RESIZE_UI(120),DEF_RESIZE_UI(120))];
//        self.fc_headerImageView.layer.cornerRadius = CGRectGetWidth(self.fc_headerImageView.frame)/2;
//        self.fc_headerImageView.layer.masksToBounds = YES;
        [self addSubview:self.fc_headerImageView];
        
        
        //作品名称
        self.fc_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(self.fc_headerImageView.frame)+10,frame.size.width,20)];
        self.fc_nameLabel.textColor = COLOR_666666;
        self.fc_nameLabel.font = [UIFont systemFontOfSize:14];
        self.fc_nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.fc_nameLabel];
        
        
        
        //作品的作者
        self.fc_introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,                                                        CGRectGetMaxY(self.fc_nameLabel.frame)-10, frame.size.width, DEF_RESIZE_UI(60))];
        self.fc_introduceLabel.font = [UIFont systemFontOfSize:12];
        self.fc_introduceLabel.textColor = COLOR_999999;
        self.fc_introduceLabel.textAlignment = NSTextAlignmentLeft;
        //self.fc_introduceLabel.numberOfLines = 3;
        [self addSubview:self.fc_introduceLabel];
    }
    return self;
}

@end
