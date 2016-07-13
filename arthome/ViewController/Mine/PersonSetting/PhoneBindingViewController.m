//
//  PhoneBindingViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "PhoneBindingViewController.h"
#import "PhoneBindingThirdController.h"
#import "GetCodeButton.h"

@interface PhoneBindingViewController()

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,strong) UITextField * phoneTF ;

@property (nonatomic,strong) UITextField * authCodeTF ;

@property (nonatomic,strong) GetCodeButton * getBtn ;

@end

@implementation PhoneBindingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.phoneTF becomeFirstResponder];
}

#pragma mark - 下一步按钮点击

-(void)nextBtnClick{
    PhoneBindingThirdController *thidVc = [[PhoneBindingThirdController alloc]init];
    [self.navigationController pushViewController: thidVc animated:YES];
    if ([ATUtility validateMobile:self.phoneTF.text]) {
        NSDictionary * dic = @{
                               @"phone" : self.phoneTF.text,
                               @"type" : @"2"
                               };
        [self mineGetAuchCodeHttpRequestWithDictionary:dic];
    }
    else{
        [ATUtility showTipMessage:WRONGPHONENUMBER];
    }
}
/**
 *  请求验证码网络请求
 */
-(void)mineGetAuchCodeHttpRequestWithDictionary:(NSDictionary *)dic{
    if ([ATUtility isConnectionAvailable]) {
        [ATUtility showMBProgress:self.view];
        [RequestManager mineGetAuthCodeWithParametersDic:dic success:^(NSDictionary *result) {
            [ATUtility hideMBProgress:self.view];
            [ATUtility showTipMessage:result[@"message"]];
            if ([result[@"code"] integerValue] == 200) {
                PhoneBindingThirdController *thidVc = [[PhoneBindingThirdController alloc]init];
                [self.navigationController pushViewController: thidVc animated:YES];
            }
        } failture:^(id result) {
            [ATUtility hideMBProgress:self.view];
        }];
    }
    else{
         [ATUtility showTipMessage:WRONGCONNECTION];
    }
}

-(void)getBtnClick:(UIButton *)btn{
    
}

-(void)initUI{
    self.navigationItem.title = @"绑定手机号";
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    UILabel *tip1Lb = [[UILabel alloc]init];
    tip1Lb.text = @"绑定手机号交易更安全,查询更便捷";
    tip1Lb.textAlignment = NSTextAlignmentLeft;
    tip1Lb.font = DEF_MyFont(13);
    tip1Lb.textColor = COLOR_cccccc;
    tip1Lb.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(15), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(15));
    [mainScr addSubview:tip1Lb];
    //手机号
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(tip1Lb.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44))];
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = COLOR_cccccc.CGColor;
    phoneView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:phoneView];
    
    UIView *phoneLb = [[UILabel alloc]init];
    phoneLb.frame = CGRectMake(0, 0,DEF_RESIZE_UI(20),phoneView.height);
    [phoneView addSubview:phoneLb];
    
    UITextField *phoneTF = [[UITextField alloc]init];
    self.phoneTF = phoneTF;
    phoneTF.keyboardType = UIKeyboardTypePhonePad;
    phoneTF.secureTextEntry = YES;
    phoneTF.placeholder = @"请输入手机号";
    phoneTF.textColor = COLOR_333333;
    phoneTF.font = DEF_MyFont(16);
    phoneTF.frame = CGRectMake(CGRectGetMaxX(phoneLb.frame), 0, phoneView.width-DEF_RESIZE_UI(20), DEF_RESIZE_UI(44));
    [phoneView addSubview:phoneTF];
    
    //验证码
    UIView *authCodeView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(phoneView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)-DEF_RESIZE_UI(130), DEF_RESIZE_UI(44))];
    authCodeView.layer.borderWidth = 1;
    authCodeView.layer.borderColor = COLOR_cccccc.CGColor;
    authCodeView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:authCodeView];
    
    UIView *authCodeLb = [[UILabel alloc]init];
    authCodeLb.frame = CGRectMake(0, 0,DEF_RESIZE_UI(20),phoneView.height);
    [authCodeView addSubview:authCodeLb];
    
    UITextField *authCodeTF = [[UITextField alloc]init];
    self.authCodeTF = authCodeTF;
    authCodeTF.keyboardType = UIKeyboardTypePhonePad;
    authCodeTF.placeholder = @"验证码";
    authCodeTF.textColor = COLOR_333333;
    authCodeTF.font = DEF_MyFont(16);
    authCodeTF.frame = CGRectMake(CGRectGetMaxX(phoneLb.frame), 0, phoneView.width-DEF_RESIZE_UI(20), DEF_RESIZE_UI(44));
    [authCodeView addSubview:authCodeTF];
    //  获取验证码按钮
    GetCodeButton *getBtn = [[GetCodeButton alloc]init];
    self.getBtn = getBtn;
    getBtn.layer.borderWidth = 1;
    getBtn.layer.borderColor = COLOR_da1025.CGColor;
    [getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    getBtn.frame = CGRectMake(CGRectGetMaxX(authCodeView.frame)+DEF_RESIZE_UI(10), authCodeView.y, DEF_RESIZE_UI(120), DEF_RESIZE_UI(44));
    __weak GetCodeButton *getSelf = getBtn;
    getBtn.finish = ^{
        getSelf.layer.borderWidth = 1;
        getSelf.layer.borderColor = COLOR_da1025.CGColor;
    };
    [mainScr addSubview:getBtn];
    
    //下一步按钮
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"绑定" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR_ff6060;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = DEF_MyFont(16);
    nextBtn.frame = CGRectMake(DEF_RESIZE_UI(10),DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(94)-DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44));
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:nextBtn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
