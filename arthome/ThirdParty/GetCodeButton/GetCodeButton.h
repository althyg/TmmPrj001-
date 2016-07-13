//
//  GetCodeButton.h
//  YHOUSE
//
//  Created by FENG on 15-1-7.
//  Copyright (c) 2015年 FENG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CodeFinish)(void);

#define SECONDS_COUNT 60

@interface GetCodeButton : UIButton

@property (nonatomic ,strong) CodeFinish finish;            //倒计时结束回调
@property (nonatomic ,strong) UIColor *disabledColor;       //倒计时时字体颜色
@property (nonatomic ,strong) UIColor *enableColor;         //可用状态字体颜色
@property (nonatomic ,strong) UIFont *font;                 //字体

@property (nonatomic) BOOL isLoading;

- (void)start;
- (void)stop;

@end
