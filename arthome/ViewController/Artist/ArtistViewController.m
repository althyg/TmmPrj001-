//
//  ArtistViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtistViewController.h"
#import "ArtistCell.h"
#import "ArtistDetailViewController.h"
#import "ArtWorksViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "ArtistScreeningViewController.h"

@interface ArtistViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) UIButton * recoBtn ;

@property (nonatomic,strong) UIView * lineView1 ;

@property (nonatomic,strong) UIButton * newwPerBtn ;

@property (nonatomic,strong) UIView * lineView2 ;

@property (nonatomic,assign) NSInteger curPageIndex;//请求数据页
/**
 *  选择推荐还是新人
 */
@property (nonatomic,copy) NSString * artistType;

@property (nonatomic,strong) NSMutableArray * artistArr ;

@property (nonatomic,assign) BOOL canRefresh;

@property (nonatomic,copy) NSString * isFocused;

@end

@implementation ArtistViewController

-(NSMutableArray *)artistArr{
    if (!_artistArr) {
        _artistArr = [NSMutableArray array];
    }
    return _artistArr;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initUI];
    [self setupRefresh];
    [self setupLoadMore];
    [self createUITableItem];
}

/**
 *  下拉刷新
 */
-(void)setupRefresh{
    __weak ArtistViewController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    [self.tableView.header beginRefreshing];
    
}

-(void)reloadData{
    self.curPageIndex=1;
    NSDictionary * dic=@{@"artistType":self.artistType,
                         @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                         @"headSize" :@"70x70",
                         @"artSize" :@"200x200"
                         };
    [self artistHomePageHttpRequestWithDictionary:dic];
}

/**
 *  上拉刷新
 */
-(void)setupLoadMore{
    __weak ArtistViewController *weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPageIndex+=1;
        [weakSelf loadMoreDataWithPage:[NSString stringWithFormat:@"%zd",weakSelf.curPageIndex]];
    }];
    self.tableView.footer.hidden=YES;
}

-(void)loadMoreDataWithPage:(NSString * )page{
    NSDictionary * dic=@{@"artistType":self.artistType,
                         @"page":page,
                         @"headSize" :@"70x70",
                         @"artSize" :@"200x200"
                         };
    [self artistHomePageHttpRequestWithDictionary:dic];
}

/**
 *  首页数据网络请求
 */
