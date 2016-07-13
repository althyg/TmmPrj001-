//
//  LoadFailShowView.h
//  EconomicAnalysis
//
//  Created by CaiMiao on 15/12/17.
//  Copyright © 2015年 Huo.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum LoadFailType {
    LoadFailTypeNoneData,//暂无数据
    LoadFailTypeLoadFail,//加载失败
}LoadFailType;

@interface LoadFailView : UIView
/**
 *  @param view 当前控制器View
 *  @param type 数据异常类型
 */
+(LoadFailView *)showFailViewInView:(UIView *) view  withType:(LoadFailType) type ;

//加载失败时重试button回调
- (void)handle:(void(^)())block;

//从父View上移除
+(void)removeFromCurrentView:(UIView *)view;

@end
