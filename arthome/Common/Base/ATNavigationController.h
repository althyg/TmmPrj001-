//
//  ATNavigationController.h
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATNavigationController : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

/*
 防止一次触发多个手势时造成navigationBar的错乱甚至崩溃
 */
@property(nonatomic,weak) UIViewController* currentShowVC;



@end
