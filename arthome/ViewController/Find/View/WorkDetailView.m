//
//  WorkDetailView.m
//  arthome
//
//  Created by 海修杰 on 16/4/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "WorkDetailView.h"

@interface WorkDetailView ()

@property (nonatomic,strong) UILabel * workNameLb ;

@property (nonatomic,strong) UILabel * workPriceLb ;

@property (nonatomic,strong) UILabel * workTypeLb ;

@property (nonatomic,strong) UILabel * workInfooLb ;

@property (nonatomic,strong) UILabel * sealLb ;

@property (nonatomic,strong) UILabel * packLb ;

@property (nonatomic,strong) UILabel * workIntroLb ;

@property (nonatomic,strong) UIView * partLine1 ;




@end

@implementation WorkDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat padding = DEF_RESIZE_UI(10);
        self.backgroundColor = [UIColor whiteColor];
       //作品名称
        UILabel *workNameLb = [[UILabel alloc]init];
        self.workNameLb = workNameLb;
        workNameLb.font = DEF_MyFont(14);
        workNameLb.textColor = COLOR_333333;
        workNameLb.textAlignment = NSTextAlignmentLeft;
        workNameLb.frame = CGRectMake(padding, padding, DEF_RESIZE_UI(200), DEF_RESIZE_UI(15));
        [self addSubview:workNameLb];
        //作品价格
        UILabel *workPriceLb = [[UILabel alloc]init];
        self.workPriceLb = workPriceLb;
        workPriceLb.font = DEF_MyBoldFont(14);
        workPriceLb.textColor = COLOR_ff6060;
        workPriceLb.textAlignment = NSTextAlignmentRight;
        workPriceLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(100)-padding, padding+DEF_RESIZE_UI(1), DEF_RESIZE_UI(100), DEF_RESIZE_UI(15));
        [self addSubview:workPriceLb];
        
        //作品类型
        UILabel *workTypeLb = [[UILabel alloc]init];
        self.workTypeLb = workTypeLb;
        workTypeLb.font = DEF_MyFont(12);
        workTypeLb.textColor = COLOR_666666;
        workTypeLb.textAlignment = NSTextAlignmentLeft;
        CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(12));
        CGSize textSize = [self sizeOfString:workTypeLb.text withMaxSize:maxSize andFont:workTypeLb.font];
        workTypeLb.frame = (CGRect){padding,CGRectGetMaxY(workNameLb.frame)+DEF_RESIZE_UI(10),textSize};
        [self addSubview:workTypeLb];
        //分开Line
        UIView *partLine1 = [[UIView alloc]init];
        self.partLine1 = partLine1;
        partLine1.backgroundColor = COLOR_cccccc;
        partLine1.frame = CGRectMake(CGRectGetMaxX(workTypeLb.frame)+DEF_RESIZE_UI(4), workTypeLb.y+DEF_RESIZE_UI(2), 1, DEF_RESIZE_UI(12));
        [self addSubview:partLine1];
        //作品信息
        UILabel *workInfoLb = [[UILabel alloc]init];
        self.workInfooLb = workInfoLb;
        workInfoLb.font = DEF_MyFont(12);
        workInfoLb.textColor = COLOR_666666;
        workInfoLb.textAlignment = NSTextAlignmentLeft;
        workInfoLb.frame = CGRectMake(CGRectGetMaxX(partLine1.frame)+DEF_RESIZE_UI(4), CGRectGetMaxY(workNameLb.frame)+DEF_RESIZE_UI(10)+DEF_RESIZE_UI(1), DEF_RESIZE_UI(250), DEF_RESIZE_UI(12));
        [self addSubview:workInfoLb];
    
        //印章Lb
        UILabel *sealLb = [[UILabel alloc]init];
        self.sealLb = sealLb;
        sealLb.text = @"印章";
        sealLb.font = DEF_MyFont(12);
        sealLb.textColor = [UIColor clearColor];
        sealLb.textAlignment = NSTextAlignmentCenter;
        sealLb.frame = CGRectMake(DEF_DEVICE_WIDTH-padding-DEF_RESIZE_UI(30), workTypeLb.y+DEF_RESIZE_UI(2), DEF_RESIZE_UI(30), DEF_RESIZE_UI(12));
        [self addSubview:sealLb];
        //分开Line
        UIView *partLine2 = [[UIView alloc]init];
        partLine2.backgroundColor = COLOR_cccccc;
        partLine2.frame = CGRectMake(sealLb.x-DEF_RESIZE_UI(3), workTypeLb.y+DEF_RESIZE_UI(2), 1, DEF_RESIZE_UI(12));
        [self addSubview:partLine2];
        //装裱lb
        UILabel *packLb = [[UILabel alloc]init];
        self.packLb = packLb;
        packLb.text = @"装裱";
        packLb.font = DEF_MyFont(12);
        packLb.textColor = [UIColor clearColor];
        packLb.textAlignment = NSTextAlignmentRight;
        packLb.frame = CGRectMake(partLine2.x-DEF_RESIZE_UI(3)-DEF_RESIZE_UI(30), workTypeLb.y+DEF_RESIZE_UI(2), DEF_RESIZE_UI(30), DEF_RESIZE_UI(12));
        [self addSubview:packLb];
        //作品介绍
        UILabel *workIntroLb = [[UILabel alloc]init];
        self.workIntroLb = workIntroLb;
        workIntroLb.numberOfLines = 0;
        workIntroLb.font = DEF_MyFont(11);
        workIntroLb.textColor = COLOR_cccccc;
        [self addSubview:workIntroLb];
        
    self.frame = CGRectMake(0, DEF_RESIZE_UI(250), DEF_DEVICE_WIDTH, CGRectGetMaxY(workIntroLb.frame)+DEF_RESIZE_UI(10));
    }
    return self;
}

