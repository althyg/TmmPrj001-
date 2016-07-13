//
//  ThirdShareTool.m
//  arthome
//
//  Created by 海修杰 on 16/5/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ThirdShareTool.h"

@interface ThirdShareTool ()

@property (nonatomic,strong) UIView * popView ;

@property(nonatomic,strong) UIButton * conver;

@property (nonatomic,assign) CGFloat  popViewH;

@property (nonatomic,copy) ShareBlock shareBlock ;




@end

@implementation ThirdShareTool

-(instancetype)initWithContent:(NSString*)shareLink{
    if (self = [super init]) {
        [self initializeConver];
        [self creatPopView];
    }
    return self;
}

-(void)handleBlock:(ShareBlock) shareBlock{
    self.shareBlock = shareBlock;
}

-(void)thirdShareBtnClick:(UIButton *)btn{
    self.shareBlock(btn.tag-1000);
}

-(void)creatPopView{
    
    UIView * sharedView=[[UIView alloc]init];
    sharedView.backgroundColor=[UIColor clearColor];
    self.popView=sharedView;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:sharedView];
    //bgView
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = COLOR_RGBA(255, 255, 255, 0.8);
    bgView.layer.cornerRadius = 8;
    bgView.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_DEVICE_WIDTH-DEF_RESIZE_UI(20), DEF_RESIZE_UI(103));
    [sharedView addSubview:bgView];
    CGFloat padding = (bgView.width-2*DEF_RESIZE_UI(20)-4*DEF_RESIZE_UI(60))*0.3333;
    CGFloat iconY = DEF_RESIZE_UI(15);
    CGFloat iconW = DEF_RESIZE_UI(60);
    CGFloat iconH = DEF_RESIZE_UI(60);
    //微博button
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.tag = 1000;
    [weiboBtn setImage:DEF_IMAGENAME(@"global_share_weibo") forState:UIControlStateNormal];
    weiboBtn.frame = CGRectMake(DEF_RESIZE_UI(20), iconY, iconW, iconH);
    [weiboBtn addTarget:self action:@selector(thirdShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:weiboBtn];
    CGFloat tipLbY = CGRectGetMaxY(weiboBtn.frame)+DEF_RESIZE_UI(5);
    CGFloat tipLbW = DEF_RESIZE_UI(60);
    CGFloat tipLbH = DEF_RESIZE_UI(11);
    //微博 tip
    UILabel *weiboLb = [[UILabel alloc]init];
    weiboLb.text = @"新浪微博";
    weiboLb.textAlignment = NSTextAlignmentCenter;
    weiboLb.textColor = COLOR_030303;
    weiboLb.font = DEF_MyFont(11);
    weiboLb.frame = CGRectMake(DEF_RESIZE_UI(20), tipLbY, tipLbW, tipLbH);
   [bgView addSubview:weiboLb];
    //微信好友button
    UIButton *weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weChatBtn.tag = 1001;
    [weChatBtn setImage:DEF_IMAGENAME(@"global_share_wechat") forState:UIControlStateNormal];
    weChatBtn.frame = CGRectMake(CGRectGetMaxX(weiboBtn.frame)+padding, iconY, iconW, iconH);
    [weChatBtn addTarget:self action:@selector(thirdShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:weChatBtn];
    //微信好友 tip
    UILabel *weChatLb = [[UILabel alloc]init];
    weChatLb.text = @"微信好友";
    weChatLb.textAlignment = NSTextAlignmentCenter;
    weChatLb.textColor = COLOR_030303;
    weChatLb.font = DEF_MyFont(11);
    weChatLb.frame = CGRectMake(weChatBtn.x, tipLbY, tipLbW, tipLbH);
    [bgView addSubview:weChatLb];
    //朋友圈button
    UIButton *friCirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friCirBtn.tag = 1002;
    [friCirBtn setImage:DEF_IMAGENAME(@"global_share_fricir") forState:UIControlStateNormal];
    friCirBtn.frame = CGRectMake(CGRectGetMaxX(weChatBtn.frame)+padding, iconY, iconW, iconH);
    [friCirBtn addTarget:self action:@selector(thirdShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:friCirBtn];
    //朋友圈 tip
    UILabel *friCirBLb = [[UILabel alloc]init];
    friCirBLb.text = @"朋友圈";
    friCirBLb.textAlignment = NSTextAlignmentCenter;
    friCirBLb.textColor = COLOR_030303;
    friCirBLb.font = DEF_MyFont(11);
    friCirBLb.frame = CGRectMake(friCirBtn.x, tipLbY, tipLbW, tipLbH);
    [bgView addSubview:friCirBLb];
    //QQ button
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.tag = 1003;
    [qqBtn setImage:DEF_IMAGENAME(@"global_share_qq") forState:UIControlStateNormal];
    qqBtn.frame = CGRectMake(CGRectGetMaxX(friCirBtn.frame)+padding, iconY, iconW, iconH);
    [qqBtn addTarget:self action:@selector(thirdShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:qqBtn];
    //QQ tip
    UILabel *qqLb = [[UILabel alloc]init];
    qqLb.text = @"QQ好友";
    qqLb.textAlignment = NSTextAlignmentCenter;
    qqLb.textColor = COLOR_030303;
    qqLb.font = DEF_MyFont(11);
    qqLb.frame = CGRectMake(qqBtn.x, tipLbY, tipLbW, tipLbH);
    [bgView addSubview:qqLb];
    //取消button
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = COLOR_RGBA(255, 255, 255, 0.8);
    cancelBtn.layer.cornerRadius = 8;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_0076ff forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = DEF_MyFont(20);
    cancelBtn.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(bgView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(58));
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sharedView addSubview:cancelBtn];
    self.popViewH = CGRectGetMaxY(cancelBtn.frame)+DEF_RESIZE_UI(10);
    
    sharedView.frame=CGRectMake(0, DEF_DEVICE_HEIGHT,DEF_DEVICE_WIDTH , self.popViewH);
    [UIView animateWithDuration:0.3 animations:^{
        self.popView.frame = CGRectMake(0, DEF_DEVICE_HEIGHT-self.popViewH, DEF_DEVICE_WIDTH, self.popViewH);
    }];
}
-(void)cancelBtnClick{
    [self converClick];
}

/**
 *  初始化遮盖
 */
-(void)initializeConver{
    self.conver = [[UIButton alloc] init];
    self.conver.bounds = [UIScreen mainScreen].bounds;
    self.conver.backgroundColor =[UIColor blackColor];
    self.conver.alpha = 0.5;
    [self.conver addTarget:self action:@selector(converClick) forControlEvents:UIControlEventTouchUpInside];
    self.conver.x = 0;
    self.conver.y = 0;
    //将遮盖添加到window
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.conver];
}

/**
 *  监听遮盖点击事件
 */
-(void)converClick{
    [UIView animateWithDuration:0.3 animations:^{
         self.popView.frame = CGRectMake(0, DEF_DEVICE_HEIGHT,DEF_DEVICE_WIDTH , self.popViewH);
    }];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.conver removeFromSuperview];
        [self.popView removeFromSuperview];
    });
}

-(void)removeFromWindow{
    [self converClick];
}
@end
