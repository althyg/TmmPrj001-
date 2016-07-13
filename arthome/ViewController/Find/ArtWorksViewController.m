//
//  ArtWorksViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtWorksViewController.h"
#import "WorkDetailView.h"
#import "FunsView.h"
#import <UMSocial.h>
#import "ArtistView.h"
#import "OrderConfirmViewController.h"
#import "ArtistDetailViewController.h"
#import "LoginViewController.h"
#import "ATImgPreView.h"
#import "NSString+MD5.h"

@interface ArtWorksViewController ()<ArtistViewDelegate>

@property (nonatomic,strong) UIImageView * topImgView ;

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,strong) UIScrollView * scaleScr ;

@property (nonatomic,strong) WorkDetailView * detailView ;

@property (nonatomic,assign) CGFloat imgOriScale;

@property (nonatomic,strong) UIImageView * oriImgView ;

@property (nonatomic,strong) FunsView * funsView ;

@property (nonatomic,strong) ThirdShareTool * shareTool ;

@property (nonatomic,copy) NSString * imgOriUrl;

@property (nonatomic,strong) ArtistView * artistView ;

@property (nonatomic,copy) NSString * artistId;

@property (nonatomic,assign) BOOL likeSucceed ;

@property (nonatomic,strong) ATImgPreView * photoView ;

@property (nonatomic,strong) UMSocialUrlResource *urlResource;

@property (nonatomic,copy) NSString * imgBrefUrl ;

@end

@implementation ArtWorksViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    NSDictionary *dict = @{@"artId" :self.artId,
                           @"avatarSize": @"30x30",
                           @"headSize" :@"70x70",
                           @"artSize" :@"200x200",
                           @"topImgSize": @"750x500"
                           };
    [self findHomePageHttpRequestWithDictionary:dict];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers lastObject] != self) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - 立即购买按钮

