//
//  OrderConfirmViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/17.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "OrderConfirCell.h"
#import "OrderConHeaderView.h"
#import "CreatNewAddreesController.h"
#import "ShippingAddressViewcontroller.h"
#import "ChoseAddressController.h"
#import "AddressDetailFrame.h"
#import "PhoneBindingViewController.h"
#import "PaySucceedController.h"

//支付宝支付
#import "AlipayHeader.h"
//微信支付
#import "GBWXPayManager.h"

@interface OrderConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,orderConHeaderViewDelegate>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) NSMutableArray * orderConfirs ;

@property (nonatomic,weak) OrderConHeaderView * headView ;

@property (nonatomic,copy) NSString * receName ;

@property (nonatomic,copy) NSString * recePhone ;

@property (nonatomic,copy) NSString * receLocation ;

@property (nonatomic,copy) NSString * locationId ;

/**
 *  订单号
 */
@property (nonatomic,copy) NSString * orderNo;
/**
 *  价格
 */
@property (nonatomic,copy) NSString * totalPrice;


@property (nonatomic,copy) NSString *orderNumber;

@property (nonatomic,copy) NSString *orderPrice;

@end

@implementation OrderConfirmViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
    if (!(userInfo.receName.length&&userInfo.recePhone.length&&userInfo.receLocation.length)) {
        self.receName = userInfo.receName;
        self.recePhone = userInfo.recePhone;
        self.receLocation = userInfo.receLocation;
    }
    OrderConHeaderView *headView = [[OrderConHeaderView alloc]initWithAddressExit:self.receName.length&&self.recePhone.length&&self.receLocation.length];
    if (self.receName.length&&self.recePhone.length&&self.receLocation.length) {
        headView.receName = self.receName;
        headView.recePhone = self.recePhone;
        headView.receLocation = self.receLocation;
    }
    self.headView = headView;
    headView.deleagate = self;
    self.tableView.tableHeaderView = headView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    NSString *artIds = [self.artIds componentsJoinedByString:@","];
    NSDictionary *dict = @{
                           @"artIds":artIds,
                           @"artImgSize" : @"150x150"
                           };
    [self findOrderconfirHttpRequestWithDictionary:dict];
}

-(NSMutableArray *)orderConfirs{
    if (!_orderConfirs) {
        _orderConfirs=[NSMutableArray array];
    }
    return _orderConfirs;
}

/**
 订单确认网络请求
 */
-(void)findOrderconfirHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager findOrderconfirWithParametersDic:dic success:^(NSDictionary *result) {
         [ATUtility hideMBProgress:self.view];
        if (200==[result[@"code"] integerValue]){
            if (result[@"artPrices"]) {
                 self.totalPrice = result[@"artPrices"];
                [self creatBottomViewWithArtNum:[NSString stringWithFormat:@"%@",result[@"artNum"]] price:[NSString stringWithFormat:@"%@",result[@"artPrices"]]];
                NSArray * arr = [OrderConfir orderConfirGroupFromJosnArray:result[@"artOrders"]];
                self.orderConfirs = [NSMutableArray arrayWithArray:arr];
                [self.tableView reloadData];
            }
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderConfirs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderConfirCell *cell = [OrderConfirCell orderConfirCellFromTableView:tableView];
    cell.orderConfir = self.orderConfirs[indexPath.row];
    return cell;
}

-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"订单确认";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64-49) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.backgroundColor = COLOR_f7f7f7;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = DEF_RESIZE_UI(95);
    [self.view addSubview:tableView];
    ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
    self.receName = userInfo.receName;
    self.recePhone = userInfo.recePhone;
    self.receLocation = userInfo.receLocation;
}
/**
 *  底部View
 */
