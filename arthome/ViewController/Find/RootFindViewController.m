//
//  RootFindViewController.m
//  arthome
//
//  Created by qzwh on 16/7/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "RootFindViewController.h"
#import <AFNetworking.h>
#import "LoopBannerView.h"
#import "Work.h"
#import "ArtWorksViewController.h"
#import "FindViewController.h"
#import "ArtistViewController.h"
#import "SearchViewController.h"
#import "ArtistDetailViewController.h"

#import "FindTableViewCell0.h"
#import "FindTableViewCell1.h"
#import "FindTableViewCell2.h"


@interface RootFindViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UIView* _navBarView;
    UIView* _statusBarView;
    
    // 模拟数据
    NSDictionary *localData;
    NSArray *s_headerTiles;
    
}
// 轮播滚动图
@property (nonatomic, strong) LoopBannerView *loopBanner;

@property (nonatomic,strong) NSMutableArray * bannerArtIds ;

@property (nonatomic,strong) UITableView *tableView;

/**
 *  数据源数组
 */
@property (nonatomic,strong) NSMutableArray *homeArr;

@end

@implementation RootFindViewController
-(NSMutableArray *)homeArr{
    if (!_homeArr) {
        _homeArr=[NSMutableArray array];
    }
    return _homeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self setupRefresh];
}

/**
 *  下拉刷新
 */
-(void)setupRefresh{
    
    __weak RootFindViewController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf createBannerData];
    }];
    [self.tableView.header beginRefreshing];
    
}

- (void)createBannerData{
    //首页轮播图数据
    NSDictionary *dic = @{@"artsTypeId":@"0",
                          @"artsPage":@"1",
                          @"bannerSize" :@"750x400",
                          @"artSize" :@"750x500"};
    [RequestManager findHomepageWithParametersDic:dic success:^(NSDictionary *result) {
        
        NSArray *bannerImages = [result objectForKey:@"images"];
        
        _loopBanner.imgViewArr = bannerImages;
        
        
    } failture:^(id result) {
        //失败数据
    }];
    //首页的内容数据
//    NSDictionary *dict = @{@"apptoken":@"eccbc87e4b5ce2fe28308fd9f2a7baf3"};
//    [RequestManager findHomeContentWithParametersDic:dict success:^(NSDictionary *result) {
//        //NSLog(@"---%@---",result);
//        localData = result;
//        
//    } failture:^(id result) {
//        //
//    }];
    
    [self.tableView.header endRefreshing];
}

