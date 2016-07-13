//
//  AppDelegate.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AppDelegate.h"
#import "AlipayHeader.h"
#import "GBWXPayManager.h"

#import "ATNavigationController.h"
#import "DelayedLaunchController.h"

//友盟分享
#import <UMSocial.h>
#import <UMMobClick/MobClick.h>
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"


#define UMengKey @"57146891e0f55abf130013bb"

@interface AppDelegate ()<UITabBarControllerDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMengKey];
    UMConfigInstance.appKey = UMengKey;
    UMConfigInstance.channelId = @"App Store";
    
    //开启推送
    //设置 AppKey 及 LaunchOptions
    [MobClick startWithConfigure:UMConfigInstance];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx013641e994d2fb2f" appSecret:@"839c3ed5b3df02010e9cbf784859cb2b" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105316811" appKey:@"DP7hQebHKCXTjoVR" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1198722312" secret:@"856d1c3faa4bf2c4801952d6751fa14f" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
        DelayedLaunchController *delayVc = [[DelayedLaunchController alloc]init];
        self.window.rootViewController = delayVc;
        [self performSelector:@selector(newFeature) withObject:nil afterDelay:1.5];
    
    [self.window makeKeyAndVisible];
//    [[UIApplication sharedApplication ] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

-(void)newFeature{
    ATTabBarController *contentTabbar=[[ATTabBarController alloc]init];
    self.tabBarController = contentTabbar;
    contentTabbar.delegate = self;
    self.window.rootViewController=contentTabbar;
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if (![ATUserInfo shareUserInfo].appToken.length) {
//            if (tabBarController.selectedIndex == 3) {
//            LoginViewController *logVc = [[LoginViewController alloc]init];
//            ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
//            self.window.rootViewController=nav;
//         }
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                self.blockOrderPay();
                
            }
        }];
        if ([url.host isEqualToString:@"safepay"]){//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            }];
        }
        //微信支付
        [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}

#pragma mark - 微信支付回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayresult" object:@"1"];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    self.blockOrderPay();
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}



@end
