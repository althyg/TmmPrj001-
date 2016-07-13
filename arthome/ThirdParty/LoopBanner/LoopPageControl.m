//
//  LoopPageControl.m
//  arthome
//
//  Created by 海修杰 on 16/4/5.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "LoopPageControl.h"

@interface LoopPageControl()

@property (nonatomic,strong) UIImageView * selImgView ;

@property (nonatomic,strong) NSMutableArray * imgViewArr ;

@end

@implementation LoopPageControl

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(void)setImgCount:(NSInteger)imgCount{
    NSMutableArray * imgViewArr = [NSMutableArray array];
    _imgViewArr = imgViewArr;
    for (NSInteger index = 0; index<imgCount; index ++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [_imgViewArr addObject:imgView];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.tag = index+1;
        imgView.image = _selImg;
        imgView.backgroundColor = [UIColor blueColor];
        imgView.frame = CGRectMake(_imgDistance*index+10, 0, _imgSize.width, _imgSize.height);
        [self addSubview:imgView];
    }
}

-(void)setSelCount:(NSInteger)selCount{
    for (UIImageView *imgView in _imgViewArr) {
        if (selCount==imgView.tag) {
            imgView.image = _selImg;
        }
        else{
            imgView.image = _nolImg;
        }
    }
}



@end





