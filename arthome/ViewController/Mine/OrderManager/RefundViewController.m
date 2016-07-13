//
//  RefundViewController.m
//  arthome
//
//  Created by 海修杰 on 16/6/1.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "RefundViewController.h"
#import "UIPlaceholderTextView.h"

@interface RefundViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIPlaceHolderTextView * placeTV ;

@property (nonatomic,strong) UILabel * numLb ;

@property (nonatomic,strong) UIButton * uploadBtn ;

@property (nonatomic,strong) UIImage * refundImg ;

@property (nonatomic,copy) NSString * refundUrl;

@property (nonatomic,copy) NSString * reason;

@property (nonatomic,copy) NSString * explain;

@property (nonatomic,strong) UITextField * typeTF ;

@property (nonatomic,strong) UITextField * reasonTF ;

@property (nonatomic,strong) UITextField * amountTF ;

@property (nonatomic,strong) UIImagePickerController * imagePickerController ;

@end

@implementation RefundViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 提交按钮的点击
-(void)submitBtnClick{
    self.explain = self.placeTV.text;
    NSDictionary * dic = [NSDictionary dictionary];
    if (self.reason.length) {
        if (!self.refundImg) {
            dic = @{
                    @"orderId":self.orderId,
                    @"type" :self.type,
                    @"reason" :self.reason,
                    @"amount" :self.amount,
                    @"explain":self.explain
                    };
            
        }
        else{
            dic = @{
                    @"pics" :@{
                            self.refundUrl :self.refundImg
                            },
                    @"orderId":self.orderId,
                    @"type" :self.type,
                    @"reason" :self.reason,
                    @"amount" :self.amount,
                    @"explain":self.explain
                    };
    }
          [self mineRefundUploadHttpRequestWithDictionary:dic];
        }
    else{
        [ATUtility showTipMessage:@"请选择退款原因"];
    }
}
/**
 *  申请退款上传资料网络请求
 */
