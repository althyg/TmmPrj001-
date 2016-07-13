//
//  LoginViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ResettingViewController.h"
#import "ATTabBarController.h"


//友盟第三方
#import "UMSocial.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import "WeiboSDK.h"

@interface LoginViewController()

@property (nonatomic,strong) UITextField * accountTF ;

@property (nonatomic,strong) UITextField * pwdTF ;

@end

@implementation LoginViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - 登录按钮点击事件
-(void)loginBtnClick{
    if (self.pwdTF.text.length&&self.accountTF.text.length) {
        NSString * password = [ATUtility securePassWord:self.pwdTF.text];
        NSDictionary * dic = @{
                                @"account" : self.accountTF.text,
                                @"password" : password,
                                @"headsize" : @"160x160"
                                   };
        [self mineLoginHttpRequestWithDictionary:dic];
    }
    else{
        [ATUtility showTipMessage:WRONGINFOMATION];
    }
}

/**
 * 登录网络请求
 */
-(void)mineLoginHttpRequestWithDictionary:(NSDictionary *)dic{
    if ([ATUtility isConnectionAvailable]) {
        [ATUtility showMBProgress:self.view];
        [RequestManager mineLoginWithParametersDic:dic success:^(NSDictionary *result) {
            [ATUtility hideMBProgress:self.view];
            if (200==[result[@"code"] integerValue]){
                ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
                [userInfo userInformationFormLoginData:result];
                [self removeBtnClick];
            }
            else{
             [ATUtility showTipMessage:result[@"message"]];
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
 *  第三登录完请求接口
 */
-(void)mineThirdLoginHttpRequestWithDictionary:(NSDictionary *)dic{
    if ([ATUtility isConnectionAvailable]) {
        [ATUtility showMBProgress:self.view];
        [RequestManager mineThirdLoginWithParametersDic:dic success:^(NSDictionary *result) {
            [ATUtility hideMBProgress:self.view];
            if (200==[result[@"code"] integerValue]){
                ATUserInfo * userInfo = [ATUserInfo shareUserInfo];
                [userInfo userInformationFormLoginData:result];
                [self removeBtnClick];
            }
            else{
                [ATUtility showTipMessage:result[@"message"]];
            }
        } failture:^(id result) {
            [ATUtility hideMBProgress:self.view];
        }];
    }
    else{
        [ATUtility showTipMessage:WRONGCONNECTION];
    }
}

//微信登录
-(void)weChatBtnClick{
    //判断微信客户端是否安装
    if ([WXApi isWXAppInstalled]) {
        NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeWechatSession];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            NSLog(@"login response is %@",response);
            
            //获取微信用户名、uid、token等
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                NSDictionary * dic = @{
                                       @"iconUrl" :snsAccount.iconURL,
                                       @"nickName" :snsAccount.userName,
                                       @"type" : @"2",
                                       @"headsize" : @"160x160",
                                       @"uniqueId" :snsAccount.usid
                                       };
                [self mineThirdLoginHttpRequestWithDictionary:dic];
                
            }
            
        });
    }
    
}
//QQ登录
-(void)qqBtnClick{
    
    //判断qq客户端是否安装
    if ([QQApiInterface isQQInstalled]) {
        NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeMobileQQ];
        
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            NSLog(@"login response is %@",response);
            
            //获取QQ用户名、uid、token等
            if (response.responseCode == UMSResponseCodeSuccess) {
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
                NSDictionary * dic = @{
                                       @"iconUrl" :snsAccount.iconURL,
                                       @"nickName" :snsAccount.userName,
                                       @"type" : @"3",
                                       @"headsize" : @"160x160",
                                       @"uniqueId" :snsAccount.usid
                                       };
               [self mineThirdLoginHttpRequestWithDictionary:dic];
            }
            
        });
    }
    
}
//微博登录
-(void)weiboBtnClick{
    
    //判断sina客户端是否安装
    if ([WeiboSDK isWeiboAppInstalled])
        
    {
        /*新浪登录第三方登录授权*/
        NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeSina];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            NSLog(@"response is %@",response);
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];              
                NSDictionary * dic = @{
                                       @"iconUrl" :snsAccount.iconURL,
                                       @"nickName" :snsAccount.userName,
                                       @"type" : @"4",
                                       @"headsize" : @"160x160",
                                       @"uniqueId" :snsAccount.usid
                                       };
                [self mineThirdLoginHttpRequestWithDictionary:dic];
            }
        });
        
    }
    
}
//返回按钮
-(void)removeBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)regisBtnClick{
    RegisterViewController *regisVc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:regisVc animated:YES];
}
-(void)forgetBtnClick{
    ResettingViewController *resetVc = [[ResettingViewController alloc]init];
    [self.navigationController pushViewController:resetVc animated:YES];
}

