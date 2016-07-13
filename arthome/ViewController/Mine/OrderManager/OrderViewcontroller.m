//
//  OrderViewcontroller.m
//  arthome
//
//  Created by 海修杰 on 16/3/15.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderViewcontroller.h"
#import "OrderCell.h"
#import "RefundViewController.h"
#import "RefundDetailController.h"
#import "OrderDetailController.h"
#import "ArtistDetailViewController.h"
#import "PaySucceedController.h"
//支付
#import "AlipayHeader.h"

@interface OrderViewcontroller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton * selectedBtn ;

@property (nonatomic,strong) UITableView * tableView ;

@property(nonatomic,strong) NSMutableArray *groupDetails;

@property (nonatomic,strong) UIScrollView * headScr;

@property (nonatomic,copy) NSString * orderType;

@end

@implementation OrderViewcontroller

-(NSMutableArray *)groupDetails{
    if (!_groupDetails) {
        _groupDetails=[NSMutableArray array];
    }
    return _groupDetails;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self setupRefresh];
}

/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak OrderViewcontroller *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadDatas];
    }];
    [self.tableView.header beginRefreshing];
}

-(void)reloadDatas{
    NSDictionary *dic = @{
                          @"orderType" : self.orderType,
                          @"headSize" : @"50x50",
                          @"artSize" :  @"160x160"
                          };
    [self mineOrderListHttpRequestWithDictionary:dic];
}

/**
 *  订单列表网络请求
 */
-(void) mineOrderListHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager mineOrderListWithParametersDic:dic success:^(NSDictionary *result) {
        [self.tableView.header endRefreshing];
        if ([result[@"code"] integerValue] == 200) {
             NSArray * listArr = result[@"orders"];
            self. groupDetails =[NSMutableArray arrayWithArray:[OrderDetail orderListsGroupFromJosnArray:listArr]] ;
            [self.tableView reloadData];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
       [self.tableView.header endRefreshing];
    }];
}
/**
 *  交易关闭
 */
-(void) mineCloseTradeHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineCloseTradeWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
              [self.tableView.header beginRefreshing];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
/**
 *  确认收货
 */
-(void) mineAffirmReceiveHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineAffirmReceiveWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            [self.tableView.header beginRefreshing];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
       [ATUtility hideMBProgress:self.view];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupDetails.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetail *detail = self.groupDetails[indexPath.row];
    OrderCell * cell =  [OrderCell orderCellFromTableView:tableView];
    cell.detail = detail;
    cell.blockHead = ^{
        ArtistDetailViewController * artistVc = [[ArtistDetailViewController alloc] init];
        artistVc.artistId = detail.artistId;
        [self.navigationController pushViewController:artistVc animated:YES];
    };
    switch ([detail.orderType integerValue]) {
        case 1:
        {
            cell.blockRightBtn = ^{
                //立即付款
                [self immediatelyPayWithOrderId:detail.orderId andPricr: detail.price];
            };
            cell.blockLeftBtn = ^{
                //关闭交易
                [self closeTradeWithOrderId:detail.orderId];
            };
        }
            break;
        case 2:
        {
            cell.blockRightBtn = ^{
                               //申请退款
                [self applyRefundWithOrderId:detail.orderId WithPrice:detail.price];
            };
        }
            break;
        case 3:
        {
            cell.blockRightBtn = ^{
                                //确认收货
                [self affirmrRceiveWithOrderId:detail.orderId ];
                
            };
            cell.blockLeftBtn = ^{
                         //申请退货
                [self applyGoodsrRejectedWithOrderId:detail.orderId WithPrice:detail.price];
            };
        }
            break;
            
        default:
            break;
    }
    return cell;
}
/**
 *  立即付款
 */
-(void)immediatelyPayWithOrderId:(NSString *) orderId andPricr:(NSString *) price{
      [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:orderId productName:@"《画》" productDescription:@"这是您选的要购买的画" amount:price notifyURL:kNotifyURL service:@"mobile.securitypay.pay" paymentType:@"1" inputCharset:@"utf-8" itBPay:@"30m" privateKey:kPrivateKey appScheme:kAppScheme];
          DEF_MyAppDelegate.blockOrderPay = ^{
              PaySucceedController * succeedVc = [[PaySucceedController alloc]init];
              succeedVc.price = price;
              succeedVc.orderId = orderId;
              [self.navigationController pushViewController:succeedVc animated:YES];
    };
}
/**
 *  关闭交易
 */
