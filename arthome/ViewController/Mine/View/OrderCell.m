//
//  OrderCell.m
//  arthome
//
//  Created by 海修杰 on 16/3/23.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell ()

@property (nonatomic,strong) UIImageView * artHeadImg ;

@property (nonatomic,strong) UILabel * nameLb ;

@property (nonatomic,strong) UIImageView * goodsImg ;

@property (nonatomic,strong) UILabel * goodsDet ;

@property (nonatomic,strong) UILabel * orderType ;

@property (nonatomic,strong) UIButton * rightBtn ;

@property (nonatomic,strong) UIButton * leftBtn ;

@property (nonatomic,strong) UILabel * moneyLb ;

@property (nonatomic,strong) UILabel * rmbLb ;

@property (nonatomic,strong) UILabel * payLb ;

@end

@implementation OrderCell

+(instancetype)orderCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"orderCell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
//    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
//    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        UIView *partingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10))];
        partingView.backgroundColor = COLOR_f2f2f2;
        [self.contentView addSubview:partingView];
        //艺术家bg
        UIView *artistBgView = [[UIView alloc]init];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImgClick)];
        [artistBgView addGestureRecognizer:tapGesture];
        [self.contentView addSubview:artistBgView];
        artistBgView.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(8)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(25)+DEF_RESIZE_UI(80), DEF_RESIZE_UI(25));
        //艺术家头像
        UIImageView * artHeadImg = [[UIImageView alloc]init];
        [artistBgView addSubview:artHeadImg];
        self.artHeadImg = artHeadImg;
        artHeadImg.layer.cornerRadius = DEF_RESIZE_UI(25)*0.5;
        artHeadImg.frame = CGRectMake(0, 0, DEF_RESIZE_UI(25), DEF_RESIZE_UI(25));
        //艺术家名字
        UILabel *nameLb = [[UILabel alloc]init];
        [artistBgView addSubview:nameLb];
        self.nameLb = nameLb;
        nameLb.textAlignment = NSTextAlignmentLeft;
        nameLb.textColor = COLOR_666666;
        nameLb.font = DEF_MyFont(13);
        nameLb.frame = CGRectMake(CGRectGetMaxX(artHeadImg.frame)+DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(80), DEF_RESIZE_UI(25));
        //订单类型
        UILabel * orderType = [[UILabel alloc]init];
        self.orderType = orderType;
        orderType.textAlignment = NSTextAlignmentRight;
        orderType.textColor = COLOR_ff6060;
        orderType.font = DEF_MyFont(14);
        orderType.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(80), DEF_RESIZE_UI(20), DEF_RESIZE_UI(60), DEF_RESIZE_UI(30));
        [self.contentView addSubview:orderType];
        //分割线
        UIView *sepaLine1 = [[UIView alloc]init];
        sepaLine1.backgroundColor =COLOR_e4e4e4;
        sepaLine1.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(50), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), 0.5);
        [self.contentView addSubview:sepaLine1];
        //商品展示
        UIImageView *goodsImg = [[UIImageView alloc]init];
        [self.contentView addSubview:goodsImg];
        self.goodsImg = goodsImg;
        goodsImg.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(sepaLine1.frame)+DEF_RESIZE_UI(20), DEF_RESIZE_UI(80), DEF_RESIZE_UI(80));
        //分割线
        UIView *sepaLine2 = [[UIView alloc]init];
        sepaLine2.backgroundColor = COLOR_e4e4e4;
        sepaLine2.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(goodsImg.frame)+DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), 0.5);
        [self.contentView addSubview:sepaLine2];
        //商品详情
        UILabel *goodsDet = [[UILabel alloc]init];
        [self.contentView addSubview:goodsDet];
        self.goodsDet = goodsDet;
        goodsDet.textAlignment = NSTextAlignmentLeft;
        goodsDet.numberOfLines = 0;
        goodsDet.textColor = COLOR_999999;
        goodsDet.font = DEF_MyFont(13);
        goodsDet.frame = CGRectMake(CGRectGetMaxX(goodsImg.frame)+DEF_RESIZE_UI(10), CGRectGetMaxY(sepaLine1.frame)+DEF_RESIZE_UI(30), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(120), DEF_RESIZE_UI(39));
        //RMB
        UILabel * rmbLb = [[UILabel alloc]init];
        self.rmbLb = rmbLb;
        rmbLb.textAlignment = NSTextAlignmentCenter;
        rmbLb.textColor = COLOR_cccccc;
        rmbLb.font = DEF_MyFont(14);
        rmbLb.text = @"RMB";
        rmbLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(21)-DEF_RESIZE_UI(32), CGRectGetMaxY(sepaLine2.frame), DEF_RESIZE_UI(32), DEF_RESIZE_UI(27));
        [self.contentView addSubview:rmbLb];
        //Money
        UILabel * moneyLb = [[UILabel alloc]init];
        self.moneyLb = moneyLb;
        moneyLb.textAlignment = NSTextAlignmentCenter;
        moneyLb.textColor = COLOR_666666;
        moneyLb.font = DEF_MyFont(14);
        CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(27));
        CGSize textSize = [ATUtility sizeOfString:moneyLb.text withMaxSize:maxSize andFont:moneyLb.font];
        CGFloat moneyX = CGRectGetMinX(rmbLb.frame)-textSize.width;
        moneyLb.frame = (CGRect){moneyX,rmbLb.y+(DEF_RESIZE_UI(27)-textSize.height)*0.5,textSize};
        [self.contentView addSubview:moneyLb];
        //实付
        UILabel * payLb = [[UILabel alloc]init];
        self.payLb = payLb;
        payLb.textAlignment = NSTextAlignmentRight;
        payLb.textColor = COLOR_cccccc;
        payLb.font = DEF_MyFont(14);
        payLb.text = @"实付:";
        payLb.frame = CGRectMake(CGRectGetMinX(moneyLb.frame)-DEF_RESIZE_UI(42), rmbLb.y, DEF_RESIZE_UI(42), DEF_RESIZE_UI(27));
        [self.contentView addSubview:payLb];
        //分割线
        UIView *sepaLine3 = [[UIView alloc]init];
        sepaLine3.backgroundColor = COLOR_e4e4e4;
        sepaLine3.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(sepaLine2.frame)+DEF_RESIZE_UI(27), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), 0.5);
        [self.contentView addSubview:sepaLine3];
        
        //rightButton
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn = rightBtn;
        rightBtn.titleLabel.font =DEF_MyFont(13);
        [rightBtn setTitleColor:COLOR_ffffff forState:UIControlStateSelected];
        [rightBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[ATUtility imageWithColor:COLOR_ff6060] forState:UIControlStateSelected];
        [rightBtn setBackgroundImage:[ATUtility imageWithColor:COLOR_ffffff] forState:UIControlStateNormal];
        rightBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(75)-DEF_RESIZE_UI(21), CGRectGetMaxY(sepaLine3.frame)+DEF_RESIZE_UI(16), DEF_RESIZE_UI(75), DEF_RESIZE_UI(30));
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:rightBtn];
        
        //leftButton
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.leftBtn = leftBtn;
        leftBtn.titleLabel.font =DEF_MyFont(13);
        [leftBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        leftBtn.layer.borderColor = COLOR_cccccc.CGColor;
        leftBtn.layer.borderWidth = 0.5;
        leftBtn.frame = CGRectMake(CGRectGetMinX(rightBtn.frame)-DEF_RESIZE_UI(75)-DEF_RESIZE_UI(19), CGRectGetMaxY(sepaLine3.frame)+DEF_RESIZE_UI(16), DEF_RESIZE_UI(75), DEF_RESIZE_UI(30));
        [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:leftBtn];
        //分割线
        UIView *sepaLine4 = [[UIView alloc]init];
        sepaLine4.backgroundColor = COLOR_e4e4e4;
        sepaLine4.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(rightBtn.frame)+DEF_RESIZE_UI(16), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), 0.5);
        [self.contentView addSubview:sepaLine4];
    }
    return self;
}

