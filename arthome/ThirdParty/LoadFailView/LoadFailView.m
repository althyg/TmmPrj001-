//
//  LoadFailShowView.m
//  EconomicAnalysis
//
//  Created by CaiMiao on 15/12/17.
//  Copyright © 2015年 Huo.com. All rights reserved.
//

#import "LoadFailView.h"
#define LoadFailViewTAG  8888

typedef  void (^FailBlock)();

@interface LoadFailView ()

@property (nonatomic,copy)  FailBlock failBlock;

@end

@implementation LoadFailView

+(LoadFailView *)showFailViewInView:(UIView *) view  withType:(LoadFailType) type {
    if ([view viewWithTag:LoadFailViewTAG]) {
        return [view viewWithTag:LoadFailViewTAG];
    }
    LoadFailView * loadFailView=[[self alloc]init];
    loadFailView.tag=LoadFailViewTAG;
    loadFailView.backgroundColor=[UIColor whiteColor];
    [view addSubview:loadFailView];
    loadFailView.frame=CGRectMake(0, 0, view.width, view.height);
    UIImageView * minImgView=[[UIImageView alloc]init];
    minImgView.contentMode=UIViewContentModeCenter;
    minImgView.size=CGSizeMake(25, 25);
    minImgView.center=CGPointMake(view.width*0.5,view.height*0.5-40);
    [loadFailView addSubview:minImgView];
    
    UILabel * tipLb=[[UILabel alloc]init];
    tipLb.font=DEF_MyBoldFont(15);
    tipLb.textAlignment=NSTextAlignmentCenter;
    tipLb.textColor=[UIColor grayColor];
    tipLb.frame=CGRectMake(0, CGRectGetMaxY(minImgView.frame)+5, view.width, 30);
    [loadFailView addSubview:tipLb];
    
    if (type==LoadFailTypeNoneData) {
        tipLb.text=@"暂无数据";
        minImgView.image=DEF_IMAGENAME(@"icon_loadfail_nonedata");
    }
    else{
        tipLb.text=@"数据加载失败";
        minImgView.image=DEF_IMAGENAME(@"icon_loadfail_loadfail");
        UIButton * loadAgainBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        loadAgainBtn.titleLabel.font=DEF_MyBoldFont(16);
        
        [loadAgainBtn setBackgroundImage:DEF_IMAGENAME(@"icon_loadfail_againbtnbgimg") forState:UIControlStateNormal];
        [loadAgainBtn setTitle:@"重试" forState:UIControlStateNormal];
        [loadAgainBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loadFailView addSubview:loadAgainBtn];
        [loadAgainBtn addTarget:loadFailView action:@selector(againBtnClick) forControlEvents:UIControlEventTouchUpInside];
        ;
        CGFloat btnW=140;
        loadAgainBtn.frame=CGRectMake((view.width-btnW)*0.5, CGRectGetMaxY(tipLb.frame)+20, btnW, 31);
        
    }
    return loadFailView;
}


- (void)handle:(void(^)())block{
    self.failBlock=block;
}

-(void)againBtnClick{
    if (self.failBlock) {
        self.failBlock();
    }
    [self removeFromSuperview];
}

+(void)removeFromCurrentView:(UIView *)view{
    UIView * tagView=[view viewWithTag:LoadFailViewTAG];
    if (tagView) {
        [tagView removeFromSuperview];
    }
    
}

@end






