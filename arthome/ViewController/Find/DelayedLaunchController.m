//
//  DelayedLaunchController.m
//  arthome
//
//  Created by 海修杰 on 16/6/17.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "DelayedLaunchController.h"

@implementation DelayedLaunchController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImageView *delayImgView = [[UIImageView alloc]init];
    delayImgView.frame = self.view.bounds;
    [self.view addSubview:delayImgView];
    switch ((int)DEF_DEVICE_HEIGHT*2) {
        case 960:
        {
            delayImgView.image = DEF_IMAGENAME(@"Delay_iPhone960");
        }
            break;
        case 1136:
        {
            delayImgView.image = DEF_IMAGENAME(@"Delay_iPhone1136");
        }
            break;
        case 1334:
        {
            delayImgView.image = DEF_IMAGENAME(@"Delay_iPhone1334");
        }
            break;
        case 1472:
        {
            delayImgView.image = DEF_IMAGENAME(@"Delay_iPhone2208");
        }
            break;
            
        default:
            break;
    }
}

@end
