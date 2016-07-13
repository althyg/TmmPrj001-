//
//  PerSettingViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "PerSettingViewController.h"
#import "InfoSettingViewController.h"
#import "PhoneBindingViewController.h"
#import "ChangeLoginPwdViewController.h"
#import "ShippingAddressViewcontroller.h"

@interface PerSettingViewController ()

@end

@implementation PerSettingViewController

-(void)viewDidLoad{
    self.navigationItem.title=@"账户管理";
    self.view.backgroundColor=COLOR_f2f2f2;
    SettingGroup * group1= [[SettingGroup alloc]init];
    SettingItem * item11=[SettingItemArrow itemWithTitle:@"资料设置" destVc:[InfoSettingViewController class]];
    SettingItem * item12=[SettingItemArrow itemWithTitle:@"手机绑定" destVc:[PhoneBindingViewController class]];
     SettingItem * item13=[SettingItemArrow itemWithTitle:@"收货地址管理" destVc:[ShippingAddressViewcontroller class]];
     SettingItem * item14=[SettingItemArrow itemWithTitle:@"修改登录密码" destVc:[ChangeLoginPwdViewController class]];
    group1.items=@[item11,item12,item13,item14];
    [self.groups addObject:group1];
    
    UIButton * loginOutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginOutBtn setTitle:@"注销当前账号" forState:UIControlStateNormal];
    loginOutBtn.backgroundColor = COLOR_ff6060;
    [loginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginOutBtn.titleLabel.font = DEF_MyFont(16);
    loginOutBtn.frame = CGRectMake(DEF_RESIZE_UI(10),DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(94)-DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44));
    [loginOutBtn addTarget:self action:@selector(loginOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:loginOutBtn];
}

#pragma mark - 退出按钮点击事件

-(void)loginOutBtnClick{
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否注销当前账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1==buttonIndex) {
        ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
        if (userInfo.appToken) {
            [userInfo clearUserInfo];
        }
        MyAppDelegate.window.rootViewController = MyAppDelegate.tabBarController;
        NSInteger  count = MyAppDelegate.tabBarController.childViewControllers[0].childViewControllers.count;
        if (count>1) {
            ATNavigationController *nav = MyAppDelegate.tabBarController.childViewControllers[0];
            [nav popToRootViewControllerAnimated:NO];
        }
        MyAppDelegate.tabBarController.selectedIndex = 3;
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSString * imgPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    imgPath = [imgPath stringByAppendingPathComponent:@"headImage"];
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:imgPath error:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}



@end
