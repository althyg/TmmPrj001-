//
//  UserRegisterProController.m
//  arthome
//
//  Created by 海修杰 on 16/5/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "UserRegisterProController.h"

@interface UserRegisterProController ()

@end

@implementation UserRegisterProController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用户协议";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *mainWeb = [[UIWebView alloc]init];

    mainWeb.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    
    // pdf在本地路径
    NSURL *pdfUrl = [[NSBundle mainBundle] URLForResource:@"userpro_tem.txt" withExtension:nil];
    
    // URL请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:pdfUrl];
    
    // URL响应对象
    NSURLResponse *response = nil;
    
    // 获取本地文件的二进制
    NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    [mainWeb loadData:fileData MIMEType:response.MIMEType textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@"http://www.88art.com"]];

    [self.view addSubview:mainWeb];
}

@end
