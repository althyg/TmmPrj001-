//
//  FindViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FindViewController.h"
//#import "LoopBannerView.h"
#import "WorksCell.h"
#import "ArtWorksViewController.h"
#import "OrderConfirmViewController.h"
#import "RequestHelp.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "ScreeningViewController.h"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton * hotBtn ;

@property (nonatomic,strong) UIButton * newsBtn ;

@property (nonatomic,strong) UIView * downLine1;

@property (nonatomic,strong) UIView * downLine2;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,assign) NSInteger curPageIndex;//请求数据页

@property (nonatomic,copy) NSString * artsTypeId;

//@property (nonatomic,strong) LoopBannerView * bannerView ;

@property (nonatomic,assign) BOOL canRefresh;

@property (nonatomic,strong) NSMutableArray * workArr ;

@property (nonatomic,strong) NSMutableArray * bannerArtIds ;

@end

@implementation FindViewController

-(NSMutableArray *)workArr{
    if (!_workArr) {
        _workArr=[NSMutableArray array];
    }
    return _workArr;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self setupRefresh];
    [self setupLoadMore];
    [self createUITableItem];
}

/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak FindViewController *weakSelf = self;
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        [weakSelf reloadData];
//    }];
    [self.tableView addCustomGifHeaderWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
  [self.tableView.header beginRefreshing];

}

-(void)reloadData{
    self.curPageIndex=1;
    NSDictionary * dic=@{@"artsTypeId":self.artsTypeId,
                         @"artsPage":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                         @"bannerSize" :@"750x400",
                         @"artSize" :@"750x500"
                       };
    [self findHomePageHttpRequestWithDictionary:dic];
}

/**
 *  上拉刷新
 */
-(void)setupLoadMore{
    __weak FindViewController *weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPageIndex+=1;
        [weakSelf loadMoreDataWithPage:[NSString stringWithFormat:@"%zd",weakSelf.curPageIndex]];
    }];
    self.tableView.footer.hidden=YES;
}

-(void)loadMoreDataWithPage:(NSString * )page{
    NSDictionary * dic=@{@"artsTypeId":self.artsTypeId,
                         @"artsPage":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                         @"bannerSize" :@"750x400",
                         @"artSize" :@"750x500"
                         };
    [self findHomePageHttpRequestWithDictionary:dic];

}

/**
 *  首页数据网络请求
 */
-(void)findHomePageHttpRequestWithDictionary:(NSDictionary *)dic{
 
    [RequestManager findHomepageWithParametersDic:dic success:^(NSDictionary *result) {
        if (200==[result[@"code"] integerValue]){
            //self.bannerView.imgViewArr = result[@"images"];
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dict in result[@"images"]) {
               [arrM addObject:dict[@"artId" ]];
            }
            //self.bannerArtIds = arrM;
            NSArray * listArr= result[@"arts"];
            NSArray * arr=[Work findHomepageGroupFromJosnArray:listArr];
            self.canRefresh=[result[@"end"] integerValue];
            if (self.canRefresh) {
                self.tableView.footer.hidden=NO;
            }
            else{
                self.tableView.footer.hidden=YES;
            }
            
            if (self.curPageIndex==1) {
                [self.workArr removeAllObjects];
                self.workArr=[NSMutableArray arrayWithArray:arr];
            }
            else{
                [self.workArr addObjectsFromArray:[NSMutableArray arrayWithArray:arr]];
            }
            [self.tableView reloadData];
        }
        [self.tableView.header endRefreshing];
        [self.tableView .footer endRefreshing];
    } failture:^(id result) {
        [self.tableView.header endRefreshing];
        [self.tableView .footer endRefreshing];
    }];     
}
/**
 加入购物车网络请求
 */
