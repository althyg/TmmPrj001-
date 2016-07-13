//
//  ShippingAddressViewcontroller.m
//  arthome
//
//  Created by 海修杰 on 16/3/15.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ShippingAddressViewcontroller.h"
#import "CreatNewAddreesController.h"
#import "ChangeAddressController.h"
#import "AddressManagerCell.h"

@interface ShippingAddressViewcontroller ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) NSMutableArray * detailArrM ;

@end

@implementation ShippingAddressViewcontroller

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

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    }
/**
 *  下拉刷新
 */
-(void)setupRefresh{
    _detailArrM=nil;
    __weak ShippingAddressViewcontroller *weakSelf = self;
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
 *  删除地址网络请求
 */
-(void)mineDeleteaddressHttpRequestWithDictionary:(NSDictionary *)dic withSelectedRow : (NSInteger) index{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineDeleteaddressWithParametersDic:dic success:^(NSDictionary *result) {
            [ATUtility hideMBProgress:self.view];
            [ATUtility showTipMessage:result[@"message"]];
       if ([result[@"code"] integerValue]==200) {
           [self.detailArrM removeObjectAtIndex:index];
           [self.tableView reloadData];
           if (self.detailArrM.count<=0) {
               ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
               userInfo.receName = @"";
               userInfo.recePhone = @"";
               userInfo.receLocation = @"";
               [userInfo saveAccountToSandBox];
           }
       }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

#pragma mark - 添加收货地址按钮点击

-(void)addAddressBtnClick{
    CreatNewAddreesController *newMaVc = [[CreatNewAddreesController alloc]init];
    [self.navigationController pushViewController:newMaVc animated:YES];
}

#pragma mark - tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArrM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressManagerCell * cell = [AddressManagerCell addressManagerCellFromTableView:tableView];
    AddressDetail *addressDetail =self.detailArrM[indexPath.row] ;
    cell.addressDetail = addressDetail;
    cell.blockDelete = ^{
        NSDictionary *dic = @{@"locationId" : addressDetail.locationId
                              };
        [self mineDeleteaddressHttpRequestWithDictionary:dic withSelectedRow:indexPath.row];
    };
    cell.blockEdit = ^{
        ChangeAddressController *changeVc = [[ChangeAddressController alloc]init];
        AddressDetail *detail =self.detailArrM[indexPath.row];
        changeVc.locationId = detail.locationId;
        [self.navigationController pushViewController:changeVc animated:YES];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_RESIZE_UI(110);
}

-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title=@"地址管理";
    //添加tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64+DEF_RESIZE_UI(60)) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = COLOR_f2f2f2;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    //添加收货地址按钮
    UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addAddressBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    addAddressBtn.backgroundColor = COLOR_da1025;
    addAddressBtn.titleLabel.font = DEF_MyFont(16);
    addAddressBtn.frame = CGRectMake(0,DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(44),DEF_DEVICE_WIDTH, DEF_RESIZE_UI(44));
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddressBtn];
}

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
