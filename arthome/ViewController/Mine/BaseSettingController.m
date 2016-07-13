//
//  BaseSettingController.m
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "BaseSettingController.h"
#import "PhoneBindingViewController.h"

@interface BaseSettingController ()

/**
 *  所有组
 */
@property (nonatomic,strong) NSMutableArray *groups;

@end

@implementation BaseSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置每一组的头部高度
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSArray *)groups {
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - 数据源方法

/**
 *  有多少组数据
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

/**
 *  每一组显示多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 1.根据section获得组模型
    SettingGroup *group = self.groups[section];
    return group.items.count;
}

/**
 *  每一行显示怎样的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 0.创建cell
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    // 1.根据section获得组模型
    SettingGroup *group = self.groups[indexPath.section];
    // 2.根据row获得item
    SettingItem *item = group.items[indexPath.row];
    // 3.赋值数据
    cell.item = item;
    // 4.判断是否隐藏分割线
    //cell.showLine = (indexPath.row != group.items.count - 1);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 根据section获得组模型
    SettingGroup *group = self.groups[indexPath.section];
    // 根据row获得item
    SettingItem *item = group.items[indexPath.row];
    
    if ([item isKindOfClass:[SettingItemArrow class]]) {
       SettingItemArrow *arrow = (SettingItemArrow *)item;
        // 取出目标控制器
        Class destVc = arrow.destVc;
        // 创建控制器
        UIViewController *vc = [[destVc alloc] init];
        // 设置目标控制的标题
        vc.title = item.title;
        if ([vc isKindOfClass:[PhoneBindingViewController class]]&&[[ATUserInfo shareUserInfo].phoneBind integerValue]){
//            [ATUtility showTipMessage:@"该账号已经绑定手机号"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
        [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if ([item isKindOfClass:[SettingLabelArrow class]]){
       SettingLabelArrow *arrow = (SettingLabelArrow *)item;
        // 取出目标控制器
        Class destVc = arrow.destVc;
        // 创建控制器
        UIViewController *vc = [[destVc alloc] init];
        // 设置目标控制的标题
        vc.title = item.title;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
     [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
}
/**
 *  返回section组对应头部描述
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // 1.根据section获得对应的组模型
    SettingGroup *group = self.groups[section];
    return group.headerTitle;
}
/**
 *  返回section组对应尾部描述
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // 1.根据section获得对应的组模型
    SettingGroup *group = self.groups[section];
    return group.footerTitle;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return DEF_RESIZE_UI(44);
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
@end
