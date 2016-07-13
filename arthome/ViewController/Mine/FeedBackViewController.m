//
//  FeedBackViewController.m
//  weike
//
//  Created by CaiMiao on 15/10/19.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIPlaceholderTextView.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property(nonatomic,weak) UILabel * numLb;

@property(nonatomic,weak) UIPlaceHolderTextView * placeTV;

@property (nonatomic,strong) UITextField * numTF ;


@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 提交按钮的点击

-(void)submitBtnClick{
    if (self.placeTV.text.length&&self.numTF.text) {
        NSDictionary *dic = @{
                              @"content" : self.placeTV.text,
                              @"contackway" : self.numTF.text
                              };
        [self mineFeedBackHttpRequestWithDictionary:dic];
    }
    else{
        [ATUtility showTipMessage:WRONGINFOMATION];
    }
   
}
/**
 *  意见反馈网络请求
 */
-(void)mineFeedBackHttpRequestWithDictionary:(NSDictionary *)dic{
    if ([ATUtility isConnectionAvailable]) {
        [ATUtility showMBProgress:self.view];
        [RequestManager mineFeedBackWithParametersDic:dic success:^(NSDictionary *result) {
                [ATUtility hideMBProgress:self.view];
                [ATUtility showTipMessage:result[@"message"]];
        } failture:^(id result) {
            [ATUtility hideMBProgress:self.view];
        }];
    }
    else{
        [ATUtility showTipMessage:WRONGCONNECTION];
    }
    
}

-(void)initUI{
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithTitle:@"提交" target:self action:@selector(submitBtnClick)];
    self.view.backgroundColor = COLOR_f2f2f2;
    self.navigationItem.title = @"意见反馈";
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.backgroundColor = COLOR_f2f2f2;
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    UILabel * tipLabel=[[UILabel alloc]init];
    CGFloat padding=DEF_RESIZE_UI(10);
    tipLabel.frame=CGRectMake(padding, DEF_RESIZE_UI(20), DEVICE_WIDTH, DEF_RESIZE_UI(10));
    tipLabel.text=@"感谢您的宝贵意见和建议,这将是我们不断改善与成长的动力!";
    tipLabel.font=DEF_MyFont(13);
    tipLabel.textColor=COLOR_999999;
    [mainScr addSubview:tipLabel];
    
    UIPlaceHolderTextView *feedTV = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(tipLabel.frame)+DEF_RESIZE_UI(20), DEVICE_WIDTH-2*padding, 150)];
    self.placeTV=feedTV;
    feedTV.delegate=self;
    feedTV.font=DEF_MyFont(14);
    feedTV.placeholderColor=COLOR_cccccc;
    feedTV.placeholder=@"请输入您想反馈的问题";
    [mainScr addSubview:feedTV];
    
    UILabel * wordNumLb=[[UILabel alloc]init];
    self.numLb=wordNumLb;
    wordNumLb.font=DEF_MyFont(14);
    wordNumLb.textColor=COLOR_666666;
    wordNumLb.text=@"0/120字";
    CGFloat numW=80;
    CGFloat numH=20;
    wordNumLb.textAlignment=NSTextAlignmentCenter;
    wordNumLb.frame=CGRectMake(CGRectGetMaxX(feedTV.frame)-numW, CGRectGetMaxY(feedTV.frame)-numH-5, numW, numH);
    [mainScr addSubview:wordNumLb];
    
    UITextField * numTF = [[UITextField alloc]init];
    self.numTF = numTF;
    numTF.backgroundColor = [UIColor whiteColor];
    numTF.placeholder = @"邮箱/QQ";
    numTF.font = DEF_MyFont(14);
    numTF.frame = CGRectMake(padding, CGRectGetMaxY(wordNumLb.frame)+DEF_RESIZE_UI(20), DEVICE_WIDTH-2*padding, DEF_RESIZE_UI(40));
    [mainScr addSubview:numTF];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.placeTV becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{
    NSString * countStr=[NSString stringWithFormat:@"%zd/120字",textView.text.length ];
    self.numLb.text=countStr;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
