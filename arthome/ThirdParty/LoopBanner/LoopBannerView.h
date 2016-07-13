//
//  LoopBannerView.h
//  arthome
//
//  Created by 海修杰 on 16/4/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^BlockBanner) (NSInteger);

@interface LoopBannerView : UIView

@property (nonatomic,strong) NSArray * imgViewArr ;

@property (nonatomic,copy ) BlockBanner  blockBanner ;

@end
