//
//  ArtistDetailViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/29.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "ArtistStudioViewController.h"
#import "LoginViewController.h"
#import <UMSocial.h>

@interface ArtistDetailViewController ()

@property (nonatomic,strong) ThirdShareTool * shareTool ;

@property (nonatomic,strong) UIButton * atteBtn ;

@property (nonatomic,strong) UILabel * studioLb ;

@property (nonatomic,strong) UILabel * workNumLb ;

@property (nonatomic,strong) UILabel * fansNumLb ;

@property (nonatomic,strong) UILabel * focuNumLb ;

@property (nonatomic,strong) UILabel * likeNumLb ;

@property (nonatomic,strong) UIView * coverView ;

@end

@implementation ArtistDetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
    if (![userInfo.isArtistTip integerValue]) {
        [self initCover];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers lastObject] != self) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    NSDictionary *dic = @{
                         @"artistId" :self.artistId
                          };
    [self artistChamberHttpRequestWithDictionary:dic];
}
#pragma mark - 返回按钮的点击
-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 关注按钮的点击
-(void)atteBtnClick:(UIButton *)btn{
     if ([ATUserInfo shareUserInfo].appToken.length) {
         NSDictionary * dic = @{
                                @"artistId" : self.artistId
                                };
         [self artistFocusHttpRequestWithDictionary:dic];
     }
     else{
         LoginViewController *logVc = [[LoginViewController alloc]init];
         ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
         KEYWINDOW.rootViewController = nav;

     }
}

#pragma mark - 分享按钮的点击
-(void)shareBtnClick{
    if ([ATUserInfo shareUserInfo].appToken) {
        ThirdShareTool * shareTool = [[ThirdShareTool alloc]initWithContent:nil];
        self.shareTool = shareTool;
        [shareTool handleBlock:^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"人有才还不能叫艺术家，让艺术返璞归真才是真艺术家！来这里寻找心中的他吧！http://www.88art.com" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                            NSLog(@"分享成功！");
                        }
                    }];
                    [self.shareTool removeFromWindow];
                }
                    break;
                case 1:
                {
                    //微信好友
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"人有才还不能叫艺术家，让艺术返璞归真才是真艺术家！来这里寻找心中的他吧！http://www.88art.com" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                        if (response.responseCode == UMSResponseCodeSuccess) {
                            NSLog(@"分享成功！");
                        }
                    }];
                    [self.shareTool removeFromWindow];
                }
                    break;
                case 2:
                {
                    //朋友圈
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"人有才还不能叫艺术家，让艺术返璞归真才是真艺术家！来这里寻找心中的他吧！http://www.88art.com" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                        if (response.responseCode == UMSResponseCodeSuccess) {
                            NSLog(@"分享成功！");
                        }
                    }];
                    [self.shareTool removeFromWindow];
                }
                    break;
                case 3:
                {
                    //QQ
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"人有才还不能叫艺术家，让艺术返璞归真才是真艺术家！来这里寻找心中的他吧！http://www.88art.com" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                        if (response.responseCode == UMSResponseCodeSuccess) {
                            NSLog(@"分享成功！");
                        }
                    }];
                    [self.shareTool removeFromWindow];
                }
                    break;
                default:
                    break;
            }
        }];
        self.shareTool = shareTool;

    }
    else{
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        KEYWINDOW.rootViewController = nav;
    }
   }
/**
 *  艺术家详情页网络请求
 */
