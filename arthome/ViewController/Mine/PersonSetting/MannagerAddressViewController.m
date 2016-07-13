//
//  MannagerAddressViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "MannagerAddressViewController.h"
#import "CreatNewAddreesController.h"

@interface MannagerAddressViewController ()

@end

@implementation MannagerAddressViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"地址管理";
    self.view.backgroundColor = COLOR_ffffff;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(100, 100, 20,20 );
    [self.view addSubview:addBtn];

}

-(void)addBtnClick{
    CreatNewAddreesController *newMaVc = [[CreatNewAddreesController alloc]init];
    [self.navigationController pushViewController:newMaVc animated:YES];
}

@end