-(void)mineRefundUploadHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineRefundUploadWithParametersDic:dic success:^(NSDictionary *result) {
         [ATUtility hideMBProgress:self.view];
         [ATUtility showTipMessage:result[@"message"]];
        if ([result[@"code"] integerValue] == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
#pragma mark - 上传图片按钮的点击
-(void)uploadBtnClick{
    [self.view endEditing:YES];
    UIActionSheet * sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    sheetView.tag = 1001;
    [sheetView showInView:self.view];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * refundImage = info[@"UIImagePickerControllerEditedImage"];
    
    self.refundImg = refundImage;
    
    self.refundUrl = [ATUtility ret32bitString];
  
    [self.uploadBtn setImage:refundImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1001) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (buttonIndex<2) {
            switch (buttonIndex) {
                case 0:
                {
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            self.imagePickerController = imagePickerController;
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
    else if(actionSheet.tag==1002){
        switch (buttonIndex) {
            case 0:
                self.type = @"0";
                self.typeTF.text = @"我要退款";
                break;
            case 1:
                self.type = @"1";
                 self.typeTF.text = @"我要退货";
                break;
            default:
                break;
        }
    }
    else if(actionSheet.tag==1003){
        switch (buttonIndex) {
            case 0:
                self.reason = @"0";
                self.reasonTF.text = @"仿品";
                break;
            case 1:
                self.reason = @"1";
                self.reasonTF.text = @"有破损";
                break;
            case 2:
                self.reason = @"2";
                self.reasonTF.text = @"物非所述";
                break;
                
            default:
                break;
        }
    }
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIBarButtonItem * cancelBarButtonItem = [UIBarButtonItem barBtnItemWithTitle:@"取消" target:self action:@selector(cancelBtnClick)];
    viewController.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

-(void)choseBtn1Click{
    UIActionSheet * sheetView = [[UIActionSheet alloc]initWithTitle:@"退款类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我要退款",@"我要退货",nil];
    sheetView.tag = 1002;
    [sheetView showInView:self.view];
}

-(void)cancelBtnClick{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)choseBtn2Click{
    UIActionSheet * sheetView = [[UIActionSheet alloc]initWithTitle:@"退款原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"仿品",@"有破损",@"物非所述",nil];
    sheetView.tag = 1003;
    [sheetView showInView:self.view];
}

-(void)initUI{
    self.navigationItem.title = @"申请退款";
    self.view.backgroundColor = [UIColor whiteColor];
    //
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    //退款类型
    UIView * typeView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(40))];
    typeView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:typeView];
    
    UIButton *choseBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    choseBtn1.frame = CGRectMake(typeView.width-DEF_RESIZE_UI(40), 0, DEF_RESIZE_UI(40), DEF_RESIZE_UI(40));
    [choseBtn1 setImage:DEF_IMAGENAME(@"mine_arrow_down") forState:UIControlStateNormal];
    [choseBtn1 addTarget:self action:@selector(choseBtn1Click) forControlEvents:UIControlEventTouchUpInside];
    [typeView addSubview:choseBtn1];
    
    UILabel *nowPwdLb = [[UILabel alloc]init];
    nowPwdLb.textAlignment = NSTextAlignmentLeft;
    nowPwdLb.textColor = COLOR_999999;
    nowPwdLb.font = DEF_MyFont(14);
    nowPwdLb.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(60), DEF_RESIZE_UI(40));
    nowPwdLb.text = @"退款类型";
    [typeView addSubview:nowPwdLb];
    
    UILabel * starLb1= [[UILabel alloc]init];
    starLb1.text = @"*";
    starLb1.textColor = COLOR_ff6060;
    starLb1.font = DEF_MyFont(10);
    starLb1.contentMode = UIViewContentModeTop;
    starLb1.frame = CGRectMake(CGRectGetMaxX(nowPwdLb.frame), 0, DEF_RESIZE_UI(5), DEF_RESIZE_UI(40));
    [typeView addSubview:starLb1];
    
    UITextField *typeTF = [[UITextField alloc]init];
    self.typeTF = typeTF;
    if ([self.type integerValue]) {
        typeTF.text = @"我要退货";
    }
    else{
        typeTF.text = @"我要退款";
    }
    typeTF.userInteractionEnabled = NO;
    typeTF.textColor = COLOR_333333;
    typeTF.font = DEF_MyFont(13);
    typeTF.frame = CGRectMake(CGRectGetMaxX(starLb1.frame)+DEF_RESIZE_UI(30), 0, DEF_RESIZE_UI(200), DEF_RESIZE_UI(40));
    [typeView addSubview:typeTF];
    
    //退款原因
    UIView *reasonView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(typeView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(40))];
    reasonView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:reasonView];
    
    UIButton *choseBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    choseBtn2.frame = CGRectMake(typeView.width-DEF_RESIZE_UI(40), 0, DEF_RESIZE_UI(40), DEF_RESIZE_UI(40));
    [choseBtn2 setImage:DEF_IMAGENAME(@"mine_arrow_down") forState:UIControlStateNormal];
    [choseBtn2 addTarget:self action:@selector(choseBtn2Click) forControlEvents:UIControlEventTouchUpInside];
    [reasonView addSubview:choseBtn2];
    
    UILabel *newPwdLb = [[UILabel alloc]init];
    newPwdLb.textAlignment = NSTextAlignmentLeft;
    newPwdLb.textColor = COLOR_999999;
    newPwdLb.font = DEF_MyFont(14);
    newPwdLb.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(60), DEF_RESIZE_UI(40));
    newPwdLb.text = @"退款原因";
    [reasonView addSubview:newPwdLb];
    
    UILabel * starLb2= [[UILabel alloc]init];
    starLb2.text = @"*";
    starLb2.textColor = COLOR_ff6060;
    starLb2.font = DEF_MyFont(10);
    starLb2.contentMode = UIViewContentModeTop;
    starLb2.frame = CGRectMake(CGRectGetMaxX(newPwdLb.frame), 0, DEF_RESIZE_UI(5), DEF_RESIZE_UI(40));
    [reasonView addSubview:starLb2];
    
    UITextField *reasonTF = [[UITextField alloc]init];
    self.reasonTF = reasonTF;
    reasonTF.userInteractionEnabled = NO;
    reasonTF.text = @"请选择退款原因";
    reasonTF.textColor = COLOR_333333;
    reasonTF.font = DEF_MyFont(13);
    reasonTF.frame = CGRectMake(CGRectGetMaxX(starLb2.frame)+DEF_RESIZE_UI(30), 0, DEF_RESIZE_UI(200), DEF_RESIZE_UI(40));
    [reasonView addSubview:reasonTF];
    
    //退款金额
    UIView *amountView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(reasonView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(40))];
    amountView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:amountView];
    
    UILabel *affPwdLb = [[UILabel alloc]init];
    affPwdLb.textAlignment = NSTextAlignmentLeft;
    affPwdLb.textColor = COLOR_999999;
    affPwdLb.font = DEF_MyFont(14);
    affPwdLb.frame = CGRectMake(DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(60), DEF_RESIZE_UI(40));
    affPwdLb.text = @"退款金额";
    [amountView addSubview:affPwdLb];
    
    UITextField *amountTF = [[UITextField alloc]init];
    self.amountTF = amountTF;
    amountTF.text = self.amount;
    amountTF.userInteractionEnabled = NO;
    amountTF.textColor = COLOR_ff6060;
    amountTF.font = DEF_MyFont(13);
    amountTF.frame = CGRectMake(CGRectGetMaxX(affPwdLb.frame)+DEF_RESIZE_UI(35), 0, DEF_RESIZE_UI(200), DEF_RESIZE_UI(40));
    [amountView addSubview:amountTF];
    
    UIPlaceHolderTextView *feedTV = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(amountView.frame)+DEF_RESIZE_UI(10), DEVICE_WIDTH-2*DEF_RESIZE_UI(10), 100)];
    self.placeTV=feedTV;
    feedTV.delegate=self;
    feedTV.font=DEF_MyFont(13);
    feedTV.backgroundColor = COLOR_f2f2f2;
    feedTV.placeholderColor=COLOR_cccccc;
    feedTV.placeholder=@"请输入退款说明";
    [mainScr addSubview:feedTV];
    
    UILabel * wordNumLb=[[UILabel alloc]init];
    self.numLb=wordNumLb;
    wordNumLb.font=DEF_MyFont(11);
    wordNumLb.textColor=COLOR_cccccc;
    wordNumLb.text=@"0/200字";
    CGFloat numW=80;
    CGFloat numH=20;
    wordNumLb.textAlignment=NSTextAlignmentCenter;
    wordNumLb.frame=CGRectMake(CGRectGetMaxX(feedTV.frame)-numW, CGRectGetMaxY(feedTV.frame)-numH-5, numW, numH);
    [mainScr addSubview:wordNumLb];
    
    //上传图片
    UIButton * uploadBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    self.uploadBtn = uploadBtn;
    uploadBtn.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(feedTV.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(80), DEF_RESIZE_UI(80));
    [uploadBtn setImage:DEF_IMAGENAME(@"mine_refund_upload") forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:uploadBtn];
    
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    submitBtn.backgroundColor = COLOR_ff6060;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = DEF_MyFont(16);
    submitBtn.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(uploadBtn.frame)+DEF_RESIZE_UI(40), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(40));
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:submitBtn];
    
    self.placeTV.text = @"";
}


- (void)textViewDidChange:(UITextView *)textView{
    NSString * countStr=[NSString stringWithFormat:@"%zd/200字",textView.text.length ];
    self.numLb.text=countStr;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
