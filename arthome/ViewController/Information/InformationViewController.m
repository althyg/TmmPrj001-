//
//  InformationViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView * infoWebView ;

@end

@implementation InformationViewController

-(void)viewDidLoad{
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self netWorkRequst];
}

//初始化UI
-(void)initUI{
    self.navigationItem.title=@"资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView * infoWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH , DEF_DEVICE_HEIGHT-44)];
    infoWebView.opaque = NO;
    infoWebView.backgroundColor = [UIColor clearColor];
    infoWebView.delegate=self;
   [self.view addSubview:infoWebView];
   self.infoWebView=infoWebView;
}

-(void)back{
     [self.infoWebView goBack];
}

-(void)netWorkRequst{
    [self.infoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:INFORMATIONURL]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]];
}

#pragma mark - webViewDelegate
//当web开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [ATUtility showMBProgress:self.view];
}
//当web完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [ATUtility hideMBProgress:self.view];
    if ( self.infoWebView.canGoBack) {
            self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTitle:@"返回" target:self action:@selector(back)];
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}
//当web加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   [ATUtility hideMBProgress:self.view];
    [ATUtility showTipMessage:@"加载失败"];
}

- (void)dealloc
{
    self.infoWebView.delegate = nil;
    [self.infoWebView loadHTMLString: @"" baseURL: nil];
    [self.infoWebView stopLoading];
    [self.infoWebView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
