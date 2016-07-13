//
//  ShoppingCartViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/15.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartCell.h"
#import "OrderConfirmViewController.h"
//支付
#import "AlipayHeader.h"

@interface ShoppingCartViewController()<UITableViewDelegate,UITableViewDataSource>
/**
 *  订单需要的价格
 */
@property (nonatomic,copy) NSString * realPrice;

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) NSMutableArray * shoppingCarts ;

@property (nonatomic,assign) NSInteger totalPrice;

@property (nonatomic,assign) NSInteger totalNum;

@property (nonatomic,strong) UILabel * priceLb ;

@property (nonatomic,strong) UILabel * numberLb ;

@property (nonatomic,strong) UIView * bgView ;

@property (nonatomic,strong) UIButton * selectAllBtn ;

@property (nonatomic,strong) UIImageView * noneImgView ;

@end

@implementation ShoppingCartViewController

-(NSMutableArray *)shoppingCarts{
    if (!_shoppingCarts) {
        _shoppingCarts=[NSMutableArray array];
    }
    return _shoppingCarts;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupRefresh];
    [self creatBottomViewWithArtNum:@"0" price:@"0" allBtnSelected:NO];
}
/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak ShoppingCartViewController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadDatas];
    }];
    [self.tableView.header beginRefreshing];
}

-(void)reloadDatas{
    NSDictionary *dic = @{
                          @"imgsize" : @"150x150"
                          };
    [self mineshopcartWithParametersDic:dic];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
/**
 购物车列表网络请求
 */
-(void)mineshopcartWithParametersDic:(NSDictionary *)dic{
    [RequestManager mineshopcartWithParametersDic:dic success:^(NSDictionary *result) {
           [self.tableView.header endRefreshing];
       if (200==[result[@"code"] integerValue]){
          NSArray * listArr = result[@"arts"];
           if (listArr.count==0) {
               self.view.backgroundColor=COLOR_f2f2f2;
               UIImageView *noneImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_none_cart")];
               self.noneImgView = noneImgView;
               noneImgView.size = CGSizeMake(DEF_RESIZE_UI(112), DEF_RESIZE_UI(114));
               noneImgView.center = CGPointMake(DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(240));
               [self.view addSubview:noneImgView];
           }
           else{
               [self.noneImgView removeFromSuperview];
               self. shoppingCarts =[NSMutableArray arrayWithArray:[ShoppingCart shoppingCartGroupFromJosnArray:listArr]] ;
               [self.tableView reloadData];
           }

        }
    } failture:^(id result) {
        [self.tableView.header endRefreshing];
    }];
}
/**
 *  删除购物车网络请求
 */
-(void)mineDeletecartHttpRequestWithDictionary:(NSDictionary *)dic withIndexPath:(NSIndexPath *)indexPath{
    [ATUtility showMBProgress:self.view];
   [RequestManager mineDeletecartWithParametersDic:dic success:^(NSDictionary *result) {
       [ATUtility hideMBProgress:self.view];
       if (200==[result[@"code"] integerValue]){
           [ATUtility showTipMessage:result[@"message"]];
           [self.shoppingCarts removeObjectAtIndex:indexPath.row];
           [self calculateNumAndPrice];
           [self.tableView reloadData];
           UITabBarItem * cartItem = DEF_MyAppDelegate.tabBarController.tabBar.items[2];
           NSString *numStr = cartItem.badgeValue;
           if ([numStr integerValue]) {
               cartItem.badgeValue = nil;
           }
           else{
               NSInteger count = [numStr integerValue];
               count--;
               cartItem.badgeValue = [NSString stringWithFormat:@"%zd",count];
           }
           if (self.shoppingCarts.count==0) {
               self.view.backgroundColor=COLOR_f2f2f2;
               UIImageView *noneImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_none_cart")];
               self.noneImgView = noneImgView;
               noneImgView.size = CGSizeMake(DEF_RESIZE_UI(112), DEF_RESIZE_UI(114));
               noneImgView.center = CGPointMake(DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(240));
               [self.view addSubview:noneImgView];
           }
           else{
               [self.noneImgView removeFromSuperview];
           }
       }
       else{
           [ATUtility showTipMessage:result[@"message"]]; 
       }
   } failture:^(id result) {
       [ATUtility hideMBProgress:self.view];
       [ATUtility showTipMessage:result[@"message"]];
   }];
}

#pragma mark - 提交按钮的点击
-(void)payBtnClick{
    NSMutableArray *artIds = [NSMutableArray array];
    for (ShoppingCart *cart in self.shoppingCarts) {
        if (cart.selected) {
            [artIds addObject:cart.artId];
        }
    }
    OrderConfirmViewController *orderVc = [[OrderConfirmViewController alloc]init];
    orderVc.artIds = artIds;
    [self.navigationController pushViewController:orderVc animated:YES];
}

#pragma mark - tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shoppingCarts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCart *cart = self.shoppingCarts[indexPath.row];
    ShoppingCartCell * cell = [ShoppingCartCell shoppingCartCellFromTableView:tableView];
    cell.shoppingCart = cart;
    cell.selectBtnBlock = ^{
            [self calculateNumAndPrice];
        };
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCart *cart = self.shoppingCarts[indexPath.row];
    NSString * artId = cart.artId;
    NSDictionary *dic = @{@"artId" : artId};
    [self mineDeletecartHttpRequestWithDictionary:dic withIndexPath:indexPath];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"购物车";
    //添加tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64-49-49) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = DEF_RESIZE_UI(95);
    [self.view addSubview:tableView];
    }