-(void)artistChamberHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager artistChamberWithParametersDic:dic success:^(NSDictionary *result) {
        if ([result[@"code"] integerValue] ==200) {
            [ATUtility hideMBProgress:self.view];
            self.studioLb.text = [NSString stringWithFormat:@"%@工作室",result[@"artistName"]];
            CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(24));
            CGSize textSize = [ATUtility sizeOfString:self.studioLb.text withMaxSize:maxSize andFont:self.studioLb.font];
            self.studioLb.frame = (CGRect){DEF_RESIZE_UI(90),DEF_RESIZE_UI(168),textSize};
            self.atteBtn.frame = CGRectMake(CGRectGetMaxX(self.studioLb.frame)+DEF_RESIZE_UI(20), self.studioLb.y, DEF_RESIZE_UI(50), DEF_RESIZE_UI(24));
            self.workNumLb.frame = CGRectMake(DEF_RESIZE_UI(70), CGRectGetMaxY(self.atteBtn.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(70), DEF_RESIZE_UI(250));
            self.fansNumLb.text = result[@"funsNum"];
            self.focuNumLb.text = result[@"focusNum"];
            self.likeNumLb.text = result[@"collNum"];
            self.atteBtn.selected = [result[@"isFocused"] integerValue];
        }
        else{
           [ATUtility showTipMessage:result[@"message"]]; 
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

/**
 *  艺术家关注网络请求
 */
-(void)artistFocusHttpRequestWithDictionary:dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager artistFocusWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200 == [result[@"code"] integerValue]) {
            self.atteBtn.selected = [result[@"isFocused"] integerValue];
            self.fansNumLb.text = result[@"focusedNo"];
          }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

-(void)SwipeUpGesture{
    ArtistStudioViewController * stuVc = [[ArtistStudioViewController alloc]init];
    stuVc.artistId = self.artistId;
    ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:stuVc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
-(void)initCover{
    UIView *coverView = [[UIView alloc]init];
    self.coverView = coverView;
    coverView.frame = [UIScreen mainScreen].bounds;
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.8;
    [KEYWINDOW addSubview:coverView];
    //removeBtn
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBtn setImage:DEF_IMAGENAME(@"artist_detail_remove") forState:UIControlStateNormal];
    removeBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(50)-DEF_RESIZE_UI(20), DEF_RESIZE_UI(20), DEF_RESIZE_UI(50), DEF_RESIZE_UI(50));
    [removeBtn addTarget:self action:@selector(removeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [coverView addSubview:removeBtn];
    //upArrow
    UIImageView *upArrow = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"artist_detail_up")];
    [coverView addSubview:upArrow];
    upArrow.contentMode = UIViewContentModeCenter;
    upArrow.frame = CGRectMake(0, DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(250), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(114));
    //tipLb
    UILabel * tipLb = [[UILabel alloc]init];
    tipLb.text = @"向上滑动查看艺术家作品";
    tipLb.textAlignment = NSTextAlignmentCenter;
    tipLb.font = DEF_MyFont(18);
    tipLb.textColor = COLOR_ffffff;
    tipLb.frame = CGRectMake(0, CGRectGetMaxY(upArrow.frame)+DEF_RESIZE_UI(30), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(20));
    [coverView addSubview:tipLb];
}
-(void)removeBtnClick{
    [self.coverView removeFromSuperview];
    ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
    userInfo.isArtistTip = @"1";
    [userInfo saveAccountToSandBox];
}
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_ffffff;
    
    UIImageView *bgImgView = [[UIImageView alloc]init];
    bgImgView.image = DEF_IMAGENAME(@"artist_bgimg_cham");
    bgImgView.userInteractionEnabled = YES;
    bgImgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT);
    [self.view addSubview:bgImgView];
    //添加向上手势
    UISwipeGestureRecognizer * ImgSwipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeUpGesture)];
    ImgSwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [bgImgView addGestureRecognizer:ImgSwipeUp];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:DEF_IMAGENAME(@"artist_left_white") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(DEF_RESIZE_UI(0), DEF_RESIZE_UI(30), DEF_RESIZE_UI(50), DEF_RESIZE_UI(40));
    [bgImgView addSubview:backBtn];
    //分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:DEF_IMAGENAME(@"artist_share_white") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    CGFloat shareBtnW = DEF_RESIZE_UI(21);
    CGFloat shareBtnH = DEF_RESIZE_UI(24);
    shareBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(15)-shareBtnW, DEF_RESIZE_UI(40), shareBtnW, shareBtnH);
    [bgImgView addSubview:shareBtn];
    
    //工作室
    UILabel *studioLb = [[UILabel alloc]init];
    self.studioLb = studioLb;
    studioLb.textAlignment = NSTextAlignmentCenter;
    studioLb.font = DEF_MyFont(20);
    studioLb.textColor = COLOR_ffffff;
    [bgImgView addSubview:studioLb];
    //关注按钮
    UIButton *atteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.atteBtn = atteBtn;
    atteBtn.titleLabel.font = DEF_MyFont(12);
    atteBtn.layer.borderWidth = 1;
    atteBtn.layer.borderColor = COLOR_ffffff.CGColor;
    [atteBtn setTitle:@"关注" forState:UIControlStateNormal];
    [atteBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [atteBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    [atteBtn setTitleColor:COLOR_333333 forState:UIControlStateSelected];
    UIImage *attenBackImg = [ATUtility imageWithColor:COLOR_ffffff];
    [atteBtn setBackgroundImage:attenBackImg forState:UIControlStateSelected];
    [atteBtn addTarget:self action:@selector(atteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:atteBtn];
    //介绍
    UILabel *workNumLb = [[UILabel alloc]init];
    self.workNumLb = workNumLb;
    workNumLb.numberOfLines = 0;
    workNumLb.text = @"金正恩（朝鲜语：김정은，1983年1月8日－），现任朝鲜最高领导人，朝鲜民主主义人民共和国元帅，朝鲜劳动党委员长[1]  、朝鲜劳动党中央军事委员会委员长，朝鲜民主主义人民共和国国防委员会第一委员长，朝鲜人民军最高司令官。金正恩是朝鲜第二代最高领导人金正日幼子、第一代最高领导人金日成之孙。2012年7月25日朝鲜官方媒体第一次在正式报道中提及了金正恩的夫人李雪主。金正恩和李雪主已于2010年产下一女。2014年9月25日晚，朝鲜中央电视台的一则消息中提及朝鲜最高领导人金正恩的身体状况，承认他身体不适，但没有具体说明。朝方曾于9月26日承认金正恩身体不适。[2]  10月14日早晨，金正恩在9月3日观看牡丹峰乐团新作音乐会之后，首次公开露面，期间他缺席了一系列重要活动。[3]  10月19日金正恩偕李雪主看望朝鲜亚运会代表团。[4]  11月1日，朝鲜平壤，朝鲜最高领导人金正恩拄拐视察平壤顺安国际机场收盘阶段工程。[5]  11月11日，金正恩视察种植园区时蹲下检查树苗种植情况，显示腿疾已无大碍[6]  。2015年1月1日，朝鲜最高领导人金正恩发表2015年新年贺词，向朝鲜全体军民致以新年问候，表示将缓和朝鲜半岛紧张局势。[7] ";
    workNumLb.textAlignment = NSTextAlignmentCenter;
    workNumLb.font = DEF_MyFont(12);
    workNumLb.textColor = COLOR_ffffff;
    [bgImgView addSubview:workNumLb];
    
    //向上指示图
//    UIImageView *upTipImg = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"artist_up_nextpage")];
//    upTipImg.size = CGSizeMake(DEF_RESIZE_UI(50), DEF_RESIZE_UI(25));
//    upTipImg.center = CGPointMake(DEF_DEVICE_WIDTH*0.5, DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(25)*0.5);
//    [bgImgView addSubview:upTipImg];
    
    //两个分割线
    UIView * splitLine1 = [[UIView alloc]init];
    splitLine1.backgroundColor = COLOR_ffffff;
    splitLine1.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5, DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(125), 0.5, DEF_RESIZE_UI(40));
    [bgImgView addSubview:splitLine1];
    //关注Tip IMG
    UIImageView * tipImg1 = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"artist_eye_white")];
    tipImg1.frame = CGRectMake(0, CGRectGetMinY(splitLine1.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(14));
    tipImg1.contentMode = UIViewContentModeCenter;
    [bgImgView addSubview:tipImg1];
    //关注数
    UILabel *focuNumLb = [[UILabel alloc]init];
    self.focuNumLb = focuNumLb;
    focuNumLb.font = DEF_MyFont(12);
    focuNumLb.textColor = COLOR_ffffff;
    focuNumLb.textAlignment = NSTextAlignmentCenter;
    focuNumLb.frame = CGRectMake(0, CGRectGetMaxY(tipImg1.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(12));
    [bgImgView addSubview:focuNumLb];
    
    //粉丝Tip IMG
    UIImageView * tipImg2 = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"artist_fans_white")];
    tipImg2.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5, CGRectGetMinY(splitLine1.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(14));
    tipImg2.contentMode = UIViewContentModeCenter;
    [bgImgView addSubview:tipImg2];
    //粉丝数
    UILabel *fansNumLb = [[UILabel alloc]init];
    self.fansNumLb = fansNumLb;
    fansNumLb.font = DEF_MyFont(12);
    fansNumLb.textColor = COLOR_ffffff;
    fansNumLb.textAlignment = NSTextAlignmentCenter;
    fansNumLb.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5, CGRectGetMaxY(tipImg1.frame)+DEF_RESIZE_UI(5), DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(12));
    [bgImgView addSubview:fansNumLb];
    
}

#pragma mark-友盟分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
@end
