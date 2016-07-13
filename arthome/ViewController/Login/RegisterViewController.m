//
//  RegisterViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/15.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetCodeButton.h"
#import "UserRegisterProController.h"
#import "LoginViewController.h"

@interface RegisterViewController()

@property (nonatomic,strong) UIButton * registerBtn ;

@property (nonatomic,strong) UITextField * phoneLbTF ;

@property (nonatomic,strong) UITextField * certiTF ;

@property (nonatomic,strong) UITextField * nickNameTF ;

@property (nonatomic,strong) UITextField * pwdTF ;

@property (nonatomic,strong) UITextField * pwdSureTF ;

@property (nonatomic,strong) GetCodeButton * getBtn ;

@end

@implementation RegisterViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.phoneLbTF becomeFirstResponder];
}

#pragma mark - 获取验证码按钮的点击

-(void)getBtnClick:(GetCodeButton *) getBtn{
    if ([ATUtility validateMobile:self.phoneLbTF.text]) {
        NSDictionary * dic = @{
                               @"type" : @"0",
                               @"phone" : self.phoneLbTF.text
                               };
        [self mineGetAuchCodeHttpRequestWithDictionary:dic];
    }
    else{
        [ATUtility showTipMessage:WRONGPHONENUMBER];
    }
    
}

#pragma mark - 注册按钮的点击

-(void)registerBtnClick{
    if (self.certiTF.text.length&&self.phoneLbTF.text.length&&self.pwdTF.text.length&&self.pwdSureTF.text.length) {
        if ([self.pwdTF.text isEqualToString:self.pwdSureTF.text]) {
            NSString * authCode = [ATUtility securePassWord:self.certiTF.text];
            NSString * newPwd = [ATUtility securePassWord:self.pwdTF.text];
            NSString * surePwd = [ATUtility securePassWord:self.pwdSureTF.text];
            NSDictionary * dic = @{
                                   @"phone" : self.phoneLbTF.text,
                                   @"authCode" : authCode,
                                   @"nickName" : self.nickNameTF.text,
                                   @"newPwd" : newPwd,
                                   @"surePwd" : surePwd
                                   };
            [self mineRegisterHttpRequestWithDictionary:dic];
        }
        else{
            [ATUtility showTipMessage:@"密码不一致"];
        }
    }
    else{
        [ATUtility showTipMessage:WRONGADDRESSTIP];
    }
}

/**
 * 注册网络请求
 */
-(void)mineRegisterHttpRequestWithDictionary:(NSDictionary *)dic{
    if ([ATUtility isConnectionAvailable]) {
        [ATUtility showMBProgress:self.view];
        [RequestManager mineRegisterWithParametersDic:dic success:^(NSDictionary *result) {
            [ATUtility hideMBProgress:self.view];
            [ATUtility showTipMessage:result[@"message"]];
            if (200==[result[@"code"] integerValue]){
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failture:^(id result) {
            [ATUtility hideMBProgress:self.view];
        }];
    }
    else{
        [ATUtility showTipMessage:WRONGCONNECTION];
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
                [self.certiTF becomeFirstResponder];
                [self.getBtn start];
            }
        } failture:^(id result) {
            [ATUtility hideMBProgress:self.view];
        }];
    }
    else{
        [ATUtility showTipMessage:WRONGCONNECTION];
    }
}

-(void)agreeBtnClick:(UIButton *) btn{
    btn.selected ? (btn.selected = NO) : (btn.selected = YES);
    if (btn.selected) {
        self.registerBtn.enabled = YES;
    }
    else{
        self.registerBtn.enabled = NO;
    }
}

-(void)protocolBtnClick{
    UserRegisterProController *proVc = [[UserRegisterProController alloc]init];
    [self.navigationController pushViewController:proVc animated:YES];
}

