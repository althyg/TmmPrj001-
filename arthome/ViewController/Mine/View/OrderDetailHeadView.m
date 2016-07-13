//
//  OderDetailHeadView.m
//  arthome
//
//  Created by 海修杰 on 16/4/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderDetailHeadView.h"

@interface OrderDetailHeadView ()

@property (nonatomic,weak) UILabel * userName ;

@property (nonatomic,weak) UILabel * userPhone ;

@property (nonatomic,weak) UILabel * addressLb ;

@property (nonatomic,weak) UILabel * orderNumLb ;

@property (nonatomic,weak) UILabel * orderTimeLb ;

@property (nonatomic,strong) UILabel * orderTypeLb ;

@property (nonatomic,strong) UILabel * orderPriceLb ;


@end

@implementation OrderDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //收货人姓名
        UILabel *userName = [[UILabel alloc]init];
        [self addSubview:userName];
        self.userName = userName;
        userName.textAlignment = NSTextAlignmentLeft;
        userName.textColor = COLOR_333333;
        userName.font = DEF_MyFont(13);
        userName.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(10), DEF_RESIZE_UI(50), DEF_RESIZE_UI(13));
        
        //收货人号码
        UILabel * userPhone = [[UILabel alloc]init];
        [self addSubview:userPhone];
        self.userPhone = userPhone;
        userPhone.textAlignment = NSTextAlignmentLeft;
        userPhone.textColor = COLOR_999999;
        userPhone.font = DEF_MyFont(13);
        userPhone.frame = CGRectMake(CGRectGetMaxX(userName.frame), userName.y, DEF_DEVICE_WIDTH-CGRectGetMaxX(userName.frame), userName.height);
        
        //收货地址
        UILabel * addressLb = [[UILabel alloc]init];
        [self addSubview:addressLb];
        self.addressLb = addressLb;
        addressLb.numberOfLines = 0;
        addressLb.textAlignment = NSTextAlignmentLeft;
        addressLb.textColor = COLOR_999999;
        addressLb.font = DEF_MyFont(13);
        CGSize textSize = CGSizeMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(40), DEF_RESIZE_UI(60));
        addressLb.frame = (CGRect){DEF_RESIZE_UI(20),CGRectGetMaxY(userPhone.frame)+DEF_RESIZE_UI(10),textSize};
        //分割线
        UIView *partLine1 = [[UIView alloc]init];
        [self addSubview:partLine1];
        partLine1.backgroundColor = COLOR_f2f2f2;
        partLine1.frame = CGRectMake(0, CGRectGetMaxY(addressLb.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10));
        //订单状态
        UILabel *orderTypeLb =[[UILabel alloc]init];
        [self addSubview:orderTypeLb];
        self.orderTypeLb = orderTypeLb;
        orderTypeLb.text = @"订单状态 :";
        orderTypeLb.textColor = COLOR_999999;
        orderTypeLb.font = DEF_MyFont(14);
        orderTypeLb.textAlignment = NSTextAlignmentLeft;
        orderTypeLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(partLine1.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20), DEF_RESIZE_UI(14));
        //订单价格
        UILabel *orderPriceLb =[[UILabel alloc]init];
        [self addSubview:orderPriceLb];
        self.orderPriceLb = orderPriceLb;
        orderPriceLb.text = @"订单价格 :";
        orderPriceLb.textColor = COLOR_999999;
        orderPriceLb.font = DEF_MyFont(14);
        orderPriceLb.textAlignment = NSTextAlignmentLeft;
        orderPriceLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(orderTypeLb.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20), DEF_RESIZE_UI(14));
        //订单编号
        UILabel *orderNumLb =[[UILabel alloc]init];
        [self addSubview:orderNumLb];
        self.orderNumLb = orderNumLb;
        orderNumLb.text = @"订单编号 :";
        orderNumLb.textColor = COLOR_999999;
        orderNumLb.font = DEF_MyFont(14);
        orderNumLb.textAlignment = NSTextAlignmentLeft;
        orderNumLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(orderPriceLb.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20), DEF_RESIZE_UI(14));
        //订单日期
        UILabel *orderTimeLb =[[UILabel alloc]init];
        self.orderTimeLb = orderTimeLb;
        [self addSubview:orderTimeLb];
        orderTimeLb.text = @"订单日期 :";
        orderTimeLb.textColor = COLOR_999999;
        orderTimeLb.font = DEF_MyFont(14);
        orderTimeLb.textAlignment = NSTextAlignmentLeft;
        orderTimeLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(orderNumLb.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20), DEF_RESIZE_UI(14));
        //分割线
        UIView *partLine2 = [[UIView alloc]init];
        [self addSubview:partLine2];
        partLine2.backgroundColor = COLOR_f2f2f2;
        partLine2.frame = CGRectMake(0, CGRectGetMaxY(orderTimeLb.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10));
        self.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, CGRectGetMaxY(partLine2.frame));
    }
    return self;
}

-(void)setReceiverName:(NSString *)receiverName{
    _receiverName = receiverName;
    self.userName.text = receiverName;
}
-(void)setReceiverPhone:(NSString *)receiverPhone{
    _receiverPhone = receiverPhone;
    self.userPhone.text = receiverPhone;
}
-(void)setReceiverAddress:(NSString *)receiverAddress{
    _receiverAddress = receiverAddress;
    self.addressLb.text = receiverAddress;
}
-(void)setOrderNum:(NSString *)orderNum{
    _orderNum = orderNum;
    self.orderNumLb.text = [NSString stringWithFormat:@"%@   %@",@"订单编号 :",orderNum];
}
-(void)setOrderDate:(NSString *)orderDate{
    _orderDate = orderDate;
    self.orderTimeLb.text = [NSString stringWithFormat:@"%@   %@",@"订单日期 :",orderDate];;
}
-(void)setOrderType:(NSString *)orderType{
    _orderType = orderType;
    switch ([orderType integerValue]) {
        case 1:
        {
            self.orderTypeLb.text = [NSString stringWithFormat:@"%@   %@",@"订单状态 :",@"待付款"];
        }
            break;
        case 2:
        {
          self.orderTypeLb.text = [NSString stringWithFormat:@"%@    %@",@"订单状态 :",@"待发货"];
        }
            break;
        case 3:
        {
           self.orderTypeLb.text = [NSString stringWithFormat:@"%@    %@",@"订单状态 :",@"待收货"];
        }
            break;
        case 4:
        {
           self.orderTypeLb.text = [NSString stringWithFormat:@"%@    %@",@"订单状态 :",@"交易成功"];
        }
            break;
        case 5:
        {
            self.orderTypeLb.text = [NSString stringWithFormat:@"%@   %@",@"订单状态 :",@"退款订单"];
        }
            break;
            
            
        default:
            break;
    }
}
-(void)setOrderPrice:(NSString *)orderPrice{
    _orderPrice = orderPrice;
    self.orderPriceLb.text = [NSString stringWithFormat:@"%@   %@",@"订单价格 :",orderPrice];
}
@end