-(void)findPutIntoCartWithParametersDic:(NSDictionary *)dic withArtImgFrame:(NSIndexPath *) indexPath{
    [ATUtility showMBProgress:self.view];
    [RequestManager findPutIntoCartWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200==[result[@"code"] integerValue]){
            CGRect imgFrame = [self.tableView rectForRowAtIndexPath:indexPath];
            CGFloat imgY =imgFrame.origin.y-10-self.tableView.contentOffset.y+84;
            CGFloat imgH = DEF_RESIZE_UI(250);
            imgFrame = CGRectMake(0, imgY, DEF_DEVICE_WIDTH, imgH);
            UIImageView *cartAnimView=[[UIImageView alloc] initWithFrame:imgFrame];
            cartAnimView.contentMode = UIViewContentModeScaleAspectFill;
            cartAnimView.clipsToBounds = YES;
            Work * work = self.workArr[indexPath.row];
            [cartAnimView sd_setImageWithURL:[NSURL URLWithString:work.imgUrl]];
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
                cartAnimView.frame=CGRectMake(DEF_DEVICE_WIDTH*0.6+DEF_RESIZE_UI(10), DEF_DEVICE_HEIGHT, 0, 0);
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
/**
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

#pragma mark - 搜索按钮的点击

-(void)searchBtnClick{
    SearchViewController *searVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searVc animated:YES];
}

//初始化UI
-(void)initUI{
    self.view.backgroundColor=COLOR_ffffff;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title=@"艺术品";
    self.artsTypeId = @"0";
    self.curPageIndex=1;
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNmlImg:@"find_search_black" hltImg:@"find_search_black" target:self action:@selector(searchBtnClick)];
    //添加bgView
    //UIView * bgView =[[UIView alloc]init];
    //bgView.frame = CGRectMake(0, 64, DEF_DEVICE_HEIGHT, 200);
    //添加bannerView
    //LoopBannerView *bannerView = [[LoopBannerView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(200))];
    //self.bannerView = bannerView;
    //bannerView.blockBanner = ^(NSInteger index){
    //ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
    //workVc.artId = self.bannerArtIds[index];
    //[self.navigationController pushViewController:workVc animated:YES];
    //};
    //[bgView addSubview:bannerView];
    //newImage
    //UIImageView * numImageView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"find_number_homepahe")];
    //[bgView addSubview:numImageView];
    //numImageView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(70));
    //添加导航条
    //UIView * navView = [[UIView alloc]init];
    //navView.backgroundColor = COLOR_ffffff;
    //navView.frame = CGRectMake(0, CGRectGetMaxY(numImageView.frame), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(40));
    //[bgView addSubview:navView];
    UIView *modelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 40)];
    modelView.backgroundColor = [UIColor whiteColor];
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-64-49) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = modelView;
    tableView.scrollsToTop = YES;
    [self.view addSubview:tableView];
    
    //人气按钮
    UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hotBtn = hotBtn;
    [hotBtn setTitle:@"人气" forState:UIControlStateNormal];
    hotBtn.titleLabel.font = DEF_MyFont(14);
    [hotBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [hotBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    hotBtn.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [hotBtn addTarget:self action:@selector(hotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tableView.tableHeaderView addSubview:hotBtn];
    //downLine
    UIView *downLine1 = [[UIView alloc]init];
    self.downLine1 = downLine1;
    downLine1.backgroundColor = COLOR_ff6060;
    downLine1.size = CGSizeMake(DEF_RESIZE_UI(DEF_DEVICE_WIDTH/2), DEF_RESIZE_UI(2));
    downLine1.center = CGPointMake(DEF_DEVICE_WIDTH*0.25, tableView.tableHeaderView.height-DEF_RESIZE_UI(2));
    [tableView.tableHeaderView addSubview:downLine1];
    //最新按钮
    UIButton *newBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.newsBtn = newBtn;
    newBtn.titleLabel.font = DEF_MyFont(14);
    [newBtn setTitle:@"最新" forState:UIControlStateNormal];
    [newBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    [newBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    newBtn.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5, 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [newBtn addTarget:self action:@selector(newBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tableView.tableHeaderView addSubview:newBtn];
    //downLine
    UIView *downLine2 = [[UIView alloc]init];
    self.downLine2 = downLine2;
    downLine2.backgroundColor = COLOR_ff6060;
    downLine2.size = CGSizeMake(DEF_RESIZE_UI(DEF_DEVICE_WIDTH/2), DEF_RESIZE_UI(2));
    downLine2.center = CGPointMake(DEF_DEVICE_WIDTH*0.75, tableView.tableHeaderView.height-DEF_RESIZE_UI(2));
    [tableView.tableHeaderView addSubview:downLine2];
    self.hotBtn.selected =YES;
    self.newsBtn.selected = NO;
    self.downLine1.alpha =1;
    self.downLine2.alpha =0;

}
#pragma mark - 创建原生的下面那个UITabelTools
- (void)createUITableItem{
    
    //[self.navigationController.toolbar setBackgroundColor:[UIColor orangeColor]];
    //barButtonitem实例
    //    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd   target:self action:nil];
    //    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks  target:self action:nil];
    //item的间隔，不会显示出来,会自动计算间隔,就是上面的调节
    //    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace  target:self action:nil];
    //    NSArray *arr = [[NSArray alloc]initWithObjects:item1,spaceItem,item2,spaceItem, nil];
    //    self.toolbarItems = arr;
    //或者通过setToolbarItems方法将按钮放入到工具栏上
    //[self setToolbarItems:arr];
    
    UIView *toolbarView = [[UIView alloc]init];
    toolbarView.frame = CGRectMake(0,DEF_DEVICE_HEIGHT-49 , DEF_DEVICE_WIDTH, 49);
    [self.view addSubview:toolbarView];
    toolbarView.backgroundColor = [UIColor whiteColor];
    
    UIButton *screenBtn = [[UIButton alloc]init];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitleColor:COLOR_333333 forState:UIControlStateNormal];
    screenBtn.titleLabel.font = DEF_MyFont(14);
    screenBtn.backgroundColor = COLOR_ffffff;
    screenBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(40), 0, DEF_RESIZE_UI(30), 49);
    [screenBtn addTarget:self action:@selector(screenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //筛选旁边的图片
    UIImageView *pickView = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60), 15, 16, 17)];
    pickView.image = [UIImage imageNamed:@"picker"];
    [toolbarView addSubview:pickView];
    //左边的购物车按钮
    UIButton *shoppingcarBtn = [[UIButton alloc]init];
    [shoppingcarBtn setImage:[UIImage imageNamed:@"screen_shoppingcar"] forState:UIControlStateNormal];
    shoppingcarBtn.frame = CGRectMake(DEF_RESIZE_UI(20), 0, DEF_RESIZE_UI(30), 49);
    [toolbarView addSubview:shoppingcarBtn];
    //购物车监听事件
    
    [toolbarView addSubview:screenBtn];
    
}
- (void)screenBtnClick{
    //跳转筛选控制器
    ScreeningViewController *screenVC = [[ScreeningViewController alloc]init];
    [self.navigationController pushViewController:screenVC animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorksCell *workCell = [WorksCell worksCellFromTableView:tableView];
    Work * work = self.workArr[indexPath.row];
    workCell.work = work;
    NSDictionary * dic =@{@"artId":workCell.work.artId};
    workCell.buttonBlock = ^{
          if ([ATUserInfo shareUserInfo].appToken.length) {
                 [self findBuyIntoCartWithParametersDic:dic withArtID:work.artId];
          }
          else{
              LoginViewController *logVc = [[LoginViewController alloc]init];
              ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
              [self presentViewController:nav animated:YES completion:nil];
          }
    };
    workCell.addCartBlock = ^{
        if ([ATUserInfo shareUserInfo].appToken.length) {
           [self findPutIntoCartWithParametersDic:dic withArtImgFrame:(NSIndexPath *) indexPath];
        }
        else{
            LoginViewController *logVc = [[LoginViewController alloc]init];
            ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    };
    return workCell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.8);
    [UIView animateWithDuration:0.7 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArtWorksViewController *artVc = [[ArtWorksViewController alloc]init];
    Work * work = self.workArr[indexPath.row];
    artVc.artId = work.artId;
    [self.navigationController pushViewController:artVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_RESIZE_UI(340);
}

#pragma mark - 人气按钮点击事件
-(void)hotBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.newsBtn.selected =NO;
    self.downLine1.alpha = 1;
    self.downLine2.alpha = 0;
    self.artsTypeId = @"0";
    self.curPageIndex=1;
    [self.tableView.header beginRefreshing];
}
#pragma mark - 最新按钮点击事件
-(void)newBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.hotBtn.selected =NO;
    self.downLine1.alpha = 0;
    self.downLine2.alpha = 1;
    self.artsTypeId = @"1";
    self.curPageIndex=1;
    [self.tableView.header beginRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end