-(void)headImgClick{
    self.blockHead();
}

-(void)rightBtnClick{
    self.blockRightBtn();
}

-(void)leftBtnClick{
    self.blockLeftBtn();
}

-(void)setDetail:(OrderDetail *)detail{
    _detail = detail;
    [self.artHeadImg sd_setImageWithURL:[NSURL URLWithString:detail.headImg] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    self.nameLb.text = detail.artistName;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:detail.artImgUrl] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    self.goodsDet.text = detail.picIntr;
    switch ([detail.orderType integerValue]) {
        case 1:
        {
            self.orderType.text = @"待付款";
            self.rightBtn.selected = YES;
            [self.rightBtn setTitle:@"立即付款" forState:UIControlStateSelected];
            [self.leftBtn setTitle:@"关闭交易" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.orderType.text = @"待发货";
            self.rightBtn.selected = NO;
            self.rightBtn.layer.borderColor = COLOR_cccccc.CGColor;
            self.rightBtn.layer.borderWidth = 0.5;
            [self.rightBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            self.leftBtn.alpha = 0;
        }
            break;
        case 3:
        {
            self.orderType.text = @"待收货";
            self.rightBtn.selected = YES;
            [self.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.leftBtn setTitle:@"申请退货" forState:UIControlStateNormal];
        }
            break;
        case 6:
        {
            self.orderType.text = @"交易成功";
            self.rightBtn.alpha = 0;
            self.leftBtn.alpha = 0;
        }
            break;
        case 5:
        {
            self.orderType.text = @"退款订单";
            self.rightBtn.alpha = 0;
            self.leftBtn.alpha = 0;
        }
            break;
            
        default:
            break;
    }
    self.moneyLb.text = detail.price;
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(27));
    CGSize textSize = [ATUtility sizeOfString:self.moneyLb.text withMaxSize:maxSize andFont:self.moneyLb.font];
    CGFloat moneyX = CGRectGetMinX(self.rmbLb.frame)-textSize.width;
    self.moneyLb.frame = (CGRect){moneyX,self.rmbLb.y+(DEF_RESIZE_UI(27)-textSize.height)*0.5,textSize};
    self.payLb.frame = CGRectMake(CGRectGetMinX(self.moneyLb.frame)-DEF_RESIZE_UI(42), self.rmbLb.y, DEF_RESIZE_UI(42), DEF_RESIZE_UI(27));
}

@end
