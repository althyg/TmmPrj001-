//
//  SearchViewController.m
//  arthome
//
//  Created by 海修杰 on 16/5/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "SearchViewController.h"
#import "CollectCell.h"
#import "ArtWorksViewController.h"
#import "ArtistCell.h"
#import "ArtistDetailViewController.h"
#import "ArtWorksViewController.h"
#import "LoginViewController.h"

@interface SearchViewController ()<UIActionSheetDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UISearchBar * searchBar ;

@property (nonatomic,copy) NSString * searchType;

@property (nonatomic,strong) UIBarButtonItem * titleItem ;

@property (nonatomic,strong) UIBarButtonItem * backItem ;

@property (nonatomic,strong) UIBarButtonItem * imgItem ;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,assign) NSInteger curPageIndex;//请求数据页

@property (nonatomic,strong) NSMutableArray * artistArr ;

@property (nonatomic,strong) NSMutableArray * collections ;

@property (nonatomic,copy) NSString * keyword;

@property (nonatomic,assign) BOOL canRefresh;

@property (nonatomic,copy) NSString * isFocused;

@end

@implementation SearchViewController

-(NSMutableArray *)artistArr{
    if (!_artistArr) {
        _artistArr = [NSMutableArray array];
    }
    return _artistArr;
}

-(NSMutableArray *)collections{
    if (!_collections) {
        _collections=[NSMutableArray array];
    }
    return _collections;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar endEditing:YES];
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
    __weak SearchViewController *weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
}

-(void)reloadData{
    self.curPageIndex=1;
    if ([self.searchType isEqualToString:@"艺术品"]) {
        NSDictionary * dic=@{
                             @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                             @"imgsize" :@"150x150",
                             @"keyword" :self.keyword
                             };
        [self artistArtSearchHttpRequestWithDictionary:dic];
    }
    else{
        NSDictionary * dic=@{
                             @"page":[NSString stringWithFormat:@"%zd",self.curPageIndex],
                             @"headSize" :@"70x70",
                             @"artSize" :@"200x200",
                             @"keyword" :self.keyword
                             };
        [self artistArtistSearchHttpRequestWithDictionary:dic];
    }
}

/**
 *  上拉刷新
 */
-(void)setupLoadMore{
    __weak SearchViewController *weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        weakSelf.curPageIndex+=1;
        [weakSelf loadMoreDataWithPage:[NSString stringWithFormat:@"%zd",weakSelf.curPageIndex]];
    }];
    self.tableView.footer.hidden=YES;
}

-(void)loadMoreDataWithPage:(NSString * )page{
    if ([self.searchType isEqualToString:@"艺术品"]) {
        NSDictionary * dic=@{
                             @"page":page,
                             @"imgsize" :@"150x150",
                             @"keyword" :self.keyword
                             };
        [self artistArtSearchHttpRequestWithDictionary:dic];
    }
    else{
        NSDictionary * dic=@{
                             @"page":page,
                             @"headSize" :@"70x70",
                             @"artSize" :@"200x200",
                             @"keyword" :self.keyword
                             };
        [self artistArtistSearchHttpRequestWithDictionary:dic];
    }
}

#pragma mark - 搜索按钮的点击

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.keyword = searchBar.text;
    [self.tableView.header beginRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.searchType isEqualToString:@"艺术品"]) {
        return self.collections.count;
    }
    else{
        return self.artistArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.searchType isEqualToString:@"艺术品"]) {
        CollectCell * cell = [CollectCell collectionCellFromTableView:tableView];
        Collection *collection = self.collections[indexPath.row];
        cell.collection = collection;
        return cell;
    }
    else{
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.searchType isEqualToString:@"艺术品"]) {
     return DEF_RESIZE_UI(95);
    }
    else{
        return DEF_RESIZE_UI(200);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.searchType isEqualToString:@"艺术品"]) {
        Collection *collection = self.collections[indexPath.row];
        ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
        workVc.artId = collection.artId;
        [self.navigationController pushViewController:workVc animated:YES];
    }
    else{
        Artist * artist = self.artistArr[indexPath.row];
        ArtistDetailViewController *detailVc = [[ArtistDetailViewController alloc]init];
        detailVc.artistId = artist.artistId;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma mark - 网络请求

/**
 *  艺术家搜索网络请求
 */
-(void)artistArtistSearchHttpRequestWithDictionary:(NSDictionary *)dic{
   [RequestManager artistArtistSearchWithParametersDic:dic success:^(NSDictionary *result) {
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
           [self.searchBar endEditing:YES];
       }
       [self.tableView.header endRefreshing];
       [self.tableView.footer endRefreshing];

   } failture:^(id result) {
       [self.tableView.header endRefreshing];
       [self.tableView .footer endRefreshing];
   }];
}
/**
 *  艺术品搜索网络请求
 */
-(void)artistArtSearchHttpRequestWithDictionary:(NSDictionary *)dic{
    [RequestManager artistArtSearchWithParametersDic:dic success:^(NSDictionary *result) {
        if (200 ==[result[@"code"] integerValue]) {
            NSArray * listArr = result[@"collections"];
            NSArray * arr=[Collection collectionGroupFromJosnArray:listArr];
            self.canRefresh=[result[@"end"] integerValue];
            if (self.canRefresh) {
                self.tableView.footer.hidden=NO;
            }
            else{
                self.tableView.footer.hidden=YES;
            }
            if (self.curPageIndex==1) {
                [self.collections removeAllObjects];
                self.collections=[NSMutableArray arrayWithArray:arr];
            }
            else{
                [self.collections addObjectsFromArray:[NSMutableArray arrayWithArray:arr]];
            }
            [self.tableView reloadData];
            [self.searchBar endEditing:YES];
        }
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
      
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

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)typeBtnClick{
     [self.searchBar endEditing:YES];
    UIActionSheet *typeSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"艺术品",@"艺术家", nil];
    [typeSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            self.searchType = @"艺术品";
            break;
        case 1:
            self.searchType = @"艺术家";
            break;
        default:
            break;
    }
    self.searchBar.placeholder = [NSString stringWithFormat:@"搜索%@",self.searchType];
    [self.searchBar becomeFirstResponder];
}

-(void)setSearchType:(NSString *)searchType{
    _searchType = searchType;
    UIBarButtonItem * titleItem =[UIBarButtonItem barBtnItemWithTitle:searchType target:self action:@
                     selector(typeBtnClick)];
   self.navigationItem.leftBarButtonItems = @[_backItem,titleItem,_imgItem];
}

-(void)imgBtnClicl{
    UIActionSheet *typeSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"艺术品",@"艺术家", nil];
    [typeSheet showInView:self.view];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.delegate = self;
    searchBar.placeholder = @"搜索作品";
    UIBarButtonItem *backItem = [UIBarButtonItem backItemWithTarget:self action:@selector(back)];
    self.backItem = backItem;
    UIBarButtonItem *titleItem = [UIBarButtonItem barBtnItemWithTitle:@"艺术品" target:self action:@selector(typeBtnClick)];
    self.titleItem = titleItem;
    UIBarButtonItem *imgItem = [UIBarButtonItem barBtnItemWithNmlImg:@"mine_arrow_down" hltImg:@"mine_arrow_down" target:self action:@selector(imgBtnClicl)];
    self.imgItem = imgItem;
    self.navigationItem.leftBarButtonItems = @[backItem,titleItem,imgItem];
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.searchType = @"艺术品";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar endEditing:YES];
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
