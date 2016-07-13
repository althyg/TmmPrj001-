//
//  ArtistView.m
//  arthome
//
//  Created by 海修杰 on 16/5/23.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtistView.h"
#import "ArtOfArtist.h"

@interface ArtistView()

@property (nonatomic,strong) UIImageView * headImg1 ;

@property (nonatomic,strong) UILabel * nameLb ;

@property (nonatomic,strong) UILabel * signLb ;

@property (nonatomic,strong) UILabel * fansNum ;

@property (nonatomic,strong) UIButton * focusBtn ;

@property (nonatomic,strong) UIScrollView * ImgScr ;

@property (nonatomic,strong) NSMutableArray * arrM ;

@end

@implementation ArtistView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_ffffff;
        //艺术家头像
        UIImageView * headImg = [[UIImageView alloc]init];
        self.headImg1 = headImg;
        headImg.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(35), DEF_RESIZE_UI(35));
        headImg.layer.cornerRadius = headImg.width*0.5;
        headImg.layer.masksToBounds = YES;
        [self addSubview:headImg];
        
        //艺术家姓名
        UILabel *nameLb = [[UILabel alloc]init];
        self.nameLb = nameLb;
        nameLb.font = DEF_MyFont(13);
        nameLb.textColor = COLOR_333333;
        nameLb.textAlignment = NSTextAlignmentLeft;
        nameLb.frame = CGRectMake(CGRectGetMaxX(headImg.frame)+DEF_RESIZE_UI(10), headImg.y, DEF_RESIZE_UI(100), DEF_RESIZE_UI(15));
        [self addSubview:nameLb];
        
        //艺术家签名
        UILabel *signLb = [[UILabel alloc]init];
        self.signLb = signLb;
        signLb.font = DEF_MyFont(11);
        signLb.textColor = COLOR_cccccc;
        signLb.textAlignment = NSTextAlignmentLeft;
        signLb.frame = CGRectMake(nameLb.x, CGRectGetMaxY(nameLb.frame)+DEF_RESIZE_UI(5), DEF_RESIZE_UI(200), DEF_RESIZE_UI(11));
        [self addSubview:signLb];
        //tip Image
        UIImageView * tipImg = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"artist_fans_gray")];
        tipImg.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), headImg.y, DEF_RESIZE_UI(16), DEF_RESIZE_UI(14));
        [self addSubview:tipImg];
        
        //fans Lb
        UILabel * fansNum = [[UILabel alloc]init];
        self.fansNum = fansNum;
        fansNum.textColor = COLOR_999999;
        fansNum.textAlignment = NSTextAlignmentCenter;
        fansNum.font = DEF_MyFont(12);
        fansNum.frame = CGRectMake(CGRectGetMaxX(tipImg.frame), headImg.y, DEF_RESIZE_UI(40), DEF_RESIZE_UI(12));
        [self addSubview:fansNum];
        
        //关注 button
        UIButton * focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.focusBtn = focusBtn;
        [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        [focusBtn setTitleColor:COLOR_ff6060 forState:UIControlStateNormal];
        [focusBtn setTitleColor:COLOR_ffffff forState:UIControlStateSelected];
        [focusBtn setBackgroundImage:[ATUtility imageWithColor:COLOR_ffffff] forState:UIControlStateNormal];
        [focusBtn setBackgroundImage:[ATUtility imageWithColor:COLOR_ff6060] forState:UIControlStateSelected];
        focusBtn.layer.borderColor = COLOR_ff6060.CGColor;
        focusBtn.layer.borderWidth = 0.5;
        focusBtn.backgroundColor = COLOR_ffffff;
        focusBtn.titleLabel.font = DEF_MyFont(11);
        [focusBtn addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btnW = DEF_RESIZE_UI(50);
        CGFloat btnH = DEF_RESIZE_UI(25);
        focusBtn.frame = CGRectMake(self.width-btnW-DEF_RESIZE_UI(10), headImg.y, btnW, btnH);
        [self addSubview:focusBtn];
        
        //Scroll View
        UIScrollView * ImgScr = [[UIScrollView alloc]init];
        self.ImgScr = ImgScr;
        [self addSubview:ImgScr];
        ImgScr.showsHorizontalScrollIndicator = NO;
        ImgScr.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(headImg.frame)+DEF_RESIZE_UI(15), self.width-DEF_RESIZE_UI(10)*2, DEF_RESIZE_UI(100));
    }
    return  self;
}

-(void)focusBtnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(focusedBtnClick:)]) {
        [self.delegate focusedBtnClick:self];
    }
}

-(void)setHeadImg:(NSString *)headImg{
    _headImg = headImg;
    [self.headImg1 sd_setImageWithURL:[NSURL URLWithString:headImg] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
}

-(void)setArtistName:(NSString *)artistName{
    _artistName = artistName;
    self.nameLb.text = artistName;
}

-(void)setArtistSign:(NSString *)artistSign{
    _artistSign = artistSign;
    self.signLb.text = artistSign;
}
-(void)setArtistFuns:(NSString *)artistFuns{
    _artistFuns = artistFuns;
    self.fansNum.text = artistFuns;
}

-(void)setIsFocused:(NSString *)isFocused{
    _isFocused = isFocused;
   self.focusBtn.selected =[isFocused integerValue];
}

-(void)setTypicalArts:(NSArray *)typicalArts{
    _typicalArts = typicalArts;
    NSUInteger imgCount = typicalArts.count;
    for (NSUInteger index = 0; index<imgCount; index++) {
        UIButton * artBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        artBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        artBtn.imageView.clipsToBounds = YES;
        artBtn.tag = 1000+index;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:typicalArts.count];
        self.arrM = arrM;
        for (NSDictionary *dic in typicalArts) {
            ArtOfArtist * artOfArtist = [[ArtOfArtist alloc]init];
            artOfArtist.artId = dic[@"artId"];
            artOfArtist.artImgUrl = dic[@"artImgUrl"];
            [arrM addObject:artOfArtist];
        }
        ArtOfArtist * artOfArtist = arrM[index];
        [artBtn sd_setImageWithURL:[NSURL URLWithString:artOfArtist.artImgUrl] forState:UIControlStateNormal placeholderImage:DEF_DEFAULPLACEHOLDIMG];
        artBtn.frame = CGRectMake(index*(DEF_RESIZE_UI(100)+DEF_RESIZE_UI(10)), 0, DEF_RESIZE_UI(100), DEF_RESIZE_UI(100));
        [artBtn addTarget:self action:@selector(artBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.ImgScr.contentSize = CGSizeMake(imgCount*DEF_RESIZE_UI(100)+(imgCount-1)*DEF_RESIZE_UI(10), 0);
        [self.ImgScr addSubview:artBtn];
    }
}

-(void)artBtnClick:(UIButton *)btn{
     ArtOfArtist * artOfArtist = self.arrM[btn.tag-1000];
    if ([self.delegate respondsToSelector:@selector(artWorkBtnClick:WithArtId:)]) {
        [self.delegate artWorkBtnClick:self WithArtId:artOfArtist.artId];
    }
}

@end




