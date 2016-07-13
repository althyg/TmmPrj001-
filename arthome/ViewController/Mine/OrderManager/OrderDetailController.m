//
//  OrderDetailController.m
//  arthome
//
//  Created by 海修杰 on 16/4/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailHeadView.h"
#import "ArtWorksViewController.h"

@interface OrderDetailController ()<UIAlertViewDelegate>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) OrderDetailHeadView * headView ;

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,strong) UIImageView * workImgView ;

@property (nonatomic,strong) UILabel * workNameLb ;

@property (nonatomic,strong) UILabel * workIntroLb ;

@property (nonatomic,strong) UILabel * workPriceLb ;

@property (nonatomic,copy) NSString  * artId ;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    NSDictionary * dic = @{
                           @"orderId" : self.orderId,
                           @"imgsize" : @"150x150"
                           };
    [self mineOrderDetailHttpRequestWithDictionary:dic];
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
 *  订单详情网络请求
 */
-(void) mineOrderDetailHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineOrderDetailWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            self.headView.receiverName = result[@"receiverName"];
            self.headView.receiverPhone = result[@"receiverPhone"];
            self.headView.receiverAddress = result[@"receiverAddress"];
            self.headView.orderNum = result[@"orderNum"];
            self.headView.orderDate = result[@"orderDate"];
            self.headView.orderType = result[@"orderType"];
            self.headView.orderPrice = result[@"orderPrice"];
            [self.workImgView sd_setImageWithURL:result[@"artImgUrl"] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
            self.workNameLb.text = result[@"artName"];
            self.workIntroLb.text = result[@"artInfo"];
            self.workPriceLb.text = result[@"artPrice"];
            self.artId = result[@"artId"];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

-(void)artBtnClick{
    ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
    workVc.artId = self.artId;
    [self.navigationController pushViewController:workVc animated:YES];
}

-(void)initUI{
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithTitle:@"联系客服" target:self action:@selector(linkBtnClick)];
    //mainScr
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    self.mainScr = mainScr;
    mainScr.bounces = YES ;
    mainScr.backgroundColor = COLOR_f7f7f7;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    //headView
    OrderDetailHeadView *headView = [[OrderDetailHeadView alloc]init];
    [mainScr addSubview:headView];
    self.headView = headView;

    UIView * bgView = [[UIView alloc]init];
    [mainScr addSubview:bgView];
    bgView.frame = CGRectMake(0, CGRectGetMaxY(headView.frame), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(95));
    UITapGestureRecognizer *artTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(artBtnClick)];
    [bgView addGestureRecognizer:artTap];
    
    //添加作品图片
    UIImageView *workImgView = [[UIImageView alloc]init];
    [bgView addSubview:workImgView];
    self.workImgView = workImgView;
    workImgView.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(75), DEF_RESIZE_UI(75));
    
    //作品名称
    UILabel *workNameLb = [[UILabel alloc]init];
    [bgView addSubview:workNameLb];
    self.workNameLb = workNameLb;
    workNameLb.font = DEF_MyFont(14);
    workNameLb.textColor = COLOR_333333;
    workNameLb.textAlignment = NSTextAlignmentLeft;
    workNameLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y, DEF_RESIZE_UI(80), DEF_RESIZE_UI(16));
    
    //作品介绍
    UILabel *workIntroLb = [[UILabel alloc]init];
    workIntroLb.numberOfLines = 0;
    [bgView addSubview:workIntroLb];
    self.workIntroLb = workIntroLb;
    workIntroLb.font = DEF_MyFont(12);
    workIntroLb.textColor = COLOR_cccccc;
    workIntroLb.textAlignment = NSTextAlignmentLeft;
    workIntroLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y+DEF_RESIZE_UI(15), DEF_DEVICE_WIDTH-CGRectGetMaxX(workImgView.frame)-DEF_RESIZE_UI(50), DEF_RESIZE_UI(40));
    
    //作品价格
    UILabel *workPriceLb = [[UILabel alloc]init];
    [bgView addSubview:workPriceLb];
    self.workPriceLb = workPriceLb;
    workPriceLb.font = DEF_MyFont(14);
    workPriceLb.textColor = COLOR_ff6060;
    workPriceLb.textAlignment = NSTextAlignmentLeft;
    workPriceLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), CGRectGetMaxY(workIntroLb.frame), DEF_DEVICE_WIDTH-CGRectGetMaxX(workImgView.frame), DEF_RESIZE_UI(14));
    
    //分割线
    UIView *partLine = [[UIView alloc]init];
    partLine.backgroundColor = COLOR_f2f2f2;
    partLine.frame = CGRectMake(0, DEF_RESIZE_UI(95), DEF_DEVICE_WIDTH, 1);
    [bgView addSubview:partLine];
    
    //arrow
    UIImageView *arrowImgView = [[UIImageView alloc]init];
    [bgView addSubview:arrowImgView];
    arrowImgView.contentMode = UIViewContentModeCenter;
    arrowImgView.image = DEF_IMAGENAME(@"mine_arrow_right");
    arrowImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(30), 0, DEF_RESIZE_UI(7),DEF_RESIZE_UI(95));
    
}



@end
