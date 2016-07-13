//
//  ArtistCell.m
//  arthome
//
//  Created by 海修杰 on 16/3/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtistCell.h"
@interface ArtistCell ()

@property (nonatomic,strong) UIImageView * headImg ;

@property (nonatomic,strong) UILabel * nameLb ;

@property (nonatomic,strong) UILabel * signLb ;

@property (nonatomic,strong) UIScrollView * ImgScr ;

@end

@implementation ArtistCell

+(instancetype)artistCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"artistCell";
    //  去检测有没有空闲的cell
    ArtistCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //  如果没有就创建一个新的
    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //分割View
        UIView *partingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10))];
        partingView.backgroundColor = COLOR_f2f2f2;
        [self.contentView addSubview:partingView];
        //背景View
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(10)*2, DEF_RESIZE_UI(180));
        [self.contentView addSubview:bgView];
        
        //艺术家头像
        UIImageView * headImg = [[UIImageView alloc]init];
        self.headImg = headImg;
        headImg.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(35), DEF_RESIZE_UI(35));
        headImg.layer.cornerRadius = headImg.width*0.5;
        headImg.layer.masksToBounds = YES;
        [bgView addSubview:headImg];
        
        //艺术家姓名
        UILabel *nameLb = [[UILabel alloc]init];
        self.nameLb = nameLb;
        nameLb.font = DEF_MyFont(13);
        nameLb.textColor = COLOR_333333;
        nameLb.textAlignment = NSTextAlignmentLeft;
        nameLb.frame = CGRectMake(CGRectGetMaxX(headImg.frame)+DEF_RESIZE_UI(10), headImg.y, DEF_RESIZE_UI(60), DEF_RESIZE_UI(15));
        [bgView addSubview:nameLb];
        
        //艺术家签名
        UILabel *signLb = [[UILabel alloc]init];
        self.signLb = signLb;
        signLb.font = DEF_MyFont(11);
        signLb.textColor = COLOR_cccccc;
        signLb.textAlignment = NSTextAlignmentLeft;
        signLb.frame = CGRectMake(nameLb.x, CGRectGetMaxY(nameLb.frame)+DEF_RESIZE_UI(5), DEF_RESIZE_UI(200), DEF_RESIZE_UI(11));
        [bgView addSubview:signLb];
        //tip Image
        UIImageView * tipImg = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"artist_fans_gray")];
        tipImg.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), headImg.y, DEF_RESIZE_UI(16), DEF_RESIZE_UI(14));
        [bgView addSubview:tipImg];
        
        //fans Lb
        UILabel * fansNum = [[UILabel alloc]init];
        self.fansNum = fansNum;
        fansNum.textColor = COLOR_999999;
        fansNum.textAlignment = NSTextAlignmentLeft;
        fansNum.font = DEF_MyFont(12);
        fansNum.frame = CGRectMake(CGRectGetMaxX(tipImg.frame)+DEF_RESIZE_UI(5), headImg.y, DEF_RESIZE_UI(40), DEF_RESIZE_UI(12));
        [bgView addSubview:fansNum];
        
        //关注 button
        UIButton * focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.focusBtn = focusBtn;
        [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        [focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
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
        focusBtn.frame = CGRectMake(bgView.width-btnW-DEF_RESIZE_UI(10), headImg.y, btnW, btnH);
        [bgView addSubview:focusBtn];
        
        //Scroll View
        UIScrollView * ImgScr = [[UIScrollView alloc]init];
        ImgScr.scrollsToTop = NO;
        self.ImgScr = ImgScr;
        [bgView addSubview:ImgScr];
        ImgScr.showsHorizontalScrollIndicator = NO;
        ImgScr.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(headImg.frame)+DEF_RESIZE_UI(15), bgView.width-DEF_RESIZE_UI(10)*2, DEF_RESIZE_UI(100));
    }
    return self;
}

-(void)focusBtnClick:(UIButton *) btn{
     self.focusBlock();
}

-(void)setArtist:(Artist *)artist{
    for (UIView * subview in self.ImgScr.subviews ) {
        [subview removeFromSuperview];
    }
    self.ImgScr.contentOffset = CGPointMake(0, 0);
    _artist = artist;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:artist.headImg] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    self.nameLb.text = artist.artistName;
    self.signLb.text = artist.artistSign;
    self.fansNum.text = artist.artistFuns;
    self.focusBtn.selected = [artist.isFocused integerValue];
    NSUInteger imgCount = artist.typicalArts.count;
    for (NSUInteger index = 0; index<imgCount; index++) {
        UIButton * artBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        artBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        artBtn.imageView.clipsToBounds = YES;
        artBtn.tag = 1000+index;
       ArtOfArtist * artOfArtist = artist.typicalArts[index];
        [artBtn sd_setImageWithURL:[NSURL URLWithString:artOfArtist.artImgUrl] forState:UIControlStateNormal placeholderImage:DEF_DEFAULPLACEHOLDIMG];
        artBtn.frame = CGRectMake(index*(DEF_RESIZE_UI(100)+DEF_RESIZE_UI(10)), 0, DEF_RESIZE_UI(100), DEF_RESIZE_UI(100));
        [artBtn addTarget:self action:@selector(artBtnClick:) forControlEvents:UIControlEventTouchUpInside];
         self.ImgScr.contentSize = CGSizeMake(imgCount*DEF_RESIZE_UI(100)+(imgCount-1)*DEF_RESIZE_UI(10), 0);
        [self.ImgScr addSubview:artBtn];
    }
}

-(void)artBtnClick:(UIButton *)btn{
    self.artBlock(btn.tag-1000);
}

@end




