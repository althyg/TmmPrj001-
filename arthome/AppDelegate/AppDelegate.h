//
//  AppDelegate.h
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATTabBarController.h"
typedef void(^BlockOrderPay)();
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) ATTabBarController * tabBarController ;

@property (nonatomic,copy) BlockOrderPay blockOrderPay ;
@end

