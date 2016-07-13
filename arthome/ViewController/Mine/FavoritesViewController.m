//
//  FavoritesViewController.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FavoritesViewController.h"
#import "ArtFavoCell.h"
#import "ArticleFavoCell.h"

@interface FavoritesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) UIButton * artBtn ;

@property (nonatomic,strong) UIView * lineView1 ;

@property (nonatomic,strong) UIButton * articleBtn ;

@property (nonatomic,strong) UIView * lineView2 ;

@property (nonatomic,strong) NSMutableArray * favoriteArts;

@property (nonatomic,strong) NSMutableArray * favoriteArticles ;

@property (nonatomic,assign) NSInteger curPageIndex;//请求数据页

@property (nonatomic,copy) NSString * selectType ;

@end

@implementation FavoritesViewController

-(NSMutableArray *)favoriteArts{
    if (!_favoriteArts) {
        _favoriteArts = [NSMutableArray array];
    }
    return _favoriteArts;
}

-(NSMutableArray *)favoriteArticles{
    if (!_favoriteArticles) {
        _favoriteArticles=[NSMutableArray array];
    }
    return _favoriteArticles;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self setupRefresh];
    [self setupLoadMore];
}
/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak FavoritesViewController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
}

-(void)reloadData{
    self.curPageIndex=1;
    if ([self.selectType isEqualToString:@"艺术品"]) {
        NSDictionary * dic=@{
                             @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                             @"imgsize" :@"150x150"
                             };
//        [self artistArtSearchHttpRequestWithDictionary:dic];
    }
    else{
        NSDictionary * dic=@{
                             @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                             @"headSize" :@"70x70",
                             @"artSize" :@"200x200"
                             };
//        [self artistArtistSearchHttpRequestWithDictionary:dic];
    }
}

/**
 *  上拉刷新
 */
-(void)setupLoadMore{
    __weak FavoritesViewController *weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPageIndex+=1;
        [weakSelf loadMoreDataWithPage:[NSString stringWithFormat:@"%zd",weakSelf.curPageIndex]];
    }];
    self.tableView.footer.hidden=YES;
}

-(void)loadMoreDataWithPage:(NSString * )page{
    if ([self.selectType isEqualToString:@"艺术品"]) {
        NSDictionary * dic=@{
                             @"page":page,
                             @"imgsize" :@"150x150",
                             };
//        [self artistArtSearchHttpRequestWithDictionary:dic];
    }
    else{
        NSDictionary * dic=@{
                             @"page":page,
                             @"headSize" :@"70x70",
                             @"artSize" :@"200x200",
                             };
//        [self artistArtistSearchHttpRequestWithDictionary:dic];
    }
}

#pragma mark - artBtnClick
-(void)artBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.articleBtn.selected = NO;
    self.lineView1.alpha = 1;
    self.lineView2.alpha = 0;
    self.selectType = @"艺术品";
}

#pragma mark - articleBtnClick
-(void)articleBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.artBtn.selected = NO;
    self.lineView1.alpha = 0;
    self.lineView2.alpha = 1;
     self.selectType = @"文章";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.selectType isEqualToString:@"艺术品"]) {
        return self.favoriteArts.count;
    }
    else{
        return self.favoriteArticles.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectType isEqualToString:@"艺术品"]) {
        ArtFavoCell * cell = [ArtFavoCell artFavoCellFromTableView:tableView];
        ArtFavo *artFavo = self.favoriteArts[indexPath.row];
        cell.artFavo = artFavo;
        return cell;
    }
    else{
        ArticleFavoCell *cell = [ArticleFavoCell articleFavoCellFromTableView:tableView];
        ArticleFavo *articleFavo = self.favoriteArticles[indexPath.row];
        cell.articleFavo = articleFavo;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectType isEqualToString:@"艺术品"]) {
        return DEF_RESIZE_UI(90);
    }
    else{
        return DEF_RESIZE_UI(80);
    }
}


//初始化UI
-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"收藏夹";
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(40), DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(40)) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.scrollsToTop = YES;
    self.tableView.backgroundColor = COLOR_f2f2f2;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //headView
    UIView *mainHeadView = [[UIView alloc]init];
    mainHeadView.backgroundColor = COLOR_ffffff;
    mainHeadView.frame = CGRectMake(0, 64, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(40));
    [self.view addSubview:mainHeadView];
    //艺术品按钮
    UIButton *artBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.artBtn = artBtn;
    [artBtn setTitle:@"艺术品" forState:UIControlStateNormal];
    artBtn.titleLabel.font = DEF_MyFont(14);
    artBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [artBtn setTitleColor:COLOR_da1025 forState:UIControlStateSelected];
    [artBtn setTitleColor:COLOR_cccccc forState:UIControlStateNormal];
    artBtn.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [artBtn addTarget:self action:@selector(artBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainHeadView addSubview:artBtn];
    //按钮下划线
    UIView * lineView1 = [[UIView alloc]init];
    self.lineView1 = lineView1;
    lineView1.backgroundColor = COLOR_da1025;
    lineView1.size = CGSizeMake(DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(2));
    lineView1.center = CGPointMake(DEF_DEVICE_WIDTH*0.25, mainHeadView.height-DEF_RESIZE_UI(2));
    [mainHeadView addSubview:lineView1];
    //文章
    UIButton *articleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.articleBtn = articleBtn;
    [articleBtn setTitle:@"文章" forState:UIControlStateNormal];
    articleBtn.titleLabel.font = DEF_MyFont(14);
    articleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [articleBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    [articleBtn setTitleColor:COLOR_cccccc forState:UIControlStateNormal];
    articleBtn.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5 , 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [articleBtn addTarget:self action:@selector(articleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainHeadView addSubview:articleBtn];
    //按钮下划线
    UIView * lineView2 = [[UIView alloc]init];
    self.lineView2 = lineView2;
    lineView2.backgroundColor = COLOR_ff6060;
    lineView2.size = CGSizeMake(DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(2));
    lineView2.center = CGPointMake(DEF_DEVICE_WIDTH*0.75, mainHeadView.height-DEF_RESIZE_UI(2));
    [mainHeadView addSubview:lineView2];
    artBtn.selected = YES;
    articleBtn.selected = NO;
    lineView1.alpha = 1;
    lineView2.alpha = 0;
}

@end
