//
//  SysSettingViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "SysSettingViewController.h"
#import "FeedBackViewController.h"
#import "LoginViewController.h"
#import "AboutAppController.h"

@interface SysSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView * tableView ;

@property (nonatomic,strong) UILabel * arrowLabel ;

@property (nonatomic,strong) UILabel * lbCache ;


@end

@implementation SysSettingViewController

-(void)viewDidLoad{
    self.navigationItem.title = @"设置";
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    UITableView * tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor=COLOR_f2f2f2;
   [mainScr addSubview:tableView];
}

#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.textColor = COLOR_666666;
    cell.textLabel.font=DEF_MyFont(14);
        if (indexPath.row==3){
            cell.textLabel.text=@"清理缓存";
            UILabel *labelView = [[UILabel alloc] init];
            self.lbCache = labelView;
            labelView.frame = CGRectMake(0, 0, 100, 40);
            labelView.textColor=COLOR_RGB(100, 100, 100);
            labelView.textAlignment=NSTextAlignmentRight;
            labelView.font=DEF_MyFont(11);
            CGFloat cacheSize = [SDImageCache sharedImageCache].getSize/1024;//[self.urlCache getCacheFolderSize];
            
            self.lbCache.text = [NSString stringWithFormat:@"%.2f M",cacheSize/1024.0 < 0.08 ? 0 : cacheSize/1024.0];
            cell.accessoryView = labelView;
        }
        else if (indexPath.row==0){
            cell.textLabel.text = @"我要评分";
            UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_arrow_right"]];
            cell.accessoryView = arrowView;

        }
        else if (indexPath.row ==1){
            cell.textLabel.text = @"意见反馈";
            UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_arrow_right"]];
            cell.accessoryView = arrowView;
        }
        else if (indexPath.row==2){
            cell.textLabel.text = @"关于APP";
            UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_arrow_right"]];
            cell.accessoryView = arrowView;
        }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        if ([self.lbCache.text isEqualToString:@"0.00 M"]) {
            [ATUtility showTips:@"软件倍干净，没有一丝残渣"];
        }
        else{
        [self clearCache];
        }
    }
    else if (indexPath.row ==0){
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AT_GRADE_URL]];
    }
    else if(indexPath.row==1){
        FeedBackViewController *feedVc = [[FeedBackViewController alloc]init];
        [self.navigationController pushViewController:feedVc animated:YES];
        
    }
    else if (indexPath.row==2){
        AboutAppController * abAppVc = [[AboutAppController alloc]init];
        [self.navigationController pushViewController:abAppVc animated:YES];
    }
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
}

-(void)notiChangeValue:(UISwitch *) st{
    
}

-(void)readModelChangeValue:(UISwitch *) st{
    
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)clearCache
{
    [ATUtility showMBProgress:self.view message:nil];
    __weak SysSettingViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat cacheSize = [SDImageCache sharedImageCache].getSize/1024;//[self.urlCache getCacheFolderSize];
            weakSelf.lbCache.text = [NSString stringWithFormat:@"%.2f M",cacheSize/1024.0 < 0.08 ? 0 : cacheSize/1024.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.3),dispatch_get_main_queue(), ^{
                [ATUtility hideMBProgress:self.view];
                [ATUtility showTips:@"缓存已清除"];
            });
        });
    });
}


@end
