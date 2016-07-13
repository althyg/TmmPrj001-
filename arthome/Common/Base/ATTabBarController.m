//
//  ATTabBarController.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ATTabBarController.h"
#import "RootFindViewController.h"
//#import "FindViewController.h"
#import "ArtistViewController.h"
#import "InformationViewController.h"
#import "UserCenterController.h"
#import "ATNavigationController.h"
#import "LoginViewController.h"
#import "ShoppingCartViewController.h"
#import "ArticleViewController.h"

@interface ATTabBarController ()

@end

@implementation ATTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
    // Do any additional setup after loading the view.
}
-(void)setupChildControllers{
    // 添加首页
    RootFindViewController *findVc = [[RootFindViewController alloc] init];
    [self addChildVCWith:findVc title:@"发现" nmlImgName:@"tabBar_find_normal" selImgName:@"tabBar_find_selected"];
    
    //添加资讯
    ArticleViewController *articleVc = [[ArticleViewController alloc] init];
    [self addChildVCWith:articleVc title:@"资讯" nmlImgName:@"tabBar_news_normal" selImgName:
     @"tabBar_news_selected"];
    
    //添加购物车
    ShoppingCartViewController *cartVc = [[ShoppingCartViewController alloc] init];
    [self addChildVCWith:cartVc title:@"购物车" nmlImgName:@"tabBar_shopcart_normal" selImgName:@"tabBar_shopcart_selected"];
    
    //添加个人中心
    UserCenterController *userVc = [[UserCenterController alloc] init];
    [self addChildVCWith:userVc title:@"我的" nmlImgName:@"tabBar_mine_normal" selImgName:@"tabBar_mine_selected"];
}

-(void)addChildVCWith:(UIViewController *)vc title:(NSString *)title nmlImgName:(NSString *)nmlImgName selImgName:(NSString *)selImgName {
    
    ATNavigationController *nav = [[ATNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    //设置标题
    nav.tabBarItem.title = title;
    
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            COLOR_da1025, NSForegroundColorAttributeName,
                                            nil] forState:UIControlStateSelected];
    
    [nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            COLOR_999999, NSForegroundColorAttributeName,
                                            nil] forState:UIControlStateNormal];
    //设置普通状态图片
    nav.tabBarItem.image = [UIImage imageNamed:nmlImgName];
    UIImage *selImg = [UIImage imageNamed:selImgName];
    selImg = [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = selImg;
}


@end
