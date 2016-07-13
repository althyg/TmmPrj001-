//
//  LoopPageControl.h
//  arthome
//
//  Created by 海修杰 on 16/4/5.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopPageControl : UIView

/**
 *  为选中按钮
 */
@property (nonatomic,strong) UIImage * nolImg ;
/**
 *  选中按钮
 */
@property (nonatomic,strong) UIImage * selImg ;
/**
 *  图片尺寸
 */
@property (nonatomic,assign) CGSize  imgSize ;
/**
 *  图片之间距离
 */
@property (nonatomic,assign) NSInteger  imgDistance;
/**
 *  图片个数
 */
@property (nonatomic,assign) NSInteger imgCount;

/**
 *  第几个被选中
 */
@property (nonatomic,assign) NSInteger  selCount;

@end
