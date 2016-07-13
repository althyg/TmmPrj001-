//
//  ArticleCategoryController.m
//  arthome
//
//  Created by 海修杰 on 16/6/29.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArticleCategoryController.h"
#define ROWCOUNT 4

@interface ArticleCategoryController()

@end

@implementation ArticleCategoryController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    self.navigationItem.title = @"分类";
    self.view.backgroundColor = [UIColor whiteColor];
    //mainScr
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.bounces = YES ;
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    //bgView
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(160))];
    [mainScr addSubview:bgView];
    NSArray *titleArr = @[@"展讯",@"活动",@"专题",@"入门",@"鉴赏",@"导购",@"新闻",@"进阶"];
    CGFloat btnW = DEF_RESIZE_UI(50);
    CGFloat btnH = DEF_RESIZE_UI(50);
    CGFloat padding = DEF_RESIZE_UI(20);
    CGFloat marginX = (DEF_DEVICE_WIDTH -ROWCOUNT* btnW-DEF_RESIZE_UI(40)) / (ROWCOUNT-1);
    CGFloat marginY = DEF_RESIZE_UI(20);
    for (int index = 0; index < 8; index++) {
        int row = index / ROWCOUNT;
        int col = index % ROWCOUNT;
        CGFloat btnX = padding + (btnW + marginX) * col;
        CGFloat btnY = padding + (btnH + marginY) * row;
        UIButton *seleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [seleteBtn setTitle:titleArr[index] forState:UIControlStateNormal];
        [seleteBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        [seleteBtn setTitleColor:COLOR_da1025 forState:UIControlStateSelected];
        seleteBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        seleteBtn.layer.cornerRadius = 25;
        seleteBtn.layer.borderWidth = 1;
        seleteBtn.titleLabel.font = DEF_MyFont(14);
        [bgView addSubview:seleteBtn];
    }
    //submitBtn
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(94)-DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20), DEF_RESIZE_UI(44));
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.backgroundColor = COLOR_da1025;
    [submitBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    submitBtn.titleLabel.font = DEF_MyFont(16);
    [mainScr addSubview:submitBtn];
}

@end
