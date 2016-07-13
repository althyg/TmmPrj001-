//
//  UIScrollView+Gif.m
//  arthome
//
//  Created by 海修杰 on 16/6/30.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "UIScrollView+Gif.h"

@implementation UIScrollView (Gif)

#pragma mark - gif 下拉刷新 隐藏状态时间
- (MJRefreshGifHeader *)addCustomGifHeaderWithRefreshingBlock:(void (^)())block;
{
    MJRefreshGifHeader  *header =[self addGifHeaderWithRefreshingBlock:^{
        block();
    }];
    
//    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<26; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"head_refresh_%zd", i]];
        [idleImages addObject:image];
    }
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<14; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"head_finish_%zd", i]];
        [refreshingImages addObject:image];
    }
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshHeaderStateIdle];
    [header setImages:idleImages forState:MJRefreshHeaderStatePulling];
    [header setImages:idleImages forState:MJRefreshHeaderStateRefreshing];
    [header setImages:refreshingImages forState:MJRefreshHeaderStateWillRefresh];
    
    //设置状态文字
//    [header setTitle:@"下拉刷新" forState:MJRefreshHeaderStateIdle];
//    [header setTitle:@"放手是一种态度" forState:MJRefreshHeaderStatePulling];
//    [header setTitle:@"刷新中..." forState:MJRefreshHeaderStateRefreshing];
//    [header setTitle:@"刷新完成" forState:MJRefreshHeaderStateWillRefresh];
    
    // 隐藏状态
     header.stateHidden = YES;
    // 隐藏时间
    header.updatedTimeHidden = YES;
    
    return header;
}

#pragma mark - gif 上拉加载 隐藏状态
- (MJRefreshLegendFooter *)addCustomGifFooterWithRefreshingBlock:(void (^)())block
{
    //无动画
    MJRefreshLegendFooter  *footer =[self addLegendFooterWithRefreshingBlock:^{
        block();
    }];
    
    /*有动画
     MJRefreshGifFooter  *footer =[self addGifFooterWithRefreshingBlock:^{
     block();
     }];
     // 隐藏状态
     footer.stateHidden = YES;
     //当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新)
     footer.appearencePercentTriggerAutoRefresh = 0.5;
     
     NSInteger dropdown_anim_num    = 10;
     
     // 设置普通状态的动画图片
     NSMutableArray *idleImages = [NSMutableArray array];
     for (NSUInteger i = 7; i<= dropdown_anim_num; i++) {
     UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%zd", i]];
     [idleImages addObject:image];
     }
     
     footer.refreshingImages = idleImages;
     */
    return footer;
}


@end
