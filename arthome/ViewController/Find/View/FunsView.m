//
//  FunsView.m
//  arthome
//
//  Created by 海修杰 on 16/4/8.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FunsView.h"
#define FUNSIMGCOUNT 6

@interface FunsView ()

@property (nonatomic,strong) UIButton * likeBtn ;

@end

@implementation FunsView

-(instancetype)initWithFrame:(CGRect)frame{
    CGFloat padding = DEF_RESIZE_UI(20);
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        self.backgroundColor = COLOR_ffffff;
        
        UIView *partLine = [[UIView alloc]init];
        partLine.backgroundColor = COLOR_f2f2f2;
        partLine.frame = CGRectMake(padding+(DEF_RESIZE_UI(30)+padding-DEF_RESIZE_UI(5))*6+DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(1), DEF_RESIZE_UI(30));
        [self addSubview:partLine];
        //喜欢按钮
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeBtn setTitle:@"0" forState:UIControlStateNormal];
        likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, DEF_RESIZE_UI(20));
        likeBtn.titleLabel.font = DEF_MyFont(12);
        [likeBtn setTitleColor:COLOR_cccccc forState:UIControlStateNormal];
        self.likeBtn = likeBtn;
        [likeBtn setImage:DEF_IMAGENAME(@"global_collection_white") forState:UIControlStateNormal ];
        [likeBtn setImage:DEF_IMAGENAME(@"global_collection_selectmin") forState:UIControlStateSelected ];
         likeBtn.frame = CGRectMake(CGRectGetMaxX(partLine.frame)+DEF_RESIZE_UI(10), 0,DEF_DEVICE_WIDTH-CGRectGetMaxX(partLine.frame)-DEF_RESIZE_UI(10),DEF_RESIZE_UI(50));
        [likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:likeBtn];
    }
    return self;
}

-(void)likeBtnClick:(UIButton *) btn{
        self.blockLike();
}

-(void)setIsLike:(NSString *)isLike{
    _isLike = isLike;
    if ([isLike integerValue]) {
        UIImageView *popImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"global_collection_selectmin")];
        popImgView.size = CGSizeMake(1, 1);
        [self.likeBtn addSubview:popImgView];
        popImgView.center = self.likeBtn.imageView.center;
        [UIView animateWithDuration:0.2
                         animations:^{
                            popImgView.size = CGSizeMake(self.likeBtn.imageView.width*3, self.likeBtn.imageView.height*3);
                             popImgView.center = self.likeBtn.imageView.center;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2
                                              animations:^{
                                               popImgView.size = self.likeBtn.imageView.size;
                                                popImgView.center = self.likeBtn.imageView.center;
                                              }
                                              completion:^(BOOL finished) {
                                                  [popImgView removeFromSuperview];
                                              }];
                         }];
    }
    self.likeBtn.selected = [isLike integerValue];
}

-(void)setLikeNo:(NSString *)likeNo{
    _likeNo = likeNo;
    [self.likeBtn setTitle:likeNo forState:UIControlStateNormal];
}

-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    //添加6个imageView
    CGFloat padding = DEF_RESIZE_UI(20);
    for (NSInteger index = 0; index<imgArr.count; index++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(padding+(DEF_RESIZE_UI(30)+padding-DEF_RESIZE_UI(5))*index, DEF_RESIZE_UI(10), DEF_RESIZE_UI(30), DEF_RESIZE_UI(30));
        imgView.layer.cornerRadius = DEF_RESIZE_UI(30)*0.5;
        imgView.layer.masksToBounds = YES;
        [self addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgArr[index]] placeholderImage:DEF_IMAGENAME(@"global_default_img")];
    }

}

@end
