//
//  ChangeLoginPwdViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ChangeLoginPwdViewController.h"

@interface ChangeLoginPwdViewController ()

@property (nonatomic,strong) UITextField * nowPwdTF ;

@property (nonatomic,strong) UITextField * newpwdTF ;

@property (nonatomic,strong) UITextField * affPwdTF ;


@end

@implementation ChangeLoginPwdViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nowPwdTF becomeFirstResponder];
}

-(void)submitBtnClick{
    if (self.nowPwdTF.text.length&&self.newpwdTF.text.length&&self.affPwdTF.text) {
        NSString * pwdbef = [ATUtility securePassWord:self.nowPwdTF.text];
        NSString * pwdaft = [ATUtility securePassWord:self.newpwdTF.text];
        NSString * pwdsure = [ATUtility securePassWord:self.affPwdTF.text];
        NSDictionary * dic = @{
                               @"pwdbef" :pwdbef,
                               @"pwdaft" : pwdaft,
                               @"pwdsure" : pwdsure
                               };
        [self mineLoginPwdChangeHttpRequestWithDictionary:dic];
    }
    else{
        [ATUtility showTipMessage:WRONGADDRESSTIP];
    }

}
/**
 *  修改登录密码网络请求
 */
-(void)mineLoginPwdChangeHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineLoginPwdChangeWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        [ATUtility showTipMessage:result[@"message"]];
        if ([result[@"code"] integerValue] ==200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

-(void)initUI{
    self.navigationItem.title = @"修改登录密码";
    self.view.backgroundColor = [UIColor whiteColor];
    //
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    CGFloat titleLbW = DEF_RESIZE_UI(100);
    CGFloat titleTFW = DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)- titleLbW;
    
    //旧密码
    UIView *nowPwdView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44))];
    nowPwdView.layer.borderWidth = 1;
    nowPwdView.layer.borderColor = COLOR_cccccc.CGColor;
    nowPwdView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:nowPwdView];
    
    UILabel *nowPwdLb = [[UILabel alloc]init];
    nowPwdLb.textAlignment = NSTextAlignmentLeft;
    nowPwdLb.textColor = COLOR_999999;
    nowPwdLb.font = DEF_MyFont(12);
    nowPwdLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, nowPwdView.height);
    nowPwdLb.text = @"旧密码";
    [nowPwdView addSubview:nowPwdLb];
    
    UITextField *nowPwdTF = [[UITextField alloc]init];
    self.nowPwdTF = nowPwdTF;
    nowPwdTF.secureTextEntry = YES;
    nowPwdTF.placeholder = @"请输入旧密码";
    nowPwdTF.textColor = COLOR_333333;
    nowPwdTF.font = DEF_MyFont(12);
    nowPwdTF.frame = CGRectMake(CGRectGetMaxX(nowPwdLb.frame), 0, titleTFW, DEF_RESIZE_UI(44));
    [nowPwdView addSubview:nowPwdTF];
    
    //新密码
    UIView *newPwdView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(nowPwdView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44))];
    newPwdView.layer.borderWidth = 1;
    newPwdView.layer.borderColor = COLOR_cccccc.CGColor;
    newPwdView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:newPwdView];
    
    UILabel *newPwdLb = [[UILabel alloc]init];
    newPwdLb.textAlignment = NSTextAlignmentLeft;
    newPwdLb.textColor = COLOR_999999;
    newPwdLb.font = DEF_MyFont(12);
    newPwdLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, nowPwdView.height);
    newPwdLb.text = @"新密码";
    [newPwdView addSubview:newPwdLb];
    
    UITextField *newPwdTF = [[UITextField alloc]init];
    self.newpwdTF = newPwdTF;
    newPwdTF.placeholder = @"新密码";
    newPwdTF.secureTextEntry = YES;
    newPwdTF.textColor = COLOR_333333;
    newPwdTF.font = DEF_MyFont(12);
    newPwdTF.frame = CGRectMake(CGRectGetMaxX(newPwdLb.frame), 0,titleTFW, DEF_RESIZE_UI(44));
    [newPwdView addSubview:newPwdTF];
    
    //确认新密码
    UIView *affPwdView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(newPwdView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44))];
    affPwdView.layer.borderColor = COLOR_cccccc.CGColor;
    affPwdView.layer.borderWidth = 1;
    affPwdView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:affPwdView];
    
    UILabel *affPwdLb = [[UILabel alloc]init];
    affPwdLb.textAlignment = NSTextAlignmentLeft;
    affPwdLb.textColor = COLOR_999999;
    affPwdLb.font = DEF_MyFont(12);
    affPwdLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, nowPwdView.height);
    affPwdLb.text = @"确认密码";
    [affPwdView addSubview:affPwdLb];
    
    UITextField *affPwdTF = [[UITextField alloc]init];
    self.affPwdTF = affPwdTF;
    affPwdTF.placeholder = @"请确认新密码";
    affPwdTF.secureTextEntry = YES;
    affPwdTF.textColor = COLOR_999999;
    affPwdTF.font = DEF_MyFont(12);
    affPwdTF.frame = CGRectMake(CGRectGetMaxX(newPwdLb.frame), 0, titleTFW, DEF_RESIZE_UI(44));
    [affPwdView addSubview:affPwdTF];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
    submitBtn.backgroundColor = COLOR_ff6060;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = DEF_MyFont(16);
    submitBtn.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(94)-DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44));
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:submitBtn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
