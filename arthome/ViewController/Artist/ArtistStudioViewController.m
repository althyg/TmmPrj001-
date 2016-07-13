//
//  ArtistStudioViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/30.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtistStudioViewController.h"
#import "ArtWorksViewController.h"
#import "ArtStudio.h"
#import "LoginViewController.h"
#import <UMSocial.h>

@interface ArtistStudioViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView * downLine ;

@property (nonatomic,strong) UIButton * artsBtn ;

@property (nonatomic,strong) UIButton * onSellBtn ;

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,strong) NSMutableArray * artsArr ;

@property (nonatomic,strong) UICollectionView * collectionView ;

@property (nonatomic,assign) NSInteger curPageIndex;//请求数据页

@property (nonatomic,copy) NSString * artType;

@property (nonatomic,strong) ThirdShareTool * shareTool ;

@property (nonatomic,assign) BOOL canRefresh;

@end

@implementation ArtistStudioViewController

-(NSMutableArray *)artsArr{
    if (!_artsArr) {
        _artsArr = [NSMutableArray array];
    }
    return _artsArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setupRefresh];
    [self setupLoadMore];
}

/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak ArtistStudioViewController *weakSelf = self;
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    [self.collectionView.header beginRefreshing];
}

-(void)reloadData{
    self.curPageIndex=1;
    int imgWith = (int)DEF_DEVICE_WIDTH*0.3333;
    NSString * artSize = [NSString stringWithFormat:@"%zdx%zd",imgWith,imgWith];
    NSDictionary * dic=@{@"artType":self.artType,
                         @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                         @"pageRow":@"21",
                         @"artSize" :artSize,
                         @"artistId" :self.artistId
                         };
    [self artistArtWorksHttpRequestWithDictionary:dic];
}

/**
 *  上拉刷新
 */
-(void)setupLoadMore{
    __weak ArtistStudioViewController *weakSelf = self;
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPageIndex+=1;
        [weakSelf loadMoreDataWithPage:[NSString stringWithFormat:@"%zd",weakSelf.curPageIndex]];
    }];
    self.collectionView.footer.hidden=YES;
}

-(void)loadMoreDataWithPage:(NSString * )page{
    int imgWith = (int)DEF_DEVICE_WIDTH*0.3333;
    NSString * artSize = [NSString stringWithFormat:@"%zdx%zd",imgWith,imgWith];
    NSDictionary * dic=@{@"artType":self.artType,
                         @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                         @"pageRow":@"21",
                         @"artSize" :artSize,
                         @"artistId" :self.artistId
                         };
    [self artistArtWorksHttpRequestWithDictionary:dic];
}

/**
 *  作品集网络请求
 */
-(void)artistArtWorksHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager artistArtWorksWithParametersDic:dic success:^(NSDictionary *result) {
        if (200 == [result[@"code"] integerValue]) {
            NSArray * listArr = result[@"arts"];
            NSArray * arr=[ArtStudio studionGroupFromJosnArray:listArr];
            self.canRefresh=[result[@"end"] integerValue];
            if (self.canRefresh) {
                self.collectionView.footer.hidden=NO;
            }
            else{
                self.collectionView.footer.hidden=YES;
            }
            if (self.curPageIndex==1) {
                [self.artsArr removeAllObjects];
                self.artsArr=[NSMutableArray arrayWithArray:arr];
            }
            else{
                [self.artsArr addObjectsFromArray:[NSMutableArray arrayWithArray:arr]];
            }
            [self.collectionView reloadData];
  
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
        [self.collectionView.header endRefreshing];
        [self.collectionView .footer endRefreshing];
    } failture:^(id result) {
        [self.collectionView.header endRefreshing];
        [self.collectionView .footer endRefreshing];
    }];
}

#pragma mark - 分享按钮的点击

-(void)shareBtnClick:(id)sender{
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
    }
    else{
        LoginViewController *logVc = [[LoginViewController alloc]init];
        ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
        KEYWINDOW.rootViewController = nav;
    }
   }

