//
//  FindCollectionViewCell2.m
//  arthome
//
//  Created by qzwh on 16/7/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindCollectionViewCell2.h"

@implementation FindCollectionViewCell2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.fc_headerImageView = [[UIImageView alloc]init];
        self.fc_headerImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.fc_headerImageView];
        //        self.backgroundColor = [self randomColor];
        //        self.fc_headerImageView.backgroundColor = [self randomColor];
        
        NSLog(@"图片大小: %@", NSStringFromCGRect(self.fc_headerImageView.frame));
        
        
        //        self.fc_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
        //                                                                      CGRectGetMaxY(self.fc_headerImageView.frame),
        //                                                                      frame.size.width,
        //                                                                      20)];
        //        self.fc_nameLabel.font = [UIFont systemFontOfSize:16];
        //        self.fc_nameLabel.textAlignment = NSTextAlignmentCenter;
        //        [self addSubview:self.fc_nameLabel];
        //
        //
        //
        //
        //        self.fc_introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
        //                                                                           CGRectGetMaxY(self.fc_nameLabel.frame), frame.size.width, 60)];
        //        self.fc_introduceLabel.font = [UIFont systemFontOfSize:14];
        //        self.fc_introduceLabel.textColor = [UIColor grayColor];
        //        self.fc_introduceLabel.textAlignment = NSTextAlignmentCenter;
        //        self.fc_introduceLabel.numberOfLines = 3;
        //        [self addSubview:self.fc_introduceLabel];
    }
    return self;
}


- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.fc_headerImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
