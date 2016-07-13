//
//  FocusViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/25.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FocusViewController.h"
#import "FocusCell.h"
#import "ArtistDetailViewController.h"

@interface FocusViewController ()

@property (nonatomic,strong) NSMutableArray * focuses ;

@end

@implementation FocusViewController

-(NSMutableArray *)focuses{
    if (!_focuses) {
        _focuses=[NSMutableArray array];
    }
    return _focuses;
}

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    NSDictionary * dic = @{
                           @"imgsize" : @"100x100"
                           };
    self.tableView.rowHeight = 75.0;
    [self minefocusWithParametersDic:dic];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
关注网络请求
 */
-(void)minefocusWithParametersDic:(NSDictionary *)dic{
    [RequestManager minefocusWithParametersDic:dic success:^(NSDictionary *result) {
        if (200==[result[@"code"] integerValue]){
            NSArray *lisArr = result[@"artists"];
            if (lisArr.count==0) {
                self.view.backgroundColor=COLOR_f2f2f2;
                UIImageView *noneImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_none_collections")];
                noneImgView.size = CGSizeMake(DEF_RESIZE_UI(112), DEF_RESIZE_UI(148));
                noneImgView.center = CGPointMake(DEF_DEVICE_WIDTH*0.5, DEF_RESIZE_UI(240));
                [self.view addSubview:noneImgView];
            }
            else{
                self.focuses = [NSMutableArray arrayWithArray:[Focus focusGroupFromJosnArray:lisArr]] ;
                [self.tableView reloadData];
            }
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.focuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FocusCell * cell = [FocusCell focusCellFromTableView:tableView];
    cell.focus = self.focuses[indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Focus * focus = self.focuses[indexPath.row];
    ArtistDetailViewController *artistVc = [[ArtistDetailViewController alloc]init];
    artistVc.artistId = focus.artistId;
    [self.navigationController pushViewController:artistVc animated:YES];
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
