//
//  UserCenterController.m
//  arthome
//
//  Created by 海修杰 on 16/6/24.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "UserCenterController.h"
#import "OrderViewcontroller.h"
#import "ShoppingCartViewController.h"
#import "PerSettingViewController.h"
#import "SysSettingViewController.h"
#import "FavoritesViewController.h"
#import "FunsViewController.h"
#import "FocusViewController.h"
#import "InfoSettingViewController.h"
#import "ArtWorksViewController.h"
#import "RefundViewController.h"
#import "RefundDetailController.h"
#import "RefundDetailController.h"
#import "OrderViewcontroller.h"
#import "LoginViewController.h"

@interface UserCenterController ()

@property (nonatomic,strong) UIImageView * userHeadView ;

@property (nonatomic,strong) UILabel * userNameLb ;

@property (nonatomic,strong) UILabel * userPhoneLb ;

@property (nonatomic,strong) UIButton * focusBtn ;

@property (nonatomic,strong) UIButton * funsBtn ;

@property (nonatomic,strong) UITabBarItem * item0 ;

@property (nonatomic,strong) UITabBarItem * item1 ;

@property (nonatomic,strong) UITabBarItem * item2 ;

@property (nonatomic,strong) UITabBarItem * item3 ;

@property (nonatomic,strong) UITabBarItem * item4 ;

@end

@implementation UserCenterController

-(void)viewDidLoad{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initUI];
    if ([ATUserInfo shareUserInfo].appToken.length) {
    ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
    NSDictionary * dic = @{
                           @"appToken" : userInfo.appToken,
                           @"headSize" : @"80x80"
                           };
    if ([userInfo.userType integerValue]) {
        [self mineInfoartistHttpRequestWithDictionary:dic];
    }
    else{
        [self mineInfoartistHttpRequestWithDictionary:dic];
    }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers lastObject] != self) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - 我的订单点击
-(void)orderViewGestureClick{
    if (![ATUserInfo shareUserInfo].appToken.length) {
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        OrderViewcontroller *orderVc = [[OrderViewcontroller alloc]init];
        [self.navigationController pushViewController:orderVc animated:YES];
    }
}
#pragma mark - 收藏夹点击
-(void)collectionViewViewGestureClick{
    if (![ATUserInfo shareUserInfo].appToken.length) {
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        FavoritesViewController *favorVc = [[FavoritesViewController alloc]init];
        [self.navigationController pushViewController:favorVc animated:YES];
    }
}
#pragma mark - 系统设置点击
-(void)settingBtnClick{
        SysSettingViewController *sysVc=[[SysSettingViewController alloc]init];
        [self.navigationController pushViewController:sysVc animated:YES];
}
#pragma mark - 账户管理点击
-(void)accountGestureClick{
    if (![ATUserInfo shareUserInfo].appToken.length) {
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else{
        PerSettingViewController *perVc=[[PerSettingViewController alloc]init];
        [self.navigationController pushViewController:perVc animated:YES];
    }
}
/**
 *  艺术家个人中心网络请求
 */
-(void)mineInfoartistHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager mineInfoArtistWithParametersDic:dic
                                            success:^(NSDictionary *result) {
                                              if (200==[result[@"code"] integerValue]){
                                                  [self.userHeadView sd_setImageWithURL:[NSURL URLWithString:result[@"headImgUrl"]]
                                                                       placeholderImage:DEF_IMAGENAME(@"mine_head_80")];
                                                  self.userNameLb.text = result[@"userName"];
                                                  self.userPhoneLb.text = result[@"userPhone"];
                                                  [self.focusBtn setTitle:result[@"foucusNo"] forState:UIControlStateNormal];
                                                  [self.funsBtn setTitle:result[@"funsNo"] forState:UIControlStateNormal];
                                                  self.item0.badgeValue = result[@"waitPayNo"];
                                                  self.item1.badgeValue = result[@"waitSendNo"];
                                                  self.item2.badgeValue = result[@"waitReceNo"];
                                                  self.item3.badgeValue = result[@"tradeSuccNo"];
                                                  self.item4.badgeValue = result[@"refundNo"];
                                              }
                                            }
                                           failture:^(id result) {
                                               
                                           }];
}
/**
 *  普通用户个人中心网络请求
 */
