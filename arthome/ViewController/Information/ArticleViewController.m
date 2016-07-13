//
//  ArticleViewController.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArticleViewController.h"
#import "LoopBannerView.h"
#import "InformationViewController.h"
#import "ArticleCategoryController.h"
#import "WorksCell.h"

@interface ArticleViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) LoopBannerView * bannerView ;

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,assign) NSInteger curPageIndex;//请求数据页

@property (nonatomic,assign) BOOL canRefresh;

@property (nonatomic,strong) NSMutableArray * workArr ;

@property (nonatomic,strong) UIView * bgView ;

@property (nonatomic,strong) UIView * titleView ;

@end

@implementation ArticleViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self setupRefresh];
    [self setupLoadMore];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tableView.contentOffset.y>0) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self creatTitleViewWithTitleArr:nil
                           andCGRect:CGRectMake(0, DEF_RESIZE_UI(210), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(40))
                        andSuperView:self.bgView
                              andTag:99];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if ([self.navigationController.viewControllers lastObject] != self) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

-(NSMutableArray *)workArr{
    if (!_workArr) {
        _workArr=[NSMutableArray array];
    }
    return _workArr;
}
/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak ArticleViewController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    [self.tableView.header beginRefreshing];
    
}

-(void)reloadData{
    self.curPageIndex=1;
    NSDictionary * dic=@{@"artsTypeId":@"0",
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
    __weak ArticleViewController *weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPageIndex+=1;
        [weakSelf loadMoreDataWithPage:[NSString stringWithFormat:@"%zd",weakSelf.curPageIndex]];
    }];
    self.tableView.footer.hidden=YES;
}

-(void)loadMoreDataWithPage:(NSString * )page{
    NSDictionary * dic=@{@"artsTypeId":@"0",
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
            self.bannerView.imgViewArr = result[@"images"];
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dict in result[@"images"]) {
                [arrM addObject:dict[@"artId" ]];
            }
//            self.bannerArtIds = arrM;
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.workArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorksCell *workCell = [WorksCell worksCellFromTableView:tableView];
    Work * work = self.workArr[indexPath.row];
    workCell.work = work;
    return workCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_RESIZE_UI(340);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
      if (scrollView.contentOffset.y>0) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
      }
      else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
      }
    if (scrollView.contentOffset.y>=DEF_RESIZE_UI(210)) {
        if (![self.view viewWithTag:1001]) {
        [self creatTitleViewWithTitleArr:nil
                               andCGRect:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(40))
                            andSuperView:self.view
                                  andTag:1001];
        }
    }
    else{
        if ([self.view viewWithTag:1001] ) {
        [[self.view viewWithTag:1001] removeFromSuperview];
        }
    }
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加bgView
    UIView * bgView =[[UIView alloc]init];
    self.bgView = bgView;
    bgView.frame = CGRectMake(0, 0, DEF_DEVICE_HEIGHT, DEF_RESIZE_UI(250));
    [self.view addSubview:bgView];
    //添加bannerView
    LoopBannerView *bannerView = [[LoopBannerView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(200))];
    bannerView.backgroundColor = [UIColor redColor];
    self.bannerView = bannerView;
    bannerView.blockBanner = ^(NSInteger index){
        InformationViewController *articleVc = [[InformationViewController alloc]init];
//        articleVc.articleId = self.bannerArtIds[index];
        [self.navigationController pushViewController:articleVc animated:YES];
    };
    [bgView addSubview:bannerView];
    //apartLine
    UIView *apartLine = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(200), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10))];
    apartLine.backgroundColor = COLOR_f2f2f2;
    [bgView addSubview:apartLine];
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-15) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = bgView;
    tableView.scrollsToTop = YES;
    [self.view addSubview:tableView];
}
-(void)creatTitleViewWithTitleArr:(NSArray *)titleArr
                        andCGRect:(CGRect) titleViewFrame
                     andSuperView:(UIView *) superView
                           andTag:(NSInteger)titleViewTag{
    //titleBg
    UIView *titleView = [[UIView alloc]initWithFrame:titleViewFrame];
    titleView.backgroundColor = COLOR_ffffff;
    titleView.tag = titleViewTag;
    [superView addSubview:titleView];
    //分类button
    UIButton *cateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cateBtn.backgroundColor = [UIColor yellowColor];
    cateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    cateBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [cateBtn setImage:DEF_IMAGENAME(@"article_category_add") forState:UIControlStateNormal];
    [cateBtn setTitleColor:COLOR_da1025 forState:UIControlStateNormal];
    cateBtn.imageView.contentMode = UIViewContentModeCenter;
    cateBtn.titleLabel.font = DEF_MyFont(11);
    [cateBtn setTitle:@"分类" forState:UIControlStateNormal];
    cateBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(70), 0, DEF_RESIZE_UI(70), DEF_RESIZE_UI(40));
    [cateBtn addTarget:self action:@selector(cateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cateBtn];
    //verticalLine
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = COLOR_e4e4e4;
    verticalLine.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(71), DEF_RESIZE_UI(5), DEF_RESIZE_UI(1), DEF_RESIZE_UI(30));
    [titleView addSubview:verticalLine];
    //titleScr
    UIScrollView *titleScr = [[UIScrollView alloc]init];
    titleScr.backgroundColor = [UIColor purpleColor];
    titleScr.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH-DEF_RESIZE_UI(71), DEF_RESIZE_UI(40));
    [titleView addSubview:titleScr];
}
-(void)cateBtnClick{
    ArticleCategoryController *cateVc = [[ArticleCategoryController alloc]init];
    [self.navigationController pushViewController:cateVc animated:YES];
}

@end
