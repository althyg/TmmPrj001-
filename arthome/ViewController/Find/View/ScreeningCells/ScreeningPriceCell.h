//
//  ScreeningPriceCell.h
//  arthome
//
//  Created by qzwh on 16/7/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
// 用块返回价格区间值
typedef  void (^IntervalPriceNumber) (NSInteger minPrice, NSInteger maxPrice);

// 用块通知 ScreeningViewController 键盘弹出
typedef  void (^KeyboardShowBlock) (CGFloat animationDuration, CGRect keyboardRect);
// 用块通知 ScreeningViewController 键盘消失
typedef  void (^KeyboardHideBlock) (CGFloat animationDuration, CGRect keyboardRect);

@interface ScreeningPriceCell : UITableViewCell<UITextFieldDelegate>


@property (copy, nonatomic) IntervalPriceNumber intervalPriceNumber;

@property (copy, nonatomic) KeyboardShowBlock keyboardShowBlock;
@property (copy, nonatomic) KeyboardHideBlock keyboardHideBlock;

// 通过这个方法隐藏显示状态下的键盘
- (void)resignAllTextField;

- (void)clearTextContent;

@end