-(void)mineInfoNormalHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager mineInfoNormalWithParametersDic:dic
                                            success:^(NSDictionary *result) {
                                                if (200==[result[@"code"] integerValue]){
                                                    [self.userHeadView sd_setImageWithURL:[NSURL URLWithString:result[@"headImgUrl"]]
                                                                         placeholderImage:DEF_IMAGENAME(@"mine_head_80")];
                                                    self.userNameLb.text = result[@"userName"];
                                                    self.userPhoneLb.text = result[@"userPhone"];
                                                    [self.focusBtn setTitle:result[@"foucusNo"] forState:UIControlStateNormal];
                                                    self.item0.badgeValue = result[@"waitPayNo"];
                                                    self.item1.badgeValue = result[@"waitSendNo"];
                                                    self.item2.badgeValue = result[@"waitReceNo"];
                                                    self.item3.badgeValue = result[@"tradeSuccNo"];
                                                    self.item4.badgeValue = result[@"refundNo"];
                                                }
                                            }
                                           failture:^(id result) {
                                               
                                           }];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.bounces = YES ;
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.contentSize = CGSizeMake(0, mainScr.height+1);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    //bgImage
    UIImageView * bgImageView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_mine_front")];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(166));
    [mainScr addSubview:bgImageView];
    //标题
    UILabel *titleLb = [[UILabel alloc]init];
    titleLb.font = DEF_MyFont(16);
    titleLb.textColor = COLOR_ffffff;
    titleLb.text = @"个人中心";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.frame = CGRectMake(0, DEF_RESIZE_UI(35), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(20));
    [bgImageView  addSubview:titleLb];
    //settingBtn
    UIButton * settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setImage:DEF_IMAGENAME(@"mine_setting") forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.imageView.contentMode = UIViewContentModeCenter;
    settingBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(44), titleLb.y-DEF_RESIZE_UI(10), DEF_RESIZE_UI(44), DEF_RESIZE_UI(40));
    [bgImageView addSubview:settingBtn];
        if (![ATUserInfo shareUserInfo].appToken.length) {
            //accountView
            UIView *accountView = [[UIView alloc]init];
            accountView.userInteractionEnabled = YES;
            UITapGestureRecognizer *accountGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accountGestureClick)];
            [accountView addGestureRecognizer:accountGesture];
            accountView.frame = CGRectMake(0, bgImageView.height-DEF_RESIZE_UI(90), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(80));
            [bgImageView addSubview:accountView];
            //headImageView
            UIImageView *userHeadView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_head_80")];
            self.userHeadView = userHeadView;
            userHeadView.layer.cornerRadius = DEF_RESIZE_UI(40);
            userHeadView.clipsToBounds = YES;
            userHeadView.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(80), DEF_RESIZE_UI(80));
            [accountView addSubview:userHeadView];
            //LoginLb
            UILabel *loginLb = [[UILabel alloc]init];
            loginLb.text = @"请登录/注册";
            loginLb.font = DEF_MyFont(16);
            loginLb.textColor = COLOR_ffffff;
            loginLb.textAlignment = NSTextAlignmentLeft;
            loginLb.frame = CGRectMake(CGRectGetMaxX(userHeadView.frame)+DEF_RESIZE_UI(20), 0, DEF_RESIZE_UI(100), DEF_RESIZE_UI(80));
            [accountView addSubview:loginLb];
        }
        else{
    //accountView
    UIView *accountView = [[UIView alloc]init];
    accountView.userInteractionEnabled = YES;
    UITapGestureRecognizer *accountGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accountGestureClick)];
    [accountView addGestureRecognizer:accountGesture];
    accountView.frame = CGRectMake(0, bgImageView.height-DEF_RESIZE_UI(90), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(80));
    [bgImageView addSubview:accountView];
    //headImageView
    UIImageView *userHeadView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_head_80")];
    self.userHeadView = userHeadView;
    userHeadView.layer.cornerRadius = DEF_RESIZE_UI(40);
    userHeadView.clipsToBounds = YES;
    userHeadView.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(80), DEF_RESIZE_UI(80));
    [accountView addSubview:userHeadView];
    //userName
    UILabel *userNameLb = [[UILabel alloc]init];
    self.userNameLb = userNameLb;
    userNameLb.font = DEF_MyFont(16);
    userNameLb.textColor = COLOR_ffffff;
    userNameLb.textAlignment = NSTextAlignmentLeft;
    userNameLb.frame = CGRectMake(CGRectGetMaxX(userHeadView.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(5), DEF_RESIZE_UI(120), DEF_RESIZE_UI(16));
    [accountView addSubview:userNameLb];
    //userPhone
    UILabel *userPhoneLb = [[UILabel alloc]init];
    self.userPhoneLb = userPhoneLb;
    userPhoneLb.font = DEF_MyFont(11);
    userPhoneLb.textColor = COLOR_ffffff;
    userPhoneLb.textAlignment = NSTextAlignmentLeft;
    userPhoneLb.frame = CGRectMake(CGRectGetMaxX(userHeadView.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(30), DEF_RESIZE_UI(100), DEF_RESIZE_UI(16));
    [accountView addSubview:userPhoneLb];
    //focusBtn
    UIButton *focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.focusBtn = focusBtn;
    [focusBtn setImage:DEF_IMAGENAME(@"mine_usercentre_focus") forState:UIControlStateNormal];
    [focusBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    focusBtn.titleLabel.font = DEF_MyFont(11);
    focusBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    focusBtn.frame = CGRectMake(CGRectGetMaxX(userHeadView.frame)+DEF_RESIZE_UI(10), accountView.height-DEF_RESIZE_UI(28), DEF_RESIZE_UI(50), DEF_RESIZE_UI(22));
    [accountView addSubview:focusBtn];
    //funsBtn
    UIButton *funsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.funsBtn = funsBtn;
    [funsBtn setImage:DEF_IMAGENAME(@"mine_usercentre_funs") forState:UIControlStateNormal];
    [funsBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    funsBtn.titleLabel.font = DEF_MyFont(11);
    funsBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    funsBtn.frame = CGRectMake(CGRectGetMaxX(focusBtn.frame)+DEF_RESIZE_UI(10), accountView.height-DEF_RESIZE_UI(28), DEF_RESIZE_UI(50), DEF_RESIZE_UI(22));
    [accountView addSubview:funsBtn];
    //arrow
    UIImageView *arrowImgView3 = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"arrow_right_gray")];
    arrowImgView3.contentMode = UIViewContentModeCenter;
    arrowImgView3.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(18), 0, DEF_RESIZE_UI(8), accountView.height);
    [accountView addSubview:arrowImgView3];
    //账户管理
    UILabel * managerLb = [[UILabel alloc]init];
    managerLb.font = DEF_MyFont(12);
    managerLb.text = @"账户管理";
    managerLb.textColor = COLOR_ffffff;
    managerLb.textAlignment = NSTextAlignmentRight;
    managerLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(90), 0, DEF_RESIZE_UI(50), accountView.height);
    [accountView addSubview:managerLb];
        }
    //我的订单
    UIView *orderView = [[UIView alloc]init];
    UITapGestureRecognizer *orderViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(orderViewGestureClick)];
    [orderView addGestureRecognizer:orderViewGesture];
    orderView.backgroundColor = COLOR_ffffff;
    orderView.frame = CGRectMake(0, CGRectGetMaxY(bgImageView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(44));
    [mainScr addSubview:orderView];
    //icon
    UIImageView *iconImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_icon_order")];
    iconImgView.contentMode = UIViewContentModeCenter;
    iconImgView.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(12), orderView.height);
    [orderView addSubview:iconImgView];
    //lb
    UILabel * orderLb = [[UILabel alloc]init];
    orderLb.text = @"我的订单";
    orderLb.font = DEF_MyFont(13);
    orderLb.textColor = COLOR_999999;
    orderLb.textAlignment = NSTextAlignmentLeft;
    orderLb.frame = CGRectMake(CGRectGetMaxX(iconImgView.frame)+DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(80), orderView.height);
    [orderView addSubview:orderLb];
    //arrow
    UIImageView *arrowImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"arrow_right_gray")];
    arrowImgView.contentMode = UIViewContentModeCenter;
    arrowImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(18), 0, DEF_RESIZE_UI(8), orderView.height);
    [orderView addSubview:arrowImgView];
    //apart
    UIView *apartLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderView.frame), DEF_DEVICE_WIDTH, 1)];
    apartLine.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:apartLine];