-(void)immBtnClick{
    if ([ATUserInfo shareUserInfo].appToken.length) {
        NSDictionary * dic =@{@"artId":self.artId};
        [self findBuyIntoCartWithParametersDic:dic withArtID:self.artId];
    }
    else{
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark - 加入购物车

-(void)shopCartBtnClick{
        if ([ATUserInfo shareUserInfo].appToken.length) {
            NSDictionary * dic =@{@"artId":self.artId};
            [self findPutIntoCartWithParametersDic:dic];
        }
        else{
            LoginViewController *logVc = [[LoginViewController alloc]init];
            ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
            [self presentViewController:nav animated:YES completion:nil];
        }
}

-(void)artistTapGestureClick{
    ArtistDetailViewController *detailVc = [[ArtistDetailViewController alloc]init];
    detailVc.artistId = self.artistId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

/**
 *  艺术品详情网络请求
 */
-(void)findHomePageHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager findArtdetailWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200==[result[@"code"] integerValue]){
            [self.topImgView sd_setImageWithURL:result[@"imgBrefUrl"] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
            self.imgBrefUrl = result[@"imgBrefUrl"];
            self.detailView.artName = result[@"artName"];
            self.detailView.artInfo = result[@"artInfo"];
            self.detailView.artType = result[@"artType"];
            self.detailView.artPrice = result[@"artPrice"];
            self.detailView.isPacked = result[@"isPacked"];
            self.detailView.isSealed = result[@"isSealed"];
            self.imgOriScale = [result[@"imgOriScale"] floatValue];
            self.imgOriUrl = result[@"imgOriUrl"];
            self.detailView.artIntro = result[@"artIntro"];
            //粉丝模块
            FunsView * funsView = [[FunsView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(50)) ];
            funsView.blockLike = ^{
                if ([ATUserInfo shareUserInfo].appToken.length) {
                    NSDictionary * dic = @{
                                           @"artiId" : self.artId
                                           };
                    [self findArtLikeHttpRequestWithDictionary:dic];
                }
                else{
                    LoginViewController *logVc = [[LoginViewController alloc]init];
                    ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
                    [self presentViewController:nav animated:YES completion:nil];
                }
            };
            self.funsView = funsView;
            [self.mainScr addSubview:funsView];
            self.funsView.imgArr = result[@"funs"];
            self.funsView.isLike = result[@"isLike"];
            self.funsView.likeNo = result[@"likeNo"];
            if ([result[@"artistExit"] integerValue] == 1) {
                //bgView
                UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.funsView.frame)+DEF_RESIZE_UI(10),  DEF_DEVICE_WIDTH, DEF_RESIZE_UI(180))];
                bgView.backgroundColor = [UIColor whiteColor];
                [self.mainScr addSubview:bgView];
                //艺术家模块
                ArtistView *artistView = [[ArtistView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10), 0,  DEF_DEVICE_WIDTH-DEF_RESIZE_UI(10)*2, DEF_RESIZE_UI(180))];
                artistView.delegate = self;
                self.artistView = artistView;
                UITapGestureRecognizer *artistTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(artistTapGestureClick)];
                artistView.userInteractionEnabled = YES;
                [artistView addGestureRecognizer:artistTapGesture];
                [bgView addSubview:artistView];
                self.artistId = result[@"artistId"];
                self.artistView.headImg = result[@"headImg"];
                self.artistView.artistName = result[@"artistName"];
                self.artistView.artistSign = result[@"artistSign"];
                self.artistView.artistFuns = result[@"artistFuns"];
                self.artistView.isFocused = result[@"isFocused"];
                self.artistView.typicalArts = result[@"typicalArts"];
            }
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
-(void)artistFocusHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager artistFocusWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200 == [result[@"code"] integerValue]) {
            self.artistView.isFocused = result[@"isFocused"];
            self.artistView.artistFuns = result[@"focusedNo"];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
/**
 *  艺术品收藏
 */
-(void)findArtLikeHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager findArtLikeWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        self.funsView.isLike = result[@"isLike"];
        self.funsView.likeNo = result[@"likeNo"];
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
/**
 加入购物车网络请求
 */
-(void)findPutIntoCartWithParametersDic:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager findPutIntoCartWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200 == [result[@"code"] integerValue]) {
            UIImageView *cartAnimView=[[UIImageView alloc] init];
            cartAnimView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(250));
            cartAnimView.contentMode = UIViewContentModeScaleAspectFill;
            cartAnimView.clipsToBounds = YES;
            [cartAnimView sd_setImageWithURL:[NSURL URLWithString:self.imgBrefUrl]];
            [self.view addSubview:cartAnimView];
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 0.0 ];
            rotationAnimation.duration = 1.0;
            rotationAnimation.cumulative = YES;
            rotationAnimation.repeatCount = 0;
            //这个是让旋转动画慢于缩放动画执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [cartAnimView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
            });
            [UIView animateWithDuration:1.0 animations:^{
                cartAnimView.frame=CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(200)+DEF_RESIZE_UI(20), DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(20), 0, 0);
            } completion:^(BOOL finished) {
                [cartAnimView removeFromSuperview];
                UITabBarItem * cartItem = DEF_MyAppDelegate.tabBarController.tabBar.items[2];
                NSString *numStr = cartItem.badgeValue;
                if (!numStr) {
                    cartItem.badgeValue = @"1";
                }
                else{
                    NSInteger count = [numStr integerValue];
                    count++;
                    cartItem.badgeValue = [NSString stringWithFormat:@"%zd",count];
                }
            }];
        }
        else{
          [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result){
        [ATUtility hideMBProgress:self.view];
    }];
}
/*
立即购买加入购物车网络请求
*/
-(void)findBuyIntoCartWithParametersDic:(NSDictionary *)dic withArtID :(NSString *)artId{
    [ATUtility showMBProgress:self.view];
    [RequestManager findPutIntoCartWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        OrderConfirmViewController *confirVc = [[OrderConfirmViewController alloc]init];
        NSArray * artIds = @[artId];
        confirVc.artIds = artIds;
        [self.navigationController pushViewController:confirVc animated:YES];
    } failture:^(id result){
        [ATUtility hideMBProgress:self.view];
    }];
}