-(void)selectAllBtnClick:(UIButton *)btn{
    btn.selected ? (btn.selected = NO) : (btn.selected = YES);
    for (ShoppingCart *cart in self.shoppingCarts) {
        cart.selected = btn.selected;
        if (cart.selected) {
        self.totalPrice += [cart.workPrice integerValue];
        self.totalNum += 1;
        }
    }
   [self creatBottomViewWithArtNum: [NSString stringWithFormat:@"%zd",self.totalNum] price:[NSString stringWithFormat:@"%zd",self.totalPrice] allBtnSelected:btn.selected];
    self.totalPrice = 0;
    self.totalNum = 0;
    [self.tableView reloadData];
}

-(void)creatBottomViewWithArtNum:(NSString *)num  price:(NSString*)price allBtnSelected :(BOOL) isSelected{
    self.realPrice = price;
    [self.bgView removeFromSuperview];
    // bgView
    UIView *bgView = [[UIView alloc]init];
    self.bgView = bgView;
    bgView.backgroundColor = COLOR_ffffff;
    [self.view addSubview:bgView];
    bgView.frame = CGRectMake(0, DEF_DEVICE_HEIGHT-98, DEF_DEVICE_WIDTH, 49);
    //分割线
    UIView *partLine = [[UIView alloc]init];
    partLine.backgroundColor = COLOR_f2f2f2;
    partLine.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, 1);
    [bgView addSubview:partLine];
    //添加全选
    UIButton * selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAllBtn.selected = isSelected;
    self.selectAllBtn = selectAllBtn;
    [selectAllBtn setImage:DEF_IMAGENAME(@"global_item_unselected") forState:UIControlStateNormal];
    [selectAllBtn setImage:DEF_IMAGENAME(@"global_item_selected") forState:UIControlStateSelected];
    selectAllBtn.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(60), 49);
    [selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    selectAllBtn.titleLabel.font = DEF_MyFont(12);
    [selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, 20);
    [selectAllBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [bgView  addSubview:selectAllBtn];
    //付款按钮
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = COLOR_ff6060;
    [payBtn setTitle:@"提交" forState:UIControlStateNormal];
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
    self.priceLb = priceLb;
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
    self.numberLb = numberLb;
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
    [bgView addSubview:gongjiLb];
    
}

-(void)calculateNumAndPrice{
    for (ShoppingCart *cart in self.shoppingCarts) {
        if (cart.selected) {
            self.totalPrice += [cart.workPrice integerValue];
            self.totalNum += 1;
            [self creatBottomViewWithArtNum: [NSString stringWithFormat:@"%zd",self.totalNum] price:[NSString stringWithFormat:@"%zd",self.totalPrice] allBtnSelected:YES];
        }
        if (self.totalNum!=self.shoppingCarts.count) {
            self.selectAllBtn.selected = NO;
        }
        else{
            self.selectAllBtn.selected = YES;
        }
    }
    self.priceLb.text = [NSString stringWithFormat:@"%zd",self.totalPrice];
    self.numberLb.text = [NSString stringWithFormat:@"%zd",self.totalNum];
    self.totalPrice = 0;
    self.totalNum = 0;
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