//初始化UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64)];
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, DEF_DEVICE_HEIGHT-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    //添加头部图像
    CGFloat padding = DEF_RESIZE_UI(10);
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(100))];
    [mainScr addSubview:headView];
    UIImageView *headImgView = [[UIImageView alloc]init];
    headImgView.image = DEF_IMAGENAME(@"login_header_image");
    headImgView.size = CGSizeMake(DEF_RESIZE_UI(152), DEF_RESIZE_UI(49));
    headImgView.center = CGPointMake(DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(50));
    [headView addSubview:headImgView];
    //手机号
    UITextField *phoneLbTF = [[UITextField alloc]init];
    self.phoneLbTF = phoneLbTF;
    phoneLbTF.textColor =COLOR_666666;
    phoneLbTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneLbTF.font = DEF_MyFont(13);
    phoneLbTF.placeholder = @"  手机号";
    phoneLbTF.frame = CGRectMake(padding, CGRectGetMaxY(headView.frame), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(42));
    phoneLbTF.layer.borderColor = COLOR_e4e4e4.CGColor;
    phoneLbTF.layer.borderWidth = 1;
    [mainScr addSubview:phoneLbTF];
    //验证码TF
    UITextField *certiTF = [[UITextField alloc]init];
    self.certiTF = certiTF;
    certiTF.placeholder = @"  验证码";
    certiTF.keyboardType = UIKeyboardTypeNumberPad;
    certiTF.layer.borderColor = COLOR_e4e4e4.CGColor;
    certiTF.layer.borderWidth = 1;
    certiTF.textColor =COLOR_666666;
    certiTF.secureTextEntry = YES;
    certiTF.font = DEF_MyFont(13);
    certiTF.frame = CGRectMake(padding, CGRectGetMaxY(phoneLbTF.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(42));
    [mainScr addSubview:certiTF];
    //  获取验证码按钮
    GetCodeButton *getBtn = [[GetCodeButton alloc]init];
    self.getBtn = getBtn;
    [getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    getBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(111), certiTF.y+DEF_RESIZE_UI(1), DEF_RESIZE_UI(100), DEF_RESIZE_UI(40));
    __weak GetCodeButton *getSelf = getBtn;
    getBtn.finish = ^{
        getSelf.backgroundColor = COLOR_ffffff;
    };
    [mainScr addSubview:getBtn];
    //vertical line
    UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(getBtn.x, getBtn.y+DEF_RESIZE_UI(7), 1, DEF_RESIZE_UI(28))];
    verticalLine.backgroundColor = COLOR_e4e4e4;
    [mainScr addSubview:verticalLine];
    //设置密码
    UITextField *pwdTF = [[UITextField alloc]init];
    self.pwdTF = certiTF;
    pwdTF.placeholder = @"  设置密码";
    pwdTF.keyboardType = UIKeyboardTypeDefault;
    pwdTF.layer.borderColor = COLOR_e4e4e4.CGColor;
    pwdTF.layer.borderWidth = 1;
    pwdTF.textColor =COLOR_666666;
    pwdTF.secureTextEntry = YES;
    pwdTF.font = DEF_MyFont(13);
    pwdTF.frame = CGRectMake(padding, CGRectGetMaxY(certiTF.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(42));
    [mainScr addSubview:pwdTF];
    //确认密码
    UITextField *pwdSureTF = [[UITextField alloc]init];
    self.pwdSureTF = certiTF;
    pwdSureTF.placeholder = @"  确认密码";
    pwdSureTF.layer.borderColor = COLOR_e4e4e4.CGColor;
    pwdSureTF.layer.borderWidth = 1;
    pwdSureTF.textColor =COLOR_666666;
    pwdSureTF.secureTextEntry = YES;
    pwdSureTF.font = DEF_MyFont(13);
    pwdSureTF.frame = CGRectMake(padding, CGRectGetMaxY(pwdTF.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(42));
    [mainScr addSubview:pwdSureTF];
    //注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn = registerBtn;
    UIImage * redImg = [ATUtility imageWithColor:COLOR_da1025];
    UIImage * grayImg = [ATUtility imageWithColor:COLOR_e4e4e4];
    [registerBtn setBackgroundImage:redImg forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:grayImg forState:UIControlStateDisabled];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    registerBtn.titleLabel.font = DEF_MyFont(16);
    registerBtn.frame = CGRectMake(padding,CGRectGetMaxY(pwdSureTF.frame)+DEF_RESIZE_UI(40) , DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(44));
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:registerBtn];
    //同意的勾选
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeBtn setImage:DEF_IMAGENAME(@"mine_sex_unselected") forState:UIControlStateNormal];
    [agreeBtn setImage:DEF_IMAGENAME(@"mine_sex_selected") forState:UIControlStateSelected];
    agreeBtn.frame = CGRectMake(padding, CGRectGetMaxY(registerBtn.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(16), DEF_RESIZE_UI(16));
    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:agreeBtn];
    //用户协议button
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocolBtn setTitle:@"88艺术网用户服务协议" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    protocolBtn.titleLabel.font = DEF_MyFont(12);
    protocolBtn.frame = CGRectMake(CGRectGetMaxX(agreeBtn.frame), agreeBtn.y, DEF_RESIZE_UI(140), DEF_RESIZE_UI(16));
    [protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:protocolBtn];
    agreeBtn.selected = YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
