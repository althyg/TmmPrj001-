//
//  AboutAppController.m
//  arthome
//
//  Created by 海修杰 on 16/5/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AboutAppController.h"

@interface AboutAppController ()

@end

@implementation AboutAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_ffffff;
    self.navigationItem.title = @"关于APP";
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    UIImageView *iconImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"aboutapp")];
    iconImgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT);
    [mainScr addSubview:iconImgView];
}

@end