#pragma mark - artistViewDelegate

-(void)focusedBtnClick:(ArtistView *)artistView{
    if ([ATUserInfo shareUserInfo].appToken.length) {
        NSDictionary * dic = @{
                               @"artistId" : self.artistId
                               };
        [self artistFocusHttpRequestWithDictionary:dic];
    }
    else{
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)artWorkBtnClick:(ArtistView *)artistView WithArtId:(NSString *)artId{
    ArtWorksViewController * workVc = [[ArtWorksViewController alloc]init];
    workVc.artId = artId;
    [self.navigationController pushViewController:workVc animated:YES];
}

-(void)popViewRemove{
    [self.photoView removeFromSuperview];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    [self performSelector:@selector(popViewRemove) withObject:nil afterDelay:0.3];
}

-(void)imgGestureTap{
    [ATUtility showMBProgress:self.view];
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.numberOfTouchesRequired  = 1;

    [self prefersStatusBarHidden];
    NSString * imgPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * urlName = [self.imgOriUrl MD5] ;
    imgPath = [imgPath stringByAppendingPathComponent:urlName];
    NSData *data = [NSData dataWithContentsOfFile:imgPath];
    if (data) {
            ATImgPreView *photoView = [[ATImgPreView alloc] initWithFrame:self.view.bounds andImage:[UIImage imageWithData:data]];
            self.photoView = photoView;
            self.photoView.worksVc = self;
            [photoView addGestureRecognizer:singleTapGesture];
            photoView.autoresizingMask = (1 << 6) -1;
            [self.view addSubview:photoView];
        [ATUtility hideMBProgress:self.view];
    }
    else{
        dispatch_queue_t q = dispatch_queue_create("downloadImg", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(q, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgOriUrl]];
            dispatch_queue_t mainQ = dispatch_get_main_queue();
            dispatch_async(mainQ, ^{
                ATImgPreView *photoView = [[ATImgPreView alloc] initWithFrame:self.view.bounds andImage:[UIImage imageWithData:data]];
                self.photoView = photoView;
                [photoView addGestureRecognizer:singleTapGesture];
                self.photoView.worksVc = self;
                photoView.autoresizingMask = (1 << 6) -1;
                [self.view addSubview:photoView];
                [ATUtility hideMBProgress:self.view];
                NSString * imgPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *urlName = [self.imgOriUrl MD5];
                imgPath = [imgPath stringByAppendingPathComponent:urlName];
                [data writeToFile:imgPath atomically:YES];
            });
            
        });
    }
}
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_ffffff;
    UIScrollView *mainScr = [[UIScrollView alloc]init];
    self.mainScr = mainScr;
    mainScr.scrollEnabled = YES;
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.bounces = YES;
    mainScr.showsVerticalScrollIndicator = NO;
    mainScr.frame  =CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-49);
    [self.view addSubview:mainScr];
    
    //添加顶部图片
    UIImageView *topImgView = [[UIImageView alloc]init];
    topImgView.image = DEF_IMAGENAME(@"global_default_img");
    UITapGestureRecognizer *imgTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgGestureTap)];
    topImgView.userInteractionEnabled =YES;
    topImgView.contentMode = UIViewContentModeScaleAspectFill;
    topImgView.clipsToBounds = YES;
    [topImgView addGestureRecognizer:imgTapGesture];
    self.topImgView = topImgView;
    topImgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(250));
    [self.view addSubview:topImgView];
    //添加作品详情信息
    WorkDetailView *detailView = [[WorkDetailView alloc]init];
    self.detailView = detailView;
    [mainScr addSubview:detailView];
    
    UIImageView * bgImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_artdetail_headbg")];
    bgImgView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64);
    [self.view addSubview:bgImgView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [backBtn setImage:DEF_IMAGENAME(@"artist_left_white") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn .frame = CGRectMake(DEF_RESIZE_UI(0), DEF_RESIZE_UI(5), DEF_RESIZE_UI(80), DEF_RESIZE_UI(56));
    [self.view addSubview:backBtn];
    //分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:DEF_IMAGENAME(@"artist_share_white") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shareBtn .frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(10)-DEF_RESIZE_UI(42), DEF_RESIZE_UI(8), DEF_RESIZE_UI(42), DEF_RESIZE_UI(48));
    [self.view addSubview:shareBtn];
    
    //立即购买
    UIView * downBgView = [[UIView alloc]init];
    downBgView.frame = CGRectMake(0,DEF_DEVICE_HEIGHT-49 , DEF_DEVICE_WIDTH, 49);
    [self.view addSubview:downBgView];
    
    UIButton * immBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [immBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [immBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
    immBtn.titleLabel.font = DEF_MyFont(12);
    immBtn.backgroundColor = COLOR_ff6060;
    immBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(90), 0, DEF_RESIZE_UI(90), 49);
    [immBtn addTarget:self action:@selector(immBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [downBgView addSubview:immBtn];
    
    UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartBtn setImage:DEF_IMAGENAME(@"find_cart_red") forState:UIControlStateNormal];
    [shopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCartBtn setTitleColor:COLOR_ff6060 forState:UIControlStateNormal];
    shopCartBtn.titleLabel.font = DEF_MyFont(13);
    shopCartBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    shopCartBtn.frame = CGRectMake(CGRectGetMinX(immBtn.frame)-DEF_RESIZE_UI(110), 0, DEF_RESIZE_UI(110), 49);
    [shopCartBtn addTarget:self action:@selector(shopCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [downBgView addSubview:shopCartBtn];

}

#pragma mark - 返回那妞

-(void)backBtnClick{
      [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)shareBtnClick{
    if ([ATUserInfo shareUserInfo].appToken.length) {
        ThirdShareTool * shareTool = [[ThirdShareTool alloc]initWithContent:nil];
        self.shareTool = shareTool;
        [shareTool handleBlock:^(NSInteger index) {
            switch (index) {
                case 0:
                {
                    //微博
                    _urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:_imgOriUrl];
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"什么作品才能够抚慰你浮躁而又疲惫的心灵？点击即可享有它！http://www.88art.com" image:nil location:nil urlResource:_urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
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
                    _urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:_imgOriUrl];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.88art.com";
                    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:@"什么作品才能够抚慰你浮躁而又疲惫的心灵？点击即可享有它!" image:nil location:nil urlResource:_urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                            NSLog(@"分享成功！");
                            //[self shareBtnClick];
                        }
                    }];
                     [self.shareTool removeFromWindow];
                }
                    break;
                case 2:
                {
                    //朋友圈
                    _urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:_imgOriUrl];
                    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.88art.com";
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"艺术源于生活，又高于生活。不仅仅需要感知美的内心，善于发现美的眼睛，更需要有一双呈现美的手，请为它点个赞哦！http://www.88art.com" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                        [self.shareTool removeFromWindow];
                        if (response.responseCode == UMSResponseCodeSuccess) {                            NSLog(@"分享成功！");
                            
                        }
                    }];
                    [self.shareTool removeFromWindow];
                }
                    break;
                case 3:
                {
                    //QQ
                    _urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:_imgOriUrl];
                    [UMSocialData defaultData].extConfig.qqData.url = @"http://www.88art.com";
                    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"艺术源于生活，又高于生活。不仅仅需要感知美的内心，善于发现美的眼睛，更需要有一双呈现美的手，请为它点个赞哦！http://www.88art.com" image:nil location:nil urlResource:_urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                        [self.shareTool removeFromWindow];
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
    }
    else{
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
