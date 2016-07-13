//
//  OrderConHeaderView.m
//  arthome
//
//  Created by 海修杰 on 16/4/17.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderConHeaderView.h"

@interface  OrderConHeaderView()

@property (nonatomic,strong) UILabel * payTypeLb ;

@property (nonatomic,strong) UILabel * userNameLb ;

@property (nonatomic,strong) UILabel * userPhoneLb ;

@property (nonatomic,strong) UILabel * addressLb ;

@property (nonatomic,strong) UIView * userInfoView ;

@property (nonatomic,strong) UIView * partLine1 ;

@property (nonatomic,strong) UIView * payView ;

@property (nonatomic,strong) UIView * alipayView ;

@property (nonatomic,strong) UIView * wechatpayView ;

@end

@implementation OrderConHeaderView

-(instancetype)initWithAddressExit:(BOOL)exit{
    if (self =[super init]) {
        self.backgroundColor = COLOR_ffffff;
        self.payStyle = @"0";
        if (exit) {
            //收货人信息
            UIView *userInfoView = [[UIView alloc]init];
            self.userInfoView = userInfoView;
            userInfoView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGestureChose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseAddressClick)];
            [userInfoView addGestureRecognizer:tapGestureChose];
            
            //userName
            UILabel *userNameLb = [[UILabel alloc]init];
            self.userNameLb = userNameLb;
            userNameLb.font = DEF_MyFont(13);
            userNameLb.textColor = COLOR_666666;
            userNameLb.textAlignment = NSTextAlignmentLeft;
            userNameLb.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(10),DEF_RESIZE_UI(60), DEF_RESIZE_UI(15));
            [userInfoView addSubview:userNameLb];
            
            //userPhone
            UILabel *userPhoneLb = [[UILabel alloc]init];
            self.userPhoneLb = userPhoneLb;
            userPhoneLb.font = DEF_MyFont(13);
            userPhoneLb.textColor = COLOR_333333;
            userPhoneLb.textAlignment = NSTextAlignmentLeft;
            userPhoneLb.frame = CGRectMake(CGRectGetMaxX(userNameLb.frame)+DEF_RESIZE_UI(5), DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(10), DEF_RESIZE_UI(15));
            [userInfoView addSubview:userPhoneLb];
            
            //地址
            UILabel *addressLb = [[UILabel alloc]init];
            self.addressLb = addressLb;
            addressLb.font = DEF_MyFont(11);
            addressLb.textColor = COLOR_cccccc;
            addressLb.textAlignment = NSTextAlignmentLeft;
            addressLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(userPhoneLb.frame)+DEF_RESIZE_UI(12), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), DEF_RESIZE_UI(13));
            [userInfoView addSubview:addressLb];
            userInfoView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(60));
            [self addSubview:userInfoView];
            //arrow
            UIImageView *arrowImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"arrow_right_gray")];
            arrowImgView.contentMode = UIViewContentModeCenter;
            arrowImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(28), 0, DEF_RESIZE_UI(8), DEF_RESIZE_UI(60));
            [userInfoView addSubview:arrowImgView];
        }
        else{
            //添加收货地址
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
            [addBtn setImage:DEF_IMAGENAME(@"article_category_add") forState:UIControlStateNormal];
            [addBtn setTitleColor:COLOR_da1025 forState:UIControlStateNormal];
            addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
            addBtn.titleLabel.font = DEF_MyFont(13);
            addBtn.backgroundColor = COLOR_f7f7f7;
            addBtn.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(60));
            [addBtn addTarget:self action:@selector(addNewAddressClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:addBtn];
        }
        //分割
        UIView *partLine1 = [[UIView alloc]init];
        self.partLine1 = partLine1;
        partLine1.backgroundColor = COLOR_f7f7f7;
        partLine1.frame = CGRectMake(0, DEF_RESIZE_UI(60), DEF_DEVICE_WIDTH, 0.5);
        [self addSubview:partLine1];
        //支付方式
        UIView * payView = [[UIView alloc]init];
        self.payView = payView;
        payView.frame = CGRectMake(0, CGRectGetMaxY(partLine1.frame), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(128));
        [self addSubview:payView];
        UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10))];
        topLine.backgroundColor = COLOR_f2f2f2;
        [payView addSubview:topLine];
        UIView * downLine = [[UIView alloc]initWithFrame:CGRectMake(0, payView.height-DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10))];
        downLine.backgroundColor = COLOR_f2f2f2;
        [payView addSubview:downLine];
        //支付宝
        UIView *alipayView = [[UIView alloc]init];
        alipayView.layer.borderColor = COLOR_333333.CGColor;
        alipayView.layer.borderWidth = 1;
        self.alipayView = alipayView;
        UITapGestureRecognizer * alipayGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alipayGestureClick)];
        [alipayView addGestureRecognizer:alipayGesture];
        alipayView.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(20)+1, DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), DEF_RESIZE_UI(44));
        [payView addSubview:alipayView];
        UIImageView * alipayImageView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_alipay_selected")];
        alipayImageView.frame = alipayView.bounds;
        [alipayView addSubview:alipayImageView];
        //微信
        UIView *wechatpayView = [[UIView alloc]init];
        self.wechatpayView = wechatpayView;
        UITapGestureRecognizer *wechatGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wechatGestureClick)];
        [wechatpayView addGestureRecognizer:wechatGesture];
        wechatpayView.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(alipayView.frame)+1, DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), DEF_RESIZE_UI(44));
        UIImageView * wechatImageView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_wechatpay_selected")];
        wechatImageView.frame = wechatpayView.bounds;
        [wechatpayView addSubview:wechatImageView];
        [payView addSubview:wechatpayView];
        
        self.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, CGRectGetMaxY(payView.frame));
    }
    return self;
}

-(void)alipayGestureClick{
    self.payStyle = @"0";
    self.alipayView.layer.borderColor = COLOR_333333.CGColor;
    self.alipayView.layer.borderWidth = 1;
    self.wechatpayView.layer.borderWidth = 0;
}
-(void)wechatGestureClick{
    self.wechatpayView.layer.borderColor = COLOR_333333.CGColor;
    self.alipayView.layer.borderWidth = 0;
    self.wechatpayView.layer.borderWidth = 1;
    self.payStyle = @"1";
}

-(void)choseAddressClick{
    if ([self.deleagate respondsToSelector:@selector(choseAddress:)]) {
        [self.deleagate choseAddress:self];
    }
}

-(void)addNewAddressClick{
    if ([self.deleagate respondsToSelector:@selector(addNewAddress:)]) {
        [self.deleagate addNewAddress:self];
    }
}

-(void)setReceName:(NSString *)receName{
    _receName = receName;
    self.userNameLb.text = receName;
}
-(void)setRecePhone:(NSString *)recePhone{
    _recePhone = recePhone;
    self.userPhoneLb.text = recePhone;
}
-(void)setReceLocation:(NSString *)receLocation{
    _receLocation = receLocation;
    self.addressLb.text = receLocation;
}

@end