#pragma mark - 创建UI界面
- (void)createUI{
    
    self.view.backgroundColor=COLOR_ffffff;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatNavBarView];
    UIView * bgView =[[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, DEF_DEVICE_HEIGHT, DEF_RESIZE_UI(200+97+10));
    bgView.backgroundColor = [UIColor whiteColor];
    //添加bannerView
    LoopBannerView *bannerView = [[LoopBannerView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(200))];
    self.loopBanner = bannerView;
    
    __weak LoopBannerView *weakbanner = self.loopBanner;
    bannerView.blockBanner = ^(NSInteger index){
        
        ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
        workVc.artId = [[weakbanner.imgViewArr objectAtIndex:index] objectForKey:@"artId"];
        
        [self.navigationController pushViewController:workVc animated:YES];
    };
    [bgView addSubview:bannerView];
    //创建艺术家艺术品模块
    UIButton *artpingBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/4, DEF_RESIZE_UI(200+23), 40, 40)];
    [artpingBtn setImage:[UIImage imageNamed:@"find_artping_btn"] forState:UIControlStateNormal];
    [artpingBtn addTarget:self action:@selector(artpingOnclick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *artpingLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/4, DEF_RESIZE_UI(200+23+40), 40, 12)];
    [artpingLabel setText:@"艺术品"];
    [artpingLabel setTextColor:[UIColor blackColor]];
    [artpingLabel setFont:[UIFont systemFontOfSize:12]];
    [bgView addSubview:artpingBtn];
    [bgView addSubview:artpingLabel];
    UIButton *artjiaBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH*0.75, DEF_RESIZE_UI(200+23), 40, 40)];
    [artjiaBtn setImage:[UIImage imageNamed:@"find_artjia_btn"] forState:UIControlStateNormal];
    [artjiaBtn addTarget:self action:@selector(artjiaOnclick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *artjiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH*0.75, DEF_RESIZE_UI(200+23+40), 40, 12)];
    [artjiaLabel setText:@"艺术家"];
    [artjiaLabel setTextColor:[UIColor blackColor]];
    [artjiaLabel setFont:[UIFont systemFontOfSize:12]];
    [bgView addSubview:artjiaBtn];
    [bgView addSubview:artjiaLabel];
    //添加中间的分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(DEF_DEVICE_WIDTH/2, DEF_RESIZE_UI(200+21), 1, DEF_RESIZE_UI(56))];
    lineView.backgroundColor = [UIColor grayColor];
    [bgView addSubview:lineView];
    //添加分割的横线
    //添加模块下面的10像素的灰色
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(200+97), DEF_DEVICE_WIDTH, 10)];
    grayView.backgroundColor = [UIColor grayColor];
    grayView.alpha = 0.3;
    [bgView addSubview:grayView];
    
    [self.view addSubview:bgView];
    //创建UITableView
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = bgView;
    UIView *ftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 64)];
    ftView.backgroundColor = [UIColor whiteColor];
    [_tableView addSubview:ftView];
    _tableView.tableFooterView = ftView;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    //注册
    [_tableView registerClass:[FindTableViewCell0 class] forCellReuseIdentifier:@"FindCell0"];
    [_tableView registerClass:[FindTableViewCell1 class] forCellReuseIdentifier:@"FindCell1"];
    [_tableView registerClass:[FindTableViewCell2 class] forCellReuseIdentifier:@"FindCell2"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"new_find01test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
   NSError *error = nil;
   localData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
    
    
    s_headerTiles = @[@"艺术品推荐", @"油画", @"国画", @"书法", @"杂项", @"艺术家推荐"];
    
    
}
#pragma mark ---- 原生界面
- (void)creatNavBarView{
    
    _statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 20)];
    _statusBarView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].delegate.window addSubview:_statusBarView];
    _navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, DEF_DEVICE_WIDTH, 50)];
    _navBarView.userInteractionEnabled = YES;
    _navBarView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].delegate.window addSubview:_navBarView];
    
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _navBarView.width, _navBarView.height)];
    bgView.backgroundColor = [UIColor blueColor];
    bgView.alpha = 0;
    [_navBarView addSubview:bgView];
    
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(_navBarView.right - 40, 5, 50, 50);
    UIImageView* rightimgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30, 30)];
    rightimgView.image = [UIImage imageNamed:@"find_search_button"];
    [rightBtn addSubview:rightimgView];
    [rightBtn addTarget:self action:@selector(searchOlick) forControlEvents:UIControlEventTouchUpInside];
    [_navBarView addSubview:rightBtn];
}
- (void)searchOlick{
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
}
- (void)artpingOnclick{
    
    FindViewController *artpingVC = [[FindViewController alloc]init];
    [self.navigationController pushViewController:artpingVC animated:YES];
}
- (void)artjiaOnclick{
    
    ArtistViewController *artVC = [[ArtistViewController alloc]init];
    [self.navigationController pushViewController:artVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //作品推荐
        FindTableViewCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"FindCell2" forIndexPath:indexPath];
        [cell2 setCellData:[localData objectForKey:@"artproduct"]];
        
        cell2.f_CollectionView.selectedCollectionItem = ^(id itemData) {
            ArtWorksViewController *artProductVC = [[ArtWorksViewController alloc]init];
            artProductVC.artId = [itemData objectForKey:@"artproductID"];
            [self.navigationController pushViewController:artProductVC animated:YES];
               //NSLog(@"%@", itemData);
        };
        
        return cell2;
    } else if (indexPath.section == 1) {
        //油画
        FindTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FindCell1" forIndexPath:indexPath];
        cell1.type = @"oildraw";
        [cell1 setCellData:[localData objectForKey:@"oildraw"]];
        cell1.f_CollectionView.selectedCollectionItem = ^(id itemData) {
            
            ArtWorksViewController *artProductVC = [[ArtWorksViewController alloc]init];
            artProductVC.artId = [itemData objectForKey:@"oildrawID"];
            [self.navigationController pushViewController:artProductVC animated:YES];
              //NSLog(@"%@", itemData);
        };
        return cell1;
    } else if (indexPath.section == 2) {
        //国画
        FindTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FindCell1" forIndexPath:indexPath];
        cell1.type = @"countriesdraw";
        [cell1 setCellData:[localData objectForKey:@"countriesdraw"]];
        
        cell1.f_CollectionView.selectedCollectionItem = ^(id itemData) {
            ArtWorksViewController *artProductVC = [[ArtWorksViewController alloc]init];
            artProductVC.artId = [itemData objectForKey:@"countriesdrawID"];
            [self.navigationController pushViewController:artProductVC animated:YES];
                 // NSLog(@"%@", itemData);
        };
        return cell1;
    } else if (indexPath.section == 3) {
        //书法
        FindTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FindCell1" forIndexPath:indexPath];
        cell1.type = @"calligraphy";
        [cell1 setCellData:[localData objectForKey:@"calligraphy"]];
        cell1.f_CollectionView.selectedCollectionItem = ^(id itemData) {
            
            ArtWorksViewController *artProductVC = [[ArtWorksViewController alloc]init];
            artProductVC.artId = [itemData objectForKey:@"calligraphyID"];
            [self.navigationController pushViewController:artProductVC animated:YES];
            //NSLog(@"%@", itemData);
        };
        return cell1;
    } else if (indexPath.section == 4) {
        //杂项
        FindTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"FindCell1" forIndexPath:indexPath];
        cell1.type = @"miscellaneous";
        [cell1 setCellData:[localData objectForKey:@"miscellaneous"]];
        cell1.f_CollectionView.selectedCollectionItem = ^(id itemData) {
            
            ArtWorksViewController *artProductVC = [[ArtWorksViewController alloc]init];
            artProductVC.artId = [itemData objectForKey:@"miscellaneousID"];
            [self.navigationController pushViewController:artProductVC animated:YES];
            // NSLog(@"%@", itemData);
        };
        return cell1;
        
    } else {
        //艺术家推荐
        FindTableViewCell0 *cell0 = [tableView dequeueReusableCellWithIdentifier:@"FindCell0" forIndexPath:indexPath];
        
        [cell0 setCellData:[localData objectForKey:@"artist"]];
        
        cell0.f_CollectionView.selectedCollectionItem = ^(id itemData) {
             ArtistDetailViewController *artistVC = [[ArtistDetailViewController alloc]init];
            artistVC.artistId = [itemData objectForKey:@"artistID"];
            
            [self.navigationController pushViewController:artistVC animated:YES];
             //NSLog(@"%@", itemData);
        };
        return cell0;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return DEF_RESIZE_UI(330);//推荐艺术品模块的高度
    }else if(indexPath.section == 5){
        
        return DEF_RESIZE_UI(200);//推荐艺术家模块的高度
    }
    
    return DEF_RESIZE_UI(232);//国、油、书、杂
}

