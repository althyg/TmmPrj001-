//
//  ChoseAddressController.m
//  arthome
//
//  Created by 海修杰 on 16/5/17.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ChoseAddressController.h"
#import "AddressChoseCell.h"
#import "ShippingAddressViewcontroller.h"

@interface ChoseAddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) NSMutableArray * detailArrM ;

@end

@implementation ChoseAddressController

-(NSMutableArray *)detailArrM{
    if (!_detailArrM) {
        _detailArrM = [NSMutableArray array];
    }
    return _detailArrM;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak ChoseAddressController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadDatas];
    }];
    [self.tableView.header beginRefreshing];
}

-(void)reloadDatas{
    [self mineAddressesHttpRequestWithDictionary:nil];
}
/**
 地址列表网络请求
 */
-(void)mineAddressesHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager mineAddressesWithParametersDic:dic success:^(NSDictionary *result) {
        [self.tableView.header endRefreshing];
        if ([result[@"code"] integerValue]==200) {
            NSArray *arr = [AddressDetail addressDetailGroupFromJosnArray:result[@"addresses"]];
            self.detailArrM = [NSMutableArray arrayWithArray:arr];
            [self.tableView reloadData];
        }
    } failture:^(id result) {
        [self.tableView.header endRefreshing];
    }];
}
/**
 选择地址为默认地址
 */
//-(void)mineChoseDefaultedHttpRequestWithDictionary:(NSDictionary *)dic{
//    [ATUtility showMBProgress:self.view];
//    [RequestManager mineChoseDefaultedWithParametersDic:dic success:^(NSDictionary *result) {
//        [ATUtility hideMBProgress:self.view];
//        if ([result[@"code"] integerValue]==200) {
//             [self.navigationController popViewControllerAnimated:YES];
//        }
//        else{
//            [ATUtility showTipMessage:result[@"message"]];
//        }
//    } failture:^(id result) {
//        [ATUtility hideMBProgress:self.view];
//    }];
//}

#pragma mark - 地址管理
-(void)addressBtnClick{
    ShippingAddressViewcontroller *shipVc = [[ShippingAddressViewcontroller alloc]init];
    [self.navigationController pushViewController:shipVc animated:YES];
}

#pragma mark - tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArrM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressChoseCell * cell = [AddressChoseCell addressChoseCellFromTableView:tableView];
    AddressDetail *detail=self.detailArrM[indexPath.row] ;
    cell.addressDetail = detail;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_RESIZE_UI(64);
}

-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"选择收货地址";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithTitle:@"管理" target:self action:@selector(addressBtnClick)];
    //添加tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressDetail *detail=self.detailArrM[indexPath.row] ;
    self.addressChoseBlock(detail.userName, detail.userPhone,detail.shippingAddress,detail.locationId);
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
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
