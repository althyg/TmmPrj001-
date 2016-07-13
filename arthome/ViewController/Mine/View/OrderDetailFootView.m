//
//  OrderDetailFootView.m
//  arthome
//
//  Created by 海修杰 on 16/4/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderDetailFootView.h"

@implementation OrderDetailFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       //商品总价Tip
        UILabel *goodsPriceTipLb = [[UILabel alloc]init];
        [self addSubview:goodsPriceTipLb];
        goodsPriceTipLb.text = @"商品总价:";
        goodsPriceTipLb.textColor = COLOR_999999;
        goodsPriceTipLb.font = DEF_MyFont(11);
        goodsPriceTipLb.textAlignment = NSTextAlignmentLeft;
        goodsPriceTipLb.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(10),DEF_RESIZE_UI(80), DEF_RESIZE_UI(11));
        //运费Tip
        UILabel *freightTipLb = [[UILabel alloc]init];
        [self addSubview:freightTipLb];
        freightTipLb.text = @"运费:";
        freightTipLb.textColor = COLOR_999999;
        freightTipLb.font = DEF_MyFont(11);
        freightTipLb.textAlignment = NSTextAlignmentLeft;
        freightTipLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(goodsPriceTipLb.frame)+DEF_RESIZE_UI(5),DEF_RESIZE_UI(80), DEF_RESIZE_UI(11));
        //活动优惠金额Tip
        UILabel *couponTipLb = [[UILabel alloc]init];
        [self addSubview:couponTipLb];
        couponTipLb.text = @"活动优惠金额:";
        couponTipLb.textColor = COLOR_999999;
        couponTipLb.font = DEF_MyFont(11);
        couponTipLb.textAlignment = NSTextAlignmentLeft;
        couponTipLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(freightTipLb.frame)+DEF_RESIZE_UI(5),DEF_RESIZE_UI(80), DEF_RESIZE_UI(11));
        //支付金额Tip
        UILabel *payPriceTipLb = [[UILabel alloc]init];
        [self addSubview:payPriceTipLb];
        payPriceTipLb.text = @"活动优惠金额:";
        payPriceTipLb.textColor = COLOR_999999;
        payPriceTipLb.font = DEF_MyFont(11);
        payPriceTipLb.textAlignment = NSTextAlignmentLeft;
        payPriceTipLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(couponTipLb.frame)+DEF_RESIZE_UI(5),DEF_RESIZE_UI(80), DEF_RESIZE_UI(11));
        
        //商品总价
        UILabel *goodsPriceLb = [[UILabel alloc]init];
        [self addSubview:goodsPriceLb];
        goodsPriceLb.text = @"商品总价:";
        goodsPriceLb.textColor = COLOR_999999;
        goodsPriceLb.font = DEF_MyFont(11);
        goodsPriceLb.textAlignment = NSTextAlignmentRight;
        goodsPriceLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60)-DEF_RESIZE_UI(20), DEF_RESIZE_UI(10),DEF_RESIZE_UI(60), DEF_RESIZE_UI(11));
        //运费
        UILabel *freightLb = [[UILabel alloc]init];
        [self addSubview:freightLb];
        freightLb.text = @"运费:";
        freightLb.textColor = COLOR_999999;
        freightLb.font = DEF_MyFont(11);
        freightLb.textAlignment = NSTextAlignmentRight;
        freightLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60)-DEF_RESIZE_UI(20), CGRectGetMaxY(goodsPriceLb.frame)+DEF_RESIZE_UI(5),DEF_RESIZE_UI(60), DEF_RESIZE_UI(11));
        //活动优惠金额
        UILabel *couponLb = [[UILabel alloc]init];
        [self addSubview:couponLb];
        couponLb.text = @"活动优惠金额:";
        couponLb.textColor = COLOR_999999;
        couponLb.font = DEF_MyFont(11);
        couponLb.textAlignment = NSTextAlignmentRight;
        couponLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60)-DEF_RESIZE_UI(20), CGRectGetMaxY(freightLb.frame)+DEF_RESIZE_UI(5),DEF_RESIZE_UI(60), DEF_RESIZE_UI(11));
        //支付金额
        UILabel *payPriceLb = [[UILabel alloc]init];
        [self addSubview:payPriceLb];
        payPriceLb.text = @"活动优惠金额:";
        payPriceLb.textColor = COLOR_999999;
        payPriceLb.font = DEF_MyFont(11);
        payPriceLb.textAlignment = NSTextAlignmentRight;
        payPriceLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60)-DEF_RESIZE_UI(20), CGRectGetMaxY(couponLb.frame)+DEF_RESIZE_UI(5),DEF_RESIZE_UI(60), DEF_RESIZE_UI(11));
        
        self.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(73));
    }
    return self;
}

-(void)setGoodsPrice:(NSString *)goodsPrice{
    _goodsPrice = goodsPrice;
}

-(void)setFreight:(NSString *)freight{
    _freight = freight;
}

-(void)setCoupon:(NSString *)coupon{
    _coupon = coupon;
}

-(void)setPayPrice:(NSString *)payPrice{
    _payPrice = payPrice;
}

@end