//计算文字尺寸大小
- (CGSize) sizeOfString:(NSString *) text withMaxSize:(CGSize ) maxSize andFont:(UIFont *) font{
    NSDictionary *attr = @{NSFontAttributeName:font} ;
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

-(void)setArtName:(NSString *)artName{
    _artName = artName;
    self.workNameLb.text = artName;
    
}
-(void)setArtInfo:(NSString *)artInfo{
    _artInfo = artInfo;
    self.workInfooLb.text = artInfo;
}
-(void)setArtPrice:(NSString *)artPrice{
    _artPrice = artPrice;
    self.workPriceLb.text = artPrice;
}
-(void)setArtType:(NSString *)artType{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(12));
    CGSize textSize = [self sizeOfString:artType withMaxSize:maxSize andFont:self.workTypeLb.font];
    self.workTypeLb.frame = (CGRect){DEF_RESIZE_UI(10),CGRectGetMaxY(self.workNameLb.frame)+DEF_RESIZE_UI(10),textSize};
    self.partLine1.frame = CGRectMake(CGRectGetMaxX(self.workTypeLb.frame)+DEF_RESIZE_UI(4), self.workTypeLb.y+DEF_RESIZE_UI(2), 1, DEF_RESIZE_UI(12));
    self.workInfooLb.frame = CGRectMake(CGRectGetMaxX(self.partLine1.frame)+DEF_RESIZE_UI(4), CGRectGetMaxY(self.workNameLb.frame)+DEF_RESIZE_UI(10)+DEF_RESIZE_UI(1), DEF_RESIZE_UI(250), DEF_RESIZE_UI(12));

    _artType = artType;
    self.workTypeLb.text = artType;
}

-(void)setIsPacked:(NSString *)isPacked{
    _isPacked = isPacked;
    if ([isPacked integerValue]) {
        self.packLb.textColor = COLOR_fea7a1;
    }
    else{
        self.packLb.textColor =COLOR_cccccc;
    }
}
-(void)setIsSealed:(NSString *)isSealed{
    _isSealed = isSealed;
    if ([isSealed integerValue]) {
        self.sealLb.textColor = COLOR_fea7a1;
    }
    else{
        self.packLb.textColor = COLOR_cccccc;
    }
}
-(void)setArtIntro:(NSString *)artIntro{
    _artIntro = artIntro;
    CGSize maxSize =  CGSizeMake(DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), CGFLOAT_MAX);;
    CGSize textSize = [self sizeOfString:artIntro withMaxSize:maxSize andFont:self.workTypeLb.font];
    self.workIntroLb.frame = (CGRect){DEF_RESIZE_UI(10),CGRectGetMaxY(self.packLb.frame)+DEF_RESIZE_UI(10),textSize};
    self.workIntroLb.text = artIntro;
    self.frame = CGRectMake(0, DEF_RESIZE_UI(250), DEF_DEVICE_WIDTH, CGRectGetMaxY(self.workIntroLb.frame)+DEF_RESIZE_UI(10));
}
@end