//返回头部视图的View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *ts_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    ts_headerView.backgroundColor = [UIColor whiteColor];
    UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(5, 10, 5, 20)];
    shuView.backgroundColor = [UIColor redColor];
    UILabel *lTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    lTitle.text = [NSString stringWithFormat:@"%@", [s_headerTiles objectAtIndex:section]];
    
    
    UIButton *rButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-60, 0, 60, 40)];
    [rButton setImage:[UIImage imageNamed:@"find_more"] forState:UIControlStateNormal];
    [rButton addTarget:self action:@selector(findMore:) forControlEvents:UIControlEventTouchUpInside];
    rButton.tag = section;
    
    [ts_headerView addSubview:shuView];
    [ts_headerView addSubview:lTitle];
    [ts_headerView addSubview:rButton];
    return ts_headerView;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - 更多响应
- (void)findMore:(UIButton *)moreBtn {
    if (moreBtn.tag == 0) {
        FindViewController *findVC = [[FindViewController alloc]init];
        [self.navigationController pushViewController:findVC animated:YES];
        //NSLog(@"更多艺术品");
    } else if (moreBtn.tag == 1) {
        FindViewController *findVC = [[FindViewController alloc]init];
        [self.navigationController pushViewController:findVC animated:YES];
        //NSLog(@"更多油画");
        
    } else if (moreBtn.tag == 2) {
        FindViewController *findVC = [[FindViewController alloc]init];
        [self.navigationController pushViewController:findVC animated:YES];
        //NSLog(@"更多国画");
        
    } else if (moreBtn.tag == 3) {
        FindViewController *findVC = [[FindViewController alloc]init];
        [self.navigationController pushViewController:findVC animated:YES];
        //NSLog(@"更多书法");
        
    } else if (moreBtn.tag == 4) {
        FindViewController *findVC = [[FindViewController alloc]init];
        [self.navigationController pushViewController:findVC animated:YES];
        //NSLog(@"更多杂项");
        
    } else if (moreBtn.tag == 5) {
       ArtistViewController *artistVC = [[ArtistViewController alloc]init];
        [self.navigationController pushViewController:artistVC animated:YES];
        //NSLog(@"更多艺术家");
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    _navBarView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    _navBarView.hidden = YES;
    
}

@end
