//
//  PhoneBindingSecController.m
//  arthome
//
//  Created by 海修杰 on 16/3/19.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "PhoneBindingSecController.h"
#import "GetCodeButton.h"
#import "PhoneBindingThirdController.h"

@interface PhoneBindingSecController ()

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,strong) GetCodeButton * getBtn ;

@property (nonatomic,strong) UITextField * certiTF ;

@end

@implementation PhoneBindingSecController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.certiTF becomeFirstResponder];
}

-(void)getBtnClick:(GetCodeButton *) getBtn{
    NSDictionary *dic = @{
                          @"phone" : self.phoneNum,
                          @"type"  : @"2"
                          };
    [self mineGetAuthCodeHttpRequestWithDictionary:dic];
}
/**
 *  请求验证码网络请求
 */
-(void)mineGetAuthCodeHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineGetAuthCodeWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        [ATUtility showTipMessage:result[@"message"]];
        if ([result[@"code"] integerValue]==200) {
            [self.getBtn start];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
/**
 *  authcode验证网络请求
 */
-(void)mineBindConfirHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager mineBindConfirWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            PhoneBindingThirdController *thiVc = [[PhoneBindingThirdController alloc]init];
            thiVc.phoneNum = self.phoneNum;
            [self.navigationController pushViewController:thiVc animated:YES];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
         [ATUtility hideMBProgress:self.view];
    }];
}

#pragma mark -  下一步按钮的点击

-(void)nextBtnClick{
    if (self.certiTF.text.length) {
        NSString * authCode = [ATUtility securePassWord:self.certiTF.text];
        NSDictionary *dic = @{
                              @"phone" : self.phoneNum,
                              @"authCode": authCode
                              };
        [self mineBindConfirHttpRequestWithDictionary:dic];
    }
    else{
         [ATUtility showTipMessage:WRONGCONNECTION];
    }
}

-(void)initUI{
    self.navigationItem.title = @"绑定手机号";
    self.view.backgroundColor = COLOR_ffffff;
    
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    self.mainScr = mainScr;
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    UILabel *tip1Lb = [[UILabel alloc]init];
    NSString * phoneNum = [ATUtility securePhoneNumber:self.phoneNum];
    tip1Lb.text = [NSString stringWithFormat:@"已发送验证码至:%@",phoneNum];
    tip1Lb.textAlignment = NSTextAlignmentLeft;
    tip1Lb.font = DEF_MyFont(13);
    tip1Lb.textColor = COLOR_333333;
    tip1Lb.frame = CGRectMake(DEF_RESIZE_UI(15), DEF_RESIZE_UI(15), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(15), DEF_RESIZE_UI(15));
    [mainScr addSubview:tip1Lb];
    
    //验证码TF
    UITextField *certiTF = [[UITextField alloc]init];
    self.certiTF = certiTF;
    certiTF.font = DEF_MyFont(13);
    certiTF.placeholder = @"  验证码";
    certiTF.frame = CGRectMake(DEF_RESIZE_UI(15), CGRectGetMaxY(tip1Lb.frame)+DEF_RESIZE_UI(15), tip1Lb.width-DEF_RESIZE_UI(15)-DEF_RESIZE_UI(80), DEF_RESIZE_UI(40));
    certiTF.layer.borderWidth = 0.5;
    certiTF.layer.borderColor = COLOR_cccccc.CGColor;
    [mainScr addSubview:certiTF];
    
    //获取验证码按钮
    GetCodeButton *getBtn = [[GetCodeButton alloc]init];
    self.getBtn = getBtn;
    [getBtn addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    getBtn.frame = CGRectMake(CGRectGetMaxX(certiTF.frame)+DEF_RESIZE_UI(10), certiTF.y, DEF_DEVICE_WIDTH-CGRectGetMaxX(certiTF.frame)-DEF_RESIZE_UI(10)-DEF_RESIZE_UI(15), DEF_RESIZE_UI(40));
    getBtn.backgroundColor = COLOR_ffffff;
    __weak GetCodeButton *getSelf = getBtn;
    getBtn.finish = ^{
        getSelf.backgroundColor = COLOR_ffffff;
    };
    [mainScr addSubview:getBtn];
    //下一步按钮
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLOR_ff6060;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = DEF_MyFont(13);
    nextBtn.frame = CGRectMake(DEF_RESIZE_UI(15), CGRectGetMaxY(certiTF.frame)+DEF_RESIZE_UI(15), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(15), DEF_RESIZE_UI(40));
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:nextBtn];
    //开始获取验证码
    [getBtn start];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
