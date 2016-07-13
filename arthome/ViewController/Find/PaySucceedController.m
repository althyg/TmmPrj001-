//
//  PaySucceedController.m
//  arthome
//
//  Created by 海修杰 on 16/6/15.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "PaySucceedController.h"
#import "OrderDetailController.h"

@interface PaySucceedController ()

@property (nonatomic,strong) UIScrollView * mainScr ;

@end

@implementation PaySucceedController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 查看订单

-(void)checkOrderBtnClick{
    OrderDetailController *detailVc = [[OrderDetailController alloc]init];
    detailVc.orderId = self.orderId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - 返回首页

-(void)backHomePageBtnClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
    DEF_MyAppDelegate.tabBarController.selectedIndex = 0;
}
//初始化UI
-(void)initUI{
    self.navigationItem.title = @"支付成功";
    self.view.backgroundColor = [UIColor whiteColor];
    //mainScr
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    self.mainScr = mainScr;
    mainScr.bounces = YES ;
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor= [UIColor whiteColor];
    [mainScr addSubview:bgView];
    //headView
    UIImageView *headImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_succeedpay_icon")];
    [bgView addSubview:headImgView];
    headImgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(100));
    
    ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
    //userName
    UILabel *userNameLb = [[UILabel alloc]init];
    userNameLb.text = userInfo.receName;
    userNameLb.font = DEF_MyFont(14);
    userNameLb.textColor = COLOR_333333;
    userNameLb.textAlignment = NSTextAlignmentLeft;
    CGSize maxSize1 = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(14));
    CGSize textSize1 = [ATUtility sizeOfString:userNameLb.text withMaxSize:maxSize1 andFont:userNameLb.font];
    userNameLb.frame = (CGRect){DEF_RESIZE_UI(20),CGRectGetMaxY(headImgView.frame)+DEF_RESIZE_UI(10),textSize1};
    [bgView addSubview:userNameLb];
    //phonetip
    UIImageView *phoneImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_succeedpay_phone")];
    phoneImgView.frame = CGRectMake(CGRectGetMaxX(userNameLb.frame)+DEF_RESIZE_UI(10), userNameLb.y, DEF_RESIZE_UI(12), DEF_RESIZE_UI(14));
    [bgView addSubview:phoneImgView];
    //userPhone
    UILabel *userPhoneLb = [[UILabel alloc]init];
    userPhoneLb.text = userInfo.recePhone;
    userPhoneLb.font = DEF_MyFont(14);
    userPhoneLb.textColor = COLOR_999999;
    userPhoneLb.textAlignment = NSTextAlignmentLeft;
    userPhoneLb.frame = CGRectMake(CGRectGetMaxX(phoneImgView.frame)+DEF_RESIZE_UI(10),userNameLb.y, DEF_RESIZE_UI(100), DEF_RESIZE_UI(15));
    [bgView addSubview:userPhoneLb];
    //地址tip
    UIImageView *addressImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_succeedpay_address")];
    addressImgView.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(userPhoneLb.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(12), DEF_RESIZE_UI(15));
    [bgView addSubview:addressImgView];
    
    //地址
    UILabel *addressLb = [[UILabel alloc]init];
    addressLb.text = userInfo.receLocation;
    addressLb.numberOfLines =0;
    addressLb.font = DEF_MyFont(13);
    addressLb.textColor = COLOR_999999;
    addressLb.textAlignment = NSTextAlignmentLeft;
    CGSize maxSize2 = CGSizeMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20)*2-DEF_RESIZE_UI(12), CGFLOAT_MAX);
    CGSize textSize2 = [ATUtility sizeOfString:addressLb.text withMaxSize:maxSize2 andFont:addressLb.font];
    addressLb.frame = (CGRect){CGRectGetMaxX(addressImgView.frame)+DEF_RESIZE_UI(5),addressImgView.y,textSize2};
    [bgView addSubview:addressLb];
    //分割线
    UIView *partingLine = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(addressLb.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(20), 1)];
    partingLine.backgroundColor = COLOR_f2f2f2;
    [bgView addSubview:partingLine];
    //总价tip
    UILabel *priceLb = [[UILabel alloc]init];
    priceLb.text = @"总价 :";
    priceLb.textColor = COLOR_666666;
    priceLb.textAlignment = NSTextAlignmentLeft;
    priceLb.font = DEF_MyFont(14);
    priceLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(partingLine.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(40), DEF_RESIZE_UI(14));
    [bgView addSubview:priceLb];
    //priceLb
    UILabel *priceRelLb = [[UILabel alloc]init];
    priceRelLb.text =  self.price;
    priceRelLb.textColor = COLOR_ff6060;
    priceRelLb.textAlignment = NSTextAlignmentLeft;
    priceRelLb.font = DEF_MyFont(14);
    priceRelLb.frame = CGRectMake(CGRectGetMaxX(priceLb.frame), CGRectGetMaxY(partingLine.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(100), DEF_RESIZE_UI(14));
    [bgView addSubview:priceRelLb];
    
    //查看订单
    UIButton *checkOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [checkOrderBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    checkOrderBtn.layer.borderColor = COLOR_cccccc.CGColor;
    checkOrderBtn.layer.borderWidth = 0.5;
    checkOrderBtn.titleLabel.font = DEF_MyFont(13);
    checkOrderBtn.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(priceRelLb.frame)+DEF_RESIZE_UI(20), DEF_RESIZE_UI(100), DEF_RESIZE_UI(28));
    [checkOrderBtn addTarget:self action:@selector(checkOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:checkOrderBtn];
    
    //返回首页
    UIButton *backHomePageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backHomePageBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backHomePageBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    backHomePageBtn.layer.borderColor = COLOR_cccccc.CGColor;
    backHomePageBtn.layer.borderWidth = 0.5;
    backHomePageBtn.titleLabel.font = DEF_MyFont(13);
    backHomePageBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(120), CGRectGetMaxY(priceRelLb.frame)+DEF_RESIZE_UI(20), DEF_RESIZE_UI(100), DEF_RESIZE_UI(28));
    [backHomePageBtn addTarget:self action:@selector(backHomePageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:backHomePageBtn];
    bgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, CGRectGetMaxY(backHomePageBtn.frame)+DEF_RESIZE_UI(10));
}

@end
