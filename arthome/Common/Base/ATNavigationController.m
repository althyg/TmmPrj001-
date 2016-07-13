//
//  ATNavigationController.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ATNavigationController.h"

@interface ATNavigationController ()

@end

@implementation ATNavigationController


+ (void)initialize {
    // 获得全局导航条(设置导航样式 主题)
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.backgroundColor=COLOR_ffffff;
    // 设置导航栏背景
    //[navBar setBackgroundImage:[UIImage imageNamed:@"bg_navbar"] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏标题颜色和字体大小
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = COLOR_333333;
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [navBar setTitleTextAttributes:attributes];
    // 在ios7.0之后,该属性不再影响导航栏背景颜色,但是还会印象上面UIBarButtonItem的颜色
    navBar.tintColor = [UIColor whiteColor];
    // 获得全局的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置UIBarButtonItem颜色和字体大小
    NSMutableDictionary *itemAttributes = [NSMutableDictionary dictionary];
    itemAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:itemAttributes forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    ATNavigationController* nvc = [super initWithRootViewController:rootViewController];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    nvc.delegate = self;
    return nvc;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}


// 拦截系统的push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTarget:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

/**
 *  返回上一个控制器
 */
-(void)back{
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-- 横竖屏

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



@end
