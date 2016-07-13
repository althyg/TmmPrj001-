//
//  SystemDefine.h
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#ifndef SystemDefine_h
#define SystemDefine_h

/**
 *根据RGB获取color
 */
//根据RGB获取color
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define COLOR_VALUE(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:1.0]



/**
 *  设置颜色
 */
#define COLOR_ffffff COLOR_VALUE(0xffffff)
#define COLOR_333333 COLOR_VALUE(0x333333)
#define COLOR_cccccc COLOR_VALUE(0xcccccc)
#define COLOR_f2f2f2 COLOR_VALUE(0xf2f2f2)
#define COLOR_999999 COLOR_VALUE(0x999999)
#define COLOR_ff6060 COLOR_VALUE(0xda1025)
#define COLOR_666666 COLOR_VALUE(0x666666)
#define COLOR_4a4a4a COLOR_VALUE(0x4a4a4a)
#define COLOR_b3b3b3 COLOR_VALUE(0xb3b3b3)
#define COLOR_bbbbbb COLOR_VALUE(0xbbbbbb)
#define COLOR_e4e4e4 COLOR_VALUE(0xe4e4e4)
#define COLOR_fea7a1 COLOR_VALUE(0xfea7a1)
#define COLOR_6eb9ff COLOR_VALUE(0x6eb9ff)
#define COLOR_f7f7f7 COLOR_VALUE(0xf7f7f7)
#define COLOR_da1025 COLOR_VALUE(0xda1025)
#define COLOR_030303 COLOR_VALUE(0x030303)
#define COLOR_0076ff COLOR_VALUE(0x0076ff)
/**
 <#Description#>
 */
#define WRONGPHONENUMBER  @"请输入正确的手机号"
#define WRONGADDRESSTIP   @"请完善信息"
#define WRONGCONNECTION   @"网络连接错误"
#define WRONGINFOMATION   @"请完善信息"
/**
 客服电话
 */
#define SERVICESPHONE @"400-066-8101"
/**
  资讯URL
 */
#define INFORMATIONURL @"http://88art.com/news/newslist/appLists"
/**
 *适配
 */
#define DEF_RESIZE_UI(float)         ((float)/375.0f*DEF_DEVICE_WIDTH)
#define DEF_RESIZE_FRAME(frame)      CGRectMake(DEF_RESIZE_UI (frame.origin.x), DEF_RESIZE_UI (frame.origin.y), DEF_RESIZE_UI (frame.size.width), DEF_RESIZE_UI (frame.size.height))
#define DEF_AGAINST_RESIZE_UI(float) (float/DEF_DEVICE_WIDTH*320)


/**
 *字体
 */
#define DEF_MyFont(x)     [UIFont systemFontOfSize:x]
#define DEF_MyBoldFont(x) [UIFont boldSystemFontOfSize:x]

/**
 *设置图片
 */
#define DEF_DEFAULPLACEHOLDIMG      [UIImage imageNamed:@"global_default_img"]
#define DEF_IMAGENAME(name)         [UIImage imageNamed:name]
#define DEF_BUNDLE_IMAGE(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]

/**
 *获取AppDelegate
 */
#define DEF_MyAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/**
 *Document路径
 */
#define DEF_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 *NSUserDefault
 */
#define DEF_UserDefaults [NSUserDefaults standardUserDefaults]


//获取AppDelegate
#define MyAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KEYWINDOW [UIApplication sharedApplication].keyWindow

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define UP_IOS7 (SYSTEM_VERSION >= 7.0 ? YES : NO)

#define DEVICE_WIDTH MyAppDelegate.window.frame.size.width

#define DEVICE_HEIGHT (UP_IOS7 ? MyAppDelegate.window.frame.size.height:MyAppDelegate.window.frame.size.height - 20)

#define STRING_FROM_INT(int) [NSString stringWithFormat:@"%d",int]

#define BUNDLE_IMAGE(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]

/* *
 *iOS版本
 */
#define DEF_IOS7         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define DEF_IOS7Dot0     ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define DEF_IOS8         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

//获取APP当前版本号
#define AppCurrentVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]



/**
 *获取屏幕宽高
 */
#define DEF_DEVICE_WIDTH                [UIScreen mainScreen].bounds.size.width
#define DEF_DEVICE_HEIGHT               (DEF_IOS7 ? [UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.height - 20)
#define DEF_CONTENT_INTABBAR_HEIGHT     (DEF_IOS7 ? ([UIScreen mainScreen].bounds.size.height - 49):([UIScreen mainScreen].bounds.size.height - 69))
#define DEF_NAVIGATIONBAR_HEIGHT        64
#define DEF_TABBAR_HEIGHT               49

/**
 *创建controller
 */
#define DEF_VIEW_CONTROLLER_INIT(controllerName) [[NSClassFromString(controllerName) alloc] init]

/**
 *推controller
 */
#define DEF_PUSH_VIEW_CONTROLLER(name)          UIViewController *vc = DEF_VIEW_CONTROLLER_INIT(name); [DEF_MyAppDelegate.mainNav pushViewController:vc animated:YES];
#define DEF_PUSH_VIEW_CONTROLLER_WITH_XIB(name) UIViewController *vc = DEF_VIEW_CONTROLLER_INIT_WITH_XIB(name); [DEF_MyAppDelegate.mainNav pushViewController:vc animated:YES];

/**
 * app应用商店url
 */

#define AT_APP_ID @"1117253832"

#define AT_GRADE_URL DEF_IOS7?[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",AT_APP_ID]:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",AT_APP_ID]

#endif /* SystemDefine_h */
