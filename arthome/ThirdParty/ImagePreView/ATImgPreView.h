//
//  ATImgPreView.h
//  arthome
//
//  Created by 海修杰 on 16/5/30.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtWorksViewController;

@interface ATImgPreView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

@property (nonatomic,weak) ArtWorksViewController * worksVc ;

@end
