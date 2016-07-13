//
//  RefundDetailController.m
//  arthome
//
//  Created by 海修杰 on 16/6/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "RefundDetailController.h"
#import "RefundViewController.h"

@interface RefundDetailController ()<UIAlertViewDelegate>

@property (nonatomic,strong) UIView * bgView ;

@property (nonatomic,strong) UIScrollView * mainScr ;

@end

@implementation RefundDetailController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    NSDictionary * dic = @{
                           @"orderId" :self.orderId
                           };
    [self mineRefundDetailHttpRequestWithDictionary:dic];
    }

-(void)changeBtnClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
    DEF_MyAppDelegate.tabBarController.selectedIndex = 0;
}

-(void)linkBtnClick{
    NSString * mesage = [NSString stringWithFormat:@"拨打电话%@",SERVICESPHONE];
    UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:nil message:mesage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (1==buttonIndex) {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",SERVICESPHONE]]];
    }
    
}
/**
 *  网络请求
 */
-(void)mineRefundDetailHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineRefundDetailWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            NSString *type = [NSString string];
            NSString *reason = [NSString string];
            if ([result[@"type"] integerValue] == 0) {
                type = @"我要退款";
            }
            else{
                type = @"我要退货";
            }
            if ([result[@"reason"] integerValue]==0) {
                reason = @"仿品";
            }
            else if([result[@"reason"] integerValue]==1){
               reason = @"有破损";
            }
            else{
                reason = @"物非所述";
            }
            NSArray *tipsArr= @[result[@"sellerName"],type,reason,result[@"number"],result[@"time"]];
            for (NSInteger index = 0; index<5; index++) {
                UILabel * tipLb = [[UILabel alloc]init];
                tipLb.font = DEF_MyFont(13);
                tipLb.textColor = COLOR_999999;
                tipLb.textAlignment  = NSTextAlignmentLeft;
                tipLb.text = tipsArr[index];
                tipLb.frame = CGRectMake(DEF_RESIZE_UI(110),CGRectGetMaxY(self.bgView.frame)+DEF_RESIZE_UI(20)+index*(DEF_RESIZE_UI(13)+DEF_RESIZE_UI(15)), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(110), DEF_RESIZE_UI(13));
                [self.mainScr addSubview:tipLb];
            }
            UILabel *explainLb = [[UILabel alloc]init];
            [self.mainScr addSubview:explainLb];
            explainLb.numberOfLines = 0;
            explainLb.textColor = COLOR_999999;
            explainLb.textAlignment = NSTextAlignmentLeft;
            explainLb.font = DEF_MyFont(13);
            explainLb.text = result[@"explain"];
            CGSize maxSize = CGSizeMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(130), CGFLOAT_MAX);
            CGSize textSize = [ATUtility sizeOfString:explainLb.text withMaxSize:maxSize andFont:explainLb.font];
            explainLb.frame = (CGRect){DEF_RESIZE_UI(110),CGRectGetMaxY(self.bgView.frame)+DEF_RESIZE_UI(20)+5*(DEF_RESIZE_UI(13)+DEF_RESIZE_UI(15)),textSize};
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

-(void)initUI{
    self.navigationItem.title = @"退款详情";
    self.view.backgroundColor = [UIColor whiteColor];
    //mainScr
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    self.mainScr = mainScr;
    mainScr.bounces = YES ;
    mainScr.backgroundColor = COLOR_f7f7f7;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    UIView *bgView = [[UIView alloc]init];
    self.bgView = bgView;
    bgView.backgroundColor = COLOR_ffffff;
    [mainScr addSubview:bgView];
    //tip img
    UIImageView * markImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_refunddetail_mark")];
    markImgView.frame = CGRectMake(DEF_RESIZE_UI(20), DEF_RESIZE_UI(20), DEF_RESIZE_UI(20), DEF_RESIZE_UI(20));
    [bgView addSubview:markImgView];
    //tip lb
    UILabel *tipLb = [[UILabel alloc]init];
    tipLb.text = @"等待客服确认";
    tipLb.textColor = COLOR_6eb9ff;
    tipLb.font = DEF_MyFont(16);
    tipLb.textAlignment = NSTextAlignmentLeft;
    tipLb.frame = CGRectMake(CGRectGetMaxX(markImgView.frame)+DEF_RESIZE_UI(8), DEF_RESIZE_UI(20), DEF_RESIZE_UI(100), DEF_RESIZE_UI(20));
    [bgView addSubview:tipLb];
    //btn1
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [changeBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    changeBtn.layer.borderColor = COLOR_cccccc.CGColor;
    changeBtn.layer.borderWidth = 0.5;
    changeBtn.titleLabel.font = DEF_MyFont(14);
    changeBtn.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(tipLb.frame)+DEF_RESIZE_UI(10), (DEF_DEVICE_WIDTH-DEF_RESIZE_UI(55))*0.5, DEF_RESIZE_UI(37));
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:changeBtn];
    //btn2
    UIButton *linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [linkBtn setImage:DEF_IMAGENAME(@"mine_refund_phone") forState:UIControlStateNormal];
    [linkBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    linkBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [linkBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    linkBtn.layer.borderColor = COLOR_cccccc.CGColor;
    linkBtn.layer.borderWidth = 0.5;
    linkBtn.titleLabel.font = DEF_MyFont(14);
    linkBtn.frame = CGRectMake(CGRectGetMaxX(changeBtn.frame)+DEF_RESIZE_UI(15), CGRectGetMaxY(tipLb.frame)+DEF_RESIZE_UI(10), (DEF_DEVICE_WIDTH-DEF_RESIZE_UI(55))*0.5, DEF_RESIZE_UI(37));
    [linkBtn addTarget:self action:@selector(linkBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:linkBtn];
      bgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, CGRectGetMaxY(linkBtn.frame)+DEF_RESIZE_UI(10));
    
    NSArray * tipArr = @[@"卖家名称",@"申请类型",@"退款原因",@"退款编号",@"申请时间",@"退款说明"];
    for (NSInteger index = 0; index<6; index++) {
        UILabel * tipLb = [[UILabel alloc]init];
        tipLb.font = DEF_MyFont(13);
        tipLb.textColor = COLOR_cccccc;
        tipLb.textAlignment  = NSTextAlignmentLeft;
        tipLb.text = tipArr[index];
        tipLb.frame = CGRectMake(DEF_RESIZE_UI(20),CGRectGetMaxY(bgView.frame)+DEF_RESIZE_UI(20)+index*(DEF_RESIZE_UI(13)+DEF_RESIZE_UI(15)), DEF_RESIZE_UI(90), DEF_RESIZE_UI(13));
        [mainScr addSubview:tipLb];
    }
}

@end
