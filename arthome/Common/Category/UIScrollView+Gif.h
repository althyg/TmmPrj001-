//
//  UIScrollView+Gif.h
//  arthome
//
//  Created by 海修杰 on 16/6/30.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Gif)

/**
 * 添加一个引用UIScrollView+MJRefresh的gif图片的下拉刷新控件
 *
 * @param block 进入刷新状态就会自动调用这个block
 */
- (MJRefreshGifHeader *)addCustomGifHeaderWithRefreshingBlock:(void (^)())block;

/**
 * 添加一个引用UIScrollView+MJRefresh的gif图片的上拉加载控件
 *
 * @param block 进入刷新状态就会自动调用这个block
 */
- (MJRefreshLegendFooter *)addCustomGifFooterWithRefreshingBlock:(void (^)())block;

@end