-(void)creatBottomViewWithArtNum:(NSString *)num  price:(NSString*)price{
    // bgView
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = COLOR_ffffff;
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(0, DEF_DEVICE_HEIGHT-49, DEF_DEVICE_WIDTH, 49);
    
    //付款按钮
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = COLOR_ff6060;
    [payBtn setTitle:@"付款" forState:UIControlStateNormal];
    payBtn.titleLabel.font = DEF_MyFont(12);
    payBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(85), 0, DEF_RESIZE_UI(85), 49);
    [payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:payBtn];
    
    //元
    UILabel *yuanLb = [[UILabel alloc]init];
    yuanLb.text = @"元";
    yuanLb.textAlignment = NSTextAlignmentLeft;
    yuanLb.font =DEF_MyFont(12);
    yuanLb.textColor = COLOR_333333;
    yuanLb.frame = CGRectMake(CGRectGetMinX(payBtn.frame)-DEF_RESIZE_UI(20), 0, DEF_RESIZE_UI(20), 49);
    [bgView addSubview:yuanLb];
    //price Lb
    UILabel *priceLb = [[UILabel alloc]init];
    priceLb.text = price;
    priceLb.textAlignment = NSTextAlignmentCenter;
    priceLb.font =DEF_MyFont(12);
    priceLb.textColor = COLOR_ff6060;
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(49));
    CGSize textSize = [ATUtility sizeOfString:priceLb.text withMaxSize:maxSize andFont:priceLb.font];
    priceLb.frame = CGRectMake(CGRectGetMinX(yuanLb.frame)-textSize.width-DEF_RESIZE_UI(5), 0, textSize.width, 49);
    [bgView addSubview:priceLb];
    
    //件艺术品
    UILabel *jianLb = [[UILabel alloc]init];
    jianLb.text = @"件艺术品";
    jianLb.textAlignment = NSTextAlignmentCenter;
    jianLb.font =DEF_MyFont(12);
    jianLb.textColor = COLOR_333333;
    jianLb.frame = CGRectMake(CGRectGetMinX(priceLb.frame)-DEF_RESIZE_UI(60), 0, DEF_RESIZE_UI(60), 49);
    [bgView addSubview:jianLb];
    //number Lb
    UILabel *numberLb = [[UILabel alloc]init];
    numberLb.text = num;
    numberLb.textAlignment = NSTextAlignmentCenter;
    numberLb.font =DEF_MyFont(12);
    numberLb.textColor = COLOR_ff6060;
    CGSize maxSize1 = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(49));
    CGSize textSize1 = [ATUtility sizeOfString:numberLb.text withMaxSize:maxSize1 andFont:numberLb.font];
    numberLb.frame = CGRectMake(CGRectGetMinX(jianLb.frame)-textSize1.width-DEF_RESIZE_UI(5), 0, textSize1.width, 49);
    [bgView addSubview:numberLb];
    //共计
    UILabel *gongjiLb = [[UILabel alloc]init];
    gongjiLb.text = @"共计";
    gongjiLb.textAlignment = NSTextAlignmentCenter;
    gongjiLb.font =DEF_MyFont(12);
    gongjiLb.textColor = COLOR_333333;
    gongjiLb.frame = CGRectMake(CGRectGetMinX(numberLb.frame)-DEF_RESIZE_UI(35), 0, DEF_RESIZE_UI(35), 49);
    UIButton *linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [linkBtn setImage:DEF_IMAGENAME(@"mine_refund_phone") forState:UIControlStateNormal];
    [linkBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    linkBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [linkBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    linkBtn.titleLabel.font = DEF_MyFont(14);
    linkBtn.frame = CGRectMake(DEF_RESIZE_UI(10),0,DEF_RESIZE_UI(80),49);
    [linkBtn addTarget:self action:@selector(linkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:linkBtn];
    [bgView addSubview:gongjiLb];
}
-(void)linkBtnClick{
    NSString * mesage = [NSString stringWithFormat:@"拨打电话%@",SERVICESPHONE];
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:mesage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1==buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",SERVICESPHONE]]];
    }
    
}

#pragma mark - orderConHeaderViewDelegate

-(void)choseAddress:(OrderConHeaderView *) orderConHeaderView{
    ChoseAddressController *choseVc = [[ChoseAddressController alloc]init];
    choseVc.addressChoseBlock = ^(NSString *userName,NSString *userPhone,NSString *shippingAddress,NSString*locationId){
        self.receName = userName;
        self.recePhone = userPhone;
        self.receLocation = shippingAddress;
        self.locationId = locationId;
    };
    [self.navigationController pushViewController:choseVc animated:YES];
}

-(void)addNewAddress:(OrderConHeaderView *) orderConHeaderView{
    CreatNewAddreesController *newVc = [[CreatNewAddreesController alloc]init];
    newVc.isFromOrder = YES;
    newVc.addressBlock = ^{
       ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
        self.receName = userInfo.receName;
        self.recePhone = userInfo.recePhone;
        self.receLocation = userInfo.receLocation;
    };
    [self.navigationController pushViewController:newVc animated:YES ];
}

#pragma mark - 提交按钮的点击

-(void)payBtnClick{
    ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
    if ([userInfo.phoneBind integerValue]) {
        if (userInfo.receName.length&&userInfo.recePhone.length&&userInfo.receLocation.length) {
            if ([self.headView.payStyle integerValue]) {
                [self buyArtsWechatPayAlipay];
            }
            else{
                [self buyArtsWithAlipay];
            }
        }
        else{
            [ATUtility showTipMessage:@"请添加地址"];
        }
        }
    else{
        PhoneBindingViewController * bindVc = [[PhoneBindingViewController alloc]init];
        [self.navigationController pushViewController:bindVc animated:YES];
    }
}

//支付宝支付
-(void)buyArtsWithAlipay{
    NSString *artIds = [self.artIds componentsJoinedByString:@","];
    NSDictionary *dic = @{@"artIds":artIds};
    [ATUtility showMBProgress:self.view];
    [RequestManager findGetordernoWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200==[result[@"code"] integerValue]){
            self.orderNumber = result[@"paydata"][@"payordersn"];
            self.orderPrice = result[@"paydata"][@"pay_price"];
            [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:self.orderNumber productName:@"《画》" productDescription:@"这是您选的要购买的画" amount:self.orderPrice notifyURL:kNotifyURL service:@"mobile.securitypay.pay" paymentType:@"1" inputCharset:@"utf-8" itBPay:@"30m" privateKey:kPrivateKey appScheme:kAppScheme];
            DEF_MyAppDelegate.blockOrderPay = ^{
                PaySucceedController * succeedVc = [[PaySucceedController alloc]init];
                succeedVc.price = self.orderPrice;
                succeedVc.orderId =  self.orderNumber;
                [self.navigationController pushViewController:succeedVc animated:YES];
            };
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
        
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
//微信支付
-(void)buyArtsWechatPayAlipay{
    
    ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
    if ([userInfo.phoneBind integerValue]) {
        if (userInfo.receName.length&&userInfo.recePhone.length&&userInfo.receLocation.length) {
            NSString *artIds = [self.artIds componentsJoinedByString:@","];
            NSDictionary *dic = @{@"artIds":artIds};
            [ATUtility showMBProgress:self.view];
            [RequestManager findGetordernoWithParametersDic:dic success:^(NSDictionary *result) {
                [ATUtility hideMBProgress:self.view];
                if (200==[result[@"code"] integerValue]){
                    self.orderNumber = result[@"paydata"][@"payordersn"];
                    self.orderPrice = result[@"paydata"][@"pay_price"];
                    //开启微信支付
                    [GBWXPayManager wxpayWithOrderID:self.orderNumber orderTitle:@"画" amount:self.orderPrice];
                    DEF_MyAppDelegate.blockOrderPay = ^{
                        PaySucceedController * succeedVc = [[PaySucceedController alloc]init];
                        succeedVc.price = self.orderPrice;
                        succeedVc.orderId =  self.orderNumber;
                        [self.navigationController pushViewController:succeedVc animated:YES];
                    };
                }
                else{
                    [ATUtility showTipMessage:result[@"message"]];
                }
                
            } failture:^(id result) {
                [ATUtility hideMBProgress:self.view];
            }];
        }
        else{
            [ATUtility showTipMessage:@"请添加地址"];
        }
    }
    else{
        PhoneBindingViewController * bindVc = [[PhoneBindingViewController alloc]init];
        [self.navigationController pushViewController:bindVc animated:YES];
    }
    

    
}

-(void)dealWXpayResult:(NSNotification*)notification{
    NSString*result=notification.object;
    if([result isEqualToString:@"1"]){
        
        //在这里写支付成功之后的回调操作
        //NSLog(@"微信支付成功");
        
    }else{
        //在这里写支付失败之后的回调操作
        NSLog(@"微信支付失败");
    }
    
    
    
}
//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    PaySucceedController * succeedVc = [[PaySucceedController alloc]init];
    succeedVc.price = self.orderPrice;
    succeedVc.orderId =  self.orderNumber;
    [self.navigationController pushViewController:succeedVc animated:YES];
    
    //    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //
    //    [alter show];
}



#pragma mark- UITableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
