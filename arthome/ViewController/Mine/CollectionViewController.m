//
//  CollectionViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/25.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectCell.h"
#import "ArtWorksViewController.h"

@interface CollectionViewController ()

@property (nonatomic,strong) NSMutableArray * collections ;

@end

@implementation CollectionViewController

-(NSMutableArray *)collections{
    if (!_collections) {
        _collections=[NSMutableArray array];
    }
    return _collections;
}

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = DEF_RESIZE_UI(95);
    NSDictionary *dic = @{
                          @"imgsize" : @"150x150"
                          };
    [self minecollectionWithParametersDic:dic];
}

/**
 收藏网络请求
 */
-(void)minecollectionWithParametersDic:(NSDictionary *)dic{
    [RequestManager minecollectionWithParametersDic:dic success:^(NSDictionary *result) {
        if (200==[result[@"code"] integerValue]){
            NSArray *lisArr = result[@"collections"];
            if (lisArr.count!=0) {
                self.collections = [NSMutableArray arrayWithArray:[Collection collectionGroupFromJosnArray:lisArr]] ;
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
    return self.collections.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectCell * cell = [CollectCell collectionCellFromTableView:tableView];
    Collection *collection = self.collections[indexPath.row];
    cell.collection = collection;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Collection *collection = self.collections[indexPath.row];
    ArtWorksViewController *workVc = [[ArtWorksViewController alloc]init];
    workVc.artId = collection.artId;
    [self.navigationController pushViewController:workVc animated:YES];
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
