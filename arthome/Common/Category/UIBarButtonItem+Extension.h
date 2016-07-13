//
//  UIBarButtonItem+Extension.h
//  MoXin
//
//  Created by CaiMiao on 15/9/2.
//  Copyright (c) 2015年 zhangfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  @return UIBarButtonItem
 */
+(instancetype)barBtnItemWithNmlImg:(NSString *)nmlIme hltImg:(NSString *)hltImg target:(id)target action:(SEL)action;


/**
 *  返回固定样式导航条Item
 */
+(instancetype)barBtnItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;


/**
 *  固定样式的返回按钮
 *
 */
+(instancetype)backItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
/**
 *  固定的“返回”两个字按钮
 *
 */
+(instancetype)backItemWithTarget:(id)target action:(SEL)action;
/**
 *返回紫色文字按钮
 */
+(instancetype)barBtnItemWithPurpleTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