#pragma mark - 作品集按钮的点击

-(void)artsBtnClick{
        self.artType = @"0";
        self.artsBtn.selected = YES;
        self.onSellBtn.selected =NO;
        self.downLine.frame= CGRectMake(DEF_DEVICE_WIDTH*0.25-DEF_RESIZE_UI(25), DEF_RESIZE_UI(37), DEF_RESIZE_UI(50), DEF_RESIZE_UI(2));
    [self setupRefresh];
}

#pragma mark -在售作品按钮的点击

-(void)onSellBtnClick{
        self.artType = @"1";
        self.artsBtn.selected = NO;
        self.onSellBtn.selected =YES;
        self.downLine.frame= CGRectMake(DEF_DEVICE_WIDTH*0.75-DEF_RESIZE_UI(25), DEF_RESIZE_UI(37), DEF_RESIZE_UI(50), DEF_RESIZE_UI(2));
        [self setupRefresh];
}

#pragma mark - collectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return  self.artsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *ID = @"art";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
     ArtStudio *artStudio = self.artsArr[indexPath.row];
    UIImageView * artImgView = [[UIImageView alloc]init];
    artImgView.frame = CGRectMake(0, 0, cell.contentView.width, cell.contentView.height);
    [artImgView sd_setImageWithURL:[NSURL URLWithString:artStudio.artImgUrl]placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    [cell.contentView addSubview:artImgView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ArtStudio *artStudio = self.artsArr[indexPath.row];
    ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
    workVc.artId = artStudio.artId;
    [self.navigationController pushViewController:workVc animated:YES];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initUI{
    self.view.userInteractionEnabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"工作室";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTarget:self action:@selector(back)];
    UIBarButtonItem * shareBtn = [UIBarButtonItem barBtnItemWithNmlImg:@"mine_share_black" hltImg:@"mine_share_black" target:self action:@selector(shareBtnClick:)];
    self.navigationItem.rightBarButtonItems = @[shareBtn];
    self.artsBtn.selected = YES;
    
    //headView
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = COLOR_ffffff;
    headerView.frame = CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(40));
    [self.view addSubview:headerView];
    
    //作品集按钮
    UIButton * artsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.artsBtn = artsBtn;
    [artsBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    [artsBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [artsBtn setTitle:@"作品集" forState:UIControlStateNormal];
    [artsBtn addTarget:self action:@selector(artsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    artsBtn.titleLabel.font = DEF_MyFont(12);
    artsBtn.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH*0.5,DEF_RESIZE_UI(40));
    [headerView addSubview:artsBtn];
    
    //在售按钮
    UIButton *onSellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.onSellBtn = onSellBtn;
    [onSellBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    [onSellBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [onSellBtn setTitle:@"在售作品" forState:UIControlStateNormal];
    [onSellBtn addTarget:self action:@selector(onSellBtnClick) forControlEvents:UIControlEventTouchUpInside];
    onSellBtn.titleLabel.font = DEF_MyFont(12);
    onSellBtn.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5, 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [headerView addSubview:onSellBtn];
    //下划
    UIView *downLine = [[UIView alloc]init];
    self.downLine = downLine;
    downLine.backgroundColor = COLOR_ff6060;
    downLine.frame = CGRectMake(DEF_DEVICE_WIDTH*0.25-DEF_RESIZE_UI(25), DEF_RESIZE_UI(37), DEF_RESIZE_UI(50), DEF_RESIZE_UI(2));
    [headerView addSubview:downLine];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat imgWith = DEF_DEVICE_WIDTH*0.3333;
    layout.itemSize =  CGSizeMake(imgWith, imgWith);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    UICollectionView * collectonView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(40)+DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(40)-DEF_RESIZE_UI(64)) collectionViewLayout:layout];
    self.collectionView = collectonView;
    collectonView.backgroundColor = [UIColor whiteColor];
    collectonView.dataSource = self;
    collectonView.delegate = self;
    [self.view addSubview:collectonView];
    [collectonView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"art"];
    self.artType = @"0";
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
