//
//  ArtistScreeningViewController.m
//  arthome
//
//  Created by qzwh on 16/7/8.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtistScreeningViewController.h"

@interface ArtistScreeningViewController ()

@end

@implementation ArtistScreeningViewController

- (void)loadView {
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}


#pragma mark - 创建UI界面
- (void)createUI{
    self.navigationItem.title = @"艺术家筛选";
    self.view.backgroundColor=[UIColor colorWithRed:248 green:248 blue:248 alpha:0.8];
    //清空选择按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithPurpleTitle:@"清空选择" target:self action:@selector(cleanOnclick)];
    //美院
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+20, 50, 10)];
    [titleLabel setText:@"美院"];
    [titleLabel setTextColor:[UIColor grayColor]];
    titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:titleLabel];
    
    //几个按钮
    float constant = 15;
    float width = (DEF_DEVICE_WIDTH-4*constant)/3;
    float highth = 26;
    NSArray *btnArr = @[@"中国美术学院",@"中央美术学院",@"鲁迅美术学院",@"西安美术学院",@"广州美术学院",@"天津美术学院",@"湖北美术学院",@"清华美术学院",@"上大美术学院",@"其他"];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(constant, 64+20+20, width, highth);
    //设置边框宽度
    [btn1.layer setBorderWidth:1.0];
    btn1.layer.borderColor=[UIColor grayColor].CGColor;
    [btn1 setTitle:@"中国美术学院" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(constant+width+constant, 64+20+20, width, highth);
    [btn2.layer setBorderWidth:1.0];
    btn2.layer.borderColor=[UIColor grayColor].CGColor;
    [btn2 setTitle:@"中央美术学院" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(constant+width+constant+width+constant, 64+20+20, width, highth);
    [btn3.layer setBorderWidth:1.0];
    btn3.layer.borderColor=[UIColor grayColor].CGColor;
    [btn3 setTitle:@"鲁迅美术学院" forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(constant, 64+20+20+highth+highth, width, highth);
    //设置边框宽度
    [btn4.layer setBorderWidth:1.0];
    btn4.layer.borderColor=[UIColor grayColor].CGColor;
    [btn4 setTitle:@"西安美术学院" forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(constant+width+constant, 64+20+20+highth+highth, width, highth);
    //设置边框宽度
    [btn5.layer setBorderWidth:1.0];
    btn5.layer.borderColor=[UIColor grayColor].CGColor;
    [btn5 setTitle:@"广州美术学院" forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(constant+width+constant+width+constant, 64+20+20+highth+highth, width, highth);
    //设置边框宽度
    [btn6.layer setBorderWidth:1.0];
    btn6.layer.borderColor=[UIColor grayColor].CGColor;
    [btn6 setTitle:@"美术天津学院" forState:UIControlStateNormal];
    btn6.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn7.frame = CGRectMake(constant, 64+20+20+highth+highth+highth+highth, width, highth);
    //设置边框宽度
    [btn7.layer setBorderWidth:1.0];
    btn7.layer.borderColor=[UIColor grayColor].CGColor;
    [btn7 setTitle:@"湖北美术学院" forState:UIControlStateNormal];
    btn7.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn7 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn7 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn8.frame = CGRectMake(constant+width+constant, 64+20+20+highth+highth+highth+highth, width, highth);
    //设置边框宽度
    [btn8.layer setBorderWidth:1.0];
    btn8.layer.borderColor=[UIColor grayColor].CGColor;
    [btn8 setTitle:@"清华美术学院" forState:UIControlStateNormal];
    btn8.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn8 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn8 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn8];
    
    UIButton *btn9 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn9.frame = CGRectMake(constant+width+constant+width+constant, 64+20+20+highth+highth+highth+highth, width, highth);
    //设置边框宽度
    [btn9.layer setBorderWidth:1.0];
    btn9.layer.borderColor=[UIColor grayColor].CGColor;
    [btn9 setTitle:@"上大美术学院" forState:UIControlStateNormal];
    btn9.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn9 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn9 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn9];
    
    UIButton *btn10 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn10.frame = CGRectMake(constant, 64+20+20+highth+highth+highth+highth+highth+highth, width, highth);
    //设置边框宽度
    [btn10.layer setBorderWidth:1.0];
    btn10.layer.borderColor=[UIColor grayColor].CGColor;
    [btn10 setTitle:@"其他" forState:UIControlStateNormal];
    btn10.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn10 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn10 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.view addSubview:btn10];
    
    //所在地区
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 64+20+20+highth+highth+highth+highth+highth+highth+highth+highth, 50, 10)];
    [addLabel setText:@"所在地区"];
    [addLabel setTextColor:[UIColor grayColor]];
    addLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:addLabel];

}
- (void)cleanOnclick{

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