-(void)closeTradeWithOrderId:(NSString *)orderId{
    NSDictionary * dic = @{
                           @"orderId" : orderId
                           };
    [self mineCloseTradeHttpRequestWithDictionary:dic];
    
}
/**
 *  申请退款
 */
-(void)applyRefundWithOrderId:(NSString *)orderId WithPrice:(NSString *) price{
    RefundViewController * refundVc = [[RefundViewController alloc]init];
    refundVc.orderId = orderId;
    refundVc.amount = price;
    refundVc.type = @"0";
    [self.navigationController pushViewController:refundVc animated:YES];
}
/**
 *  确认收货
 */
-(void)affirmrRceiveWithOrderId:(NSString *)orderId {
    NSDictionary * dic = @{
                           @"orderId" :orderId
                           };
    [self mineAffirmReceiveHttpRequestWithDictionary:dic];
    
}
/**
 *  申请退货
 */
-(void)applyGoodsrRejectedWithOrderId:(NSString *)orderId WithPrice:(NSString *) price{
    RefundViewController * refundVc = [[RefundViewController alloc]init];
    refundVc.orderId = orderId;
    refundVc.amount = price;
    refundVc.type = @"1";
    [self.navigationController pushViewController:refundVc animated:YES];
}

#pragma  mark - 选择类型按钮

-(void)titleBtnClick:(UIButton *)button{
    if (button.tag>1&&button.tag<4) {
    [UIView animateWithDuration:0.3 animations:^{
        self.headScr.contentOffset = CGPointMake(DEF_DEVICE_WIDTH*0.125+(DEF_DEVICE_WIDTH*0.25)*(button.tag-2), 0);
    }];
    }
    else if (button.tag<=1){
        [UIView animateWithDuration:0.3 animations:^{
            self.headScr.contentOffset = CGPointMake(0, 0);
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            self.headScr.contentOffset = CGPointMake(0.5*DEF_DEVICE_WIDTH, 0);
        }];
    }
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
    self.selectedBtn.selected = YES;
    self.orderType = [NSString stringWithFormat:@"%zd",button.tag];
    if ([self.orderType integerValue]==4) {
      self.orderType = @"6";
    }
    [self.tableView.header beginRefreshing];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetail *detail = self.groupDetails[indexPath.row];
    if ([detail.orderType integerValue]==5) {
        RefundDetailController *refundDetailVc = [[RefundDetailController alloc]init];
        refundDetailVc.orderId = detail.orderId;
        [self.navigationController pushViewController:refundDetailVc animated:YES];
    }
    else{
        OrderDetailController * detailVc = [[OrderDetailController alloc]init];
        detailVc.orderId = detail.orderId;
        [self.navigationController pushViewController: detailVc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetail *detail = self.groupDetails[indexPath.row];
    if ([detail.orderType integerValue]==5||[detail.orderType integerValue]==6){
    return DEF_RESIZE_UI(280-62);
    }
    else{
        return DEF_RESIZE_UI(280);
    }
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(50), DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(50)) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray * titleArr = @[@"所有订单",@"待付款",@"待发货",@"待收货",@"交易成功",@"退款订单"];
    //添加scrollView
    UIScrollView * headScr = [[UIScrollView alloc]init];
    self.headScr = headScr;
    headScr.backgroundColor = [UIColor whiteColor];
    headScr.showsHorizontalScrollIndicator = NO;
    headScr.frame = CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(50));
    headScr.contentSize = CGSizeMake(1.5*DEF_DEVICE_WIDTH, 0);
    [self.view addSubview:headScr];
    //添加8个按钮
    for (int index = 0; index < titleArr.count; index ++) {
        UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:titleArr[index] forState:UIControlStateNormal];
        [titleBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
        [titleBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
        titleBtn.titleLabel.font = DEF_MyFont(14);
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.tag = headScr.subviews.count;
        CGFloat btnW = DEF_DEVICE_WIDTH*0.25;
        titleBtn.frame = CGRectMake(index*btnW, 0, btnW, DEF_RESIZE_UI(50));
        [headScr addSubview:titleBtn];
    }
    self.selectedBtn = (UIButton *)headScr.subviews[0];
    self.selectedBtn.selected = YES;
    [self.selectedBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    self.orderType = @"0";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