//初始化UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtnItemWithNmlImg:@"login_ disappear" hltImg:@"login_ disappear" target:self action:@selector(removeBtnClick)];
    self.navigationItem.title = @"登录";
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64)];
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height+1);
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
    //账号 TF
    UITextField *accountTF = [[UITextField alloc]init];
    self.accountTF = accountTF;
    accountTF.textColor =COLOR_666666;
    accountTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    accountTF.font = DEF_MyFont(13);
    accountTF.placeholder = @"  邮箱/手机号";
    accountTF.frame = CGRectMake(padding, CGRectGetMaxY(headView.frame), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(42));
    accountTF.layer.borderColor = COLOR_e4e4e4.CGColor;
    accountTF.layer.borderWidth = 1;
    [mainScr addSubview:accountTF];
    //密码TF
    UITextField *pwdTF = [[UITextField alloc]init];
    self.pwdTF = pwdTF;
    pwdTF.placeholder = @"  请输入密码";
    pwdTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    pwdTF.layer.borderColor = COLOR_e4e4e4.CGColor;
    pwdTF.layer.borderWidth = 1;
    pwdTF.textColor =COLOR_666666;
    pwdTF.secureTextEntry = YES;
    pwdTF.font = DEF_MyFont(13);
    pwdTF.frame = CGRectMake(padding, CGRectGetMaxY(accountTF.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(42));
    [mainScr addSubview:pwdTF];
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.titleLabel.font = DEF_MyFont(16);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = COLOR_da1025;
    loginBtn.frame = CGRectMake(padding, CGRectGetMaxY(pwdTF.frame)+DEF_RESIZE_UI(140), DEF_DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(44));
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:loginBtn];
    //立即注册
    UIButton *regisBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [regisBtn setTitleColor:COLOR_6eb9ff forState:UIControlStateNormal];
    [regisBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    regisBtn.titleLabel.font = DEF_MyFont(12);
    regisBtn.frame = CGRectMake(padding, CGRectGetMaxY(loginBtn.frame)+DEF_RESIZE_UI(5), DEF_RESIZE_UI(80), DEF_RESIZE_UI(30));
    [regisBtn addTarget:self action:@selector(regisBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:regisBtn];
    //忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = DEF_MyFont(12);
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(80)-padding,CGRectGetMaxY(loginBtn.frame)+DEF_RESIZE_UI(5), DEF_RESIZE_UI(80), DEF_RESIZE_UI(24));
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:forgetBtn];
    
    //分割线imgView
    UIImageView *sepaLineView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"login_third_part")];
    sepaLineView.frame = CGRectMake(0, CGRectGetMaxY(forgetBtn.frame)+DEF_RESIZE_UI(40), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(13));
    [mainScr addSubview:sepaLineView];
    
    //wechat
    UIButton * weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChatBtn setImage:DEF_IMAGENAME(@"login_third_wechat") forState:UIControlStateNormal];
    weChatBtn.size = CGSizeMake(DEF_RESIZE_UI(60), DEF_RESIZE_UI(60));
    weChatBtn.center = CGPointMake(DEF_DEVICE_WIDTH*0.5, CGRectGetMaxY(sepaLineView.frame)+DEF_RESIZE_UI(60));
    [weChatBtn addTarget:self action:@selector(weChatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:weChatBtn];
    //QQ
    UIButton * qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setImage:DEF_IMAGENAME(@"login_third_qq") forState:UIControlStateNormal];
    qqBtn.size = CGSizeMake(DEF_RESIZE_UI(60), DEF_RESIZE_UI(60));
    qqBtn.center = CGPointMake(DEF_DEVICE_WIDTH*0.75+DEF_RESIZE_UI(30), CGRectGetMaxY(sepaLineView.frame)+DEF_RESIZE_UI(60));
    [qqBtn addTarget:self action:@selector(qqBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:qqBtn];
    //weibo
    UIButton * weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboBtn setImage:DEF_IMAGENAME(@"login_third_weibo") forState:UIControlStateNormal];
    weiboBtn.size = CGSizeMake(DEF_RESIZE_UI(60), DEF_RESIZE_UI(60));
    weiboBtn.center = CGPointMake(DEF_DEVICE_WIDTH*0.25-DEF_RESIZE_UI(30), CGRectGetMaxY(sepaLineView.frame)+DEF_RESIZE_UI(60));
    [weiboBtn addTarget:self action:@selector(weiboBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:weiboBtn];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