//  tabBar
    UITabBarItem *item0 = [[UITabBarItem alloc] initWithTitle:@"待付款" image:DEF_IMAGENAME(@"mine_tabbar_waitpay") tag:0];
    self.item0 = item0;
    UIImage *selImg0 = DEF_IMAGENAME(@"mine_tabbar_waitpay");
    selImg0 = [selImg0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage = selImg0;
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"待发货" image:DEF_IMAGENAME(@"mine_tabbar_waitsend") tag:1];
    self.item1 = item1;
    UIImage *selImg1 = DEF_IMAGENAME(@"mine_tabbar_waitsend");
    selImg1 = [selImg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = selImg1;
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"待收货" image:DEF_IMAGENAME(@"mine_tabbar_waitrece") tag:2];
    self.item2 = item2;
    UIImage *selImg2 = DEF_IMAGENAME(@"mine_tabbar_waitrece");
    selImg2 = [selImg2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = selImg2;
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"交易成功" image:DEF_IMAGENAME(@"mine_tabBar_tradesucced") tag:3];
    self.item3 = item3;
    UIImage *selImg3 = DEF_IMAGENAME(@"mine_tabBar_tradesucced");
    selImg3 = [selImg3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = selImg3;
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"退款/退货" image:DEF_IMAGENAME(@"mine_tabbar_refund") tag:4];
    self.item4 = item4;
    UIImage *selImg4 = DEF_IMAGENAME(@"mine_tabbar_refund");
    selImg4 = [selImg4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = selImg4;    
    UITabBar * tabBar = [[UITabBar alloc]init];
    tabBar.barTintColor = COLOR_ffffff;
    tabBar.backgroundColor = COLOR_ffffff;
    tabBar.backgroundImage = [[UIImage alloc]init];
    tabBar.shadowImage = [[UIImage alloc]init];
    tabBar.frame = CGRectMake(0, CGRectGetMaxY(apartLine.frame), DEF_DEVICE_WIDTH, 49);
    tabBar.items = @[item0,item1,item2,item3,item4];
    [mainScr addSubview:tabBar];
    for (UITabBarItem *item in tabBar.items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       COLOR_666666, NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateSelected];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       COLOR_666666, NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];

    }
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tabBar.frame), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10))];
    backView.backgroundColor = COLOR_ffffff;
    [mainScr addSubview:backView];
    //收藏夹
    UIView *collectionView = [[UIView alloc]init];
    collectionView.userInteractionEnabled = YES;
    UITapGestureRecognizer *collectionViewViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectionViewViewGestureClick)];
    [collectionView addGestureRecognizer:collectionViewViewGesture];
    collectionView.backgroundColor = COLOR_ffffff;
    collectionView.frame = CGRectMake(0, CGRectGetMaxY(backView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(44));
    [mainScr addSubview:collectionView];
    //icon
    UIImageView *iconImgView2 = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_mine_collection")];
    iconImgView2.contentMode = UIViewContentModeCenter;
    iconImgView2.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(12), orderView.height);
    [collectionView addSubview:iconImgView2];
    //lb
    UILabel * collectionLb = [[UILabel alloc]init];
    collectionLb.text = @"收藏夹";
    collectionLb.font = DEF_MyFont(13);
    collectionLb.textColor = COLOR_999999;
    collectionLb.textAlignment = NSTextAlignmentLeft;
    collectionLb.frame = CGRectMake(CGRectGetMaxX(iconImgView.frame)+DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(80), orderView.height);
    [collectionView addSubview:collectionLb];
    //arrow
    UIImageView *arrowImgView2 = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"arrow_right_gray")];
    arrowImgView2.contentMode = UIViewContentModeCenter;
    arrowImgView2.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(18), 0, DEF_RESIZE_UI(8), orderView.height);
    [collectionView addSubview:arrowImgView2];
    //apart
    UIView *apartLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame), DEF_DEVICE_WIDTH, 1)];
    apartLine2.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:apartLine2];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
