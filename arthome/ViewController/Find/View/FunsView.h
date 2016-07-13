//
//  FunsView.h
//  arthome
//
//  Created by 海修杰 on 16/4/8.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BlockLike)();

@interface FunsView : UIView

@property (nonatomic,strong) NSArray * imgArr ;

@property (nonatomic,copy) BlockLike blockLike;

@property (nonatomic,copy) NSString * isLike;

@property (nonatomic,copy) NSString * likeNo;

@end
