//
//  FunsViewController.m
//  arthome
//
//  Created by 海修杰 on 16/4/25.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FunsViewController.h"
#import "FunsCell.h"

@interface FunsViewController ()

@property (nonatomic,strong) NSMutableArray * funs ;


@end

@implementation FunsViewController

-(NSMutableArray *)funs{
    if (!_funs) {
        _funs=[NSMutableArray array];
    }
    return _funs;
}
- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"粉丝";
    NSDictionary * dic = @{
                           @"imgsize" : @"100x100"
                           };
    [self minefunsWithParametersDic:dic];
    self.tableView.rowHeight = 75.0;
}

/**
 关注网络请求
 */
-(void)minefunsWithParametersDic:(NSDictionary *)dic{
    [RequestManager minefunsWithParametersDic:dic success:^(NSDictionary *result) {
        if (200==[result[@"code"] integerValue]){
           NSArray *lisArr = result[@"funs"];
           self.funs = [NSMutableArray arrayWithArray:[Funs funsGroupFromJosnArray:lisArr]] ;
            [self.tableView reloadData];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FunsCell *cell = [FunsCell funsCellFromTableView:tableView];
    cell.funs = self.funs[indexPath.row];
    return cell;

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