-(void)artistHomePageHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager  artistHomepageWithParametersDic:dic success:^(NSDictionary *result) {
        if (200 ==[result[@"code"] integerValue]) {
          NSArray * listArr = result[@"artists"];
          NSArray * arr=[Artist artistHomepageGroupFromJosnArray:listArr];
            self.canRefresh=[result[@"end"] integerValue];
            if (self.canRefresh) {
                self.tableView.footer.hidden=NO;
            }
            else{
                self.tableView.footer.hidden=YES;
            }
            if (self.curPageIndex==1) {
                [self.artistArr removeAllObjects];
                self.artistArr=[NSMutableArray arrayWithArray:arr];
            }
            else{
                [self.artistArr addObjectsFromArray:[NSMutableArray arrayWithArray:arr]];
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
 *  艺术家关注网络请求
 */
-(void)artistFocusHttpRequestWithDictionary:dic andCell:(ArtistCell *)cell{
    [ATUtility showMBProgress:self.view];
    [RequestManager artistFocusWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if (200 == [result[@"code"] integerValue]) {
            self.isFocused = result[@"isFocused"];
            cell.focusBtn.selected = [self.isFocused integerValue];
            cell.fansNum.text = result[@"focusedNo"];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
#pragma mark - 推荐按钮的点击

-(void)recoBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.newwPerBtn.selected = NO;
    self.lineView1.alpha = 1;
    self.lineView2.alpha = 0;
    self.artistType = @"0";
    [self.tableView.header beginRefreshing];
}

#pragma mark - 新人按钮的点击

-(void)newPerBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.recoBtn.selected = NO;
    self.lineView1.alpha = 0;
    self.lineView2.alpha = 1;
    self.artistType = @"1";
    [self.tableView.header beginRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.artistArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Artist * artist = self.artistArr[indexPath.row];
    ArtistCell * cell = [ArtistCell artistCellFromTableView:tableView];
     __weak ArtistCell *weakCell = cell;
    cell.artist = artist;
    cell.focusBlock =^{
        if ([ATUserInfo shareUserInfo].appToken.length) {
            NSDictionary *dic = @{
                                  @"artistId" : artist.artistId
                                  };
            [self artistFocusHttpRequestWithDictionary:dic andCell :weakCell];
        }
        else{
            LoginViewController *logVc = [[LoginViewController alloc]init];
            ATNavigationController *nav = [[ATNavigationController alloc]initWithRootViewController:logVc];
            KEYWINDOW.rootViewController = nav;
        }

    };
    cell.artBlock = ^(NSInteger index){
        ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
        Artist * artist = self.artistArr[indexPath.row];
        ArtOfArtist * artOfArtist = artist.typicalArts[index];
        workVc.artId =  artOfArtist.artId;
        [self.navigationController pushViewController:workVc animated:YES];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    cell.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Artist * artist = self.artistArr[indexPath.row];
    ArtistDetailViewController *detailVc = [[ArtistDetailViewController alloc]init];
    detailVc.artistId = artist.artistId;
    [self.navigationController pushViewController:detailVc animated:YES];
}

//初始化UI
-(void)initUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"艺术家";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNmlImg:@"find_search_black" hltImg:@"find_search_black" target:self action:@selector(searchBtnClick)];
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
    //推荐按钮
    UIButton *recoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recoBtn = recoBtn;
    [recoBtn setTitle:@"推荐" forState:UIControlStateNormal];
    recoBtn.titleLabel.font = DEF_MyFont(14);
    recoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [recoBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    [recoBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    recoBtn.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [recoBtn addTarget:self action:@selector(recoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainHeadView addSubview:recoBtn];
    //按钮下划线
    UIView * lineView1 = [[UIView alloc]init];
    self.lineView1 = lineView1;
    lineView1.backgroundColor = COLOR_ff6060;
    lineView1.size = CGSizeMake(DEF_RESIZE_UI(DEF_DEVICE_WIDTH/2), DEF_RESIZE_UI(2));
    lineView1.center = CGPointMake(DEF_DEVICE_WIDTH*0.25, mainHeadView.height-DEF_RESIZE_UI(2));
    [mainHeadView addSubview:lineView1];
    //新人按钮
    UIButton *newPerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.newwPerBtn = newPerBtn;
    [newPerBtn setTitle:@"新人" forState:UIControlStateNormal];
    newPerBtn.titleLabel.font = DEF_MyFont(14);
    newPerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [newPerBtn setTitleColor:COLOR_ff6060 forState:UIControlStateSelected];
    [newPerBtn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
    newPerBtn.frame = CGRectMake(DEF_DEVICE_WIDTH*0.5 , 0, DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(40));
    [newPerBtn addTarget:self action:@selector(newPerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainHeadView addSubview:newPerBtn];
    //按钮下划线
    UIView * lineView2 = [[UIView alloc]init];
    self.lineView2 = lineView2;
    lineView2.backgroundColor = COLOR_ff6060;
    lineView2.size = CGSizeMake(DEF_RESIZE_UI(DEF_DEVICE_WIDTH/2), DEF_RESIZE_UI(2));
    lineView2.center = CGPointMake(DEF_DEVICE_WIDTH*0.75, mainHeadView.height-DEF_RESIZE_UI(2));
    [mainHeadView addSubview:lineView2];
    self.artistType = @"0";
    recoBtn.selected = YES;
    newPerBtn.selected = NO;
    lineView1.alpha = 1;
    lineView2.alpha = 0;
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
    
    [toolbarView addSubview:screenBtn];
    
}
- (void)screenBtnClick{
    //跳转艺术家筛选控制器
    ArtistScreeningViewController *screenVC = [[ArtistScreeningViewController alloc]init];
    [self.navigationController pushViewController:screenVC animated:YES];
    
}


#pragma mark - 搜索按钮的点击

-(void)searchBtnClick{
    SearchViewController *searVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_RESIZE_UI(200);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
