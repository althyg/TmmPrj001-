//
//  InfoSettingViewController.m
//  arthome
//
//  Created by 海修杰 on 16/3/16.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "InfoSettingViewController.h"
#import "Province.h"

@interface InfoSettingViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,copy) NSString * sex;

@property (nonatomic,strong) UITextField * brithField ;

@property (nonatomic,strong) UITextField * provinceField ;

@property (nonatomic,strong) UILabel * sexField ;

@property (nonatomic,strong) UIDatePicker * datePicker;

@property (nonatomic,strong) UIPickerView * pickerView;

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,copy) NSString * cityCode;

@property (nonatomic,strong) UIButton * headBtn ;

@property (nonatomic,copy) NSString * imgPath;

@property (nonatomic,strong) UITextField * nameTF ;

@property (nonatomic,strong) UIImage * headImage ;

@property (nonatomic,copy) NSString * headImgUrl;

@property (nonatomic,strong) NSData * headImgData ;

@property (nonatomic,strong) UIImagePickerController * imagePickerController;
/**
 *  记录当前选中的省份
 */
@property (nonatomic,strong) Province * selectedProinvce;
/**
 *  所有省市
 */
@property (nonatomic,strong) NSArray * provinces;

@end

@implementation InfoSettingViewController

- (NSArray *)provinces {
    if (_provinces == nil) {
        _provinces = [Province provinces];
    }
    return _provinces;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    NSDictionary * dic = @{
                           @"headSize" : @"160x160"
                           };
    [self mineInfoDownloadHttpRequestWithDictionary:dic];
}

#pragma mark - 保存按钮的点击

-(void)saveBtnClick{
    if (!self.cityCode.length) {
        self.cityCode = @"110100";
    }
    NSDictionary * dic = [NSDictionary dictionary];
    if (!self.headImage) {
        dic = @{
                @"nickName" : self.nameTF.text,
                @"sex": self.sex,
                @"birthday": self.brithField.text,
                @"location": self.cityCode
                };
    }
    else{
        dic = @{
                @"pics" :@{
                        self.headImgUrl :self.headImage
                        },
                @"nickName" : self.nameTF.text,
                @"sex": self.sex,
                @"birthday": self.brithField.text,
                @"location": self.cityCode
                };
    }

      [self mineInfoUploadHttpRequestWithDictionary:dic];
}

/**
 *  用户资料上传网络接口
 */
-(void)mineInfoUploadHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineInfoUploadWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        [ATUtility showTipMessage:result[@"message"]];
        if ([result[@"code"] integerValue] == 200) {
            NSString * imgPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            imgPath = [imgPath stringByAppendingPathComponent:@"headImage"];
            [self.headImgData writeToFile:imgPath atomically:YES];
            ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
            userInfo.nickName = self.nameTF.text;
            [userInfo saveAccountToSandBox];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
/**
 *  用户资料下载网络接口
 */
-(void)mineInfoDownloadHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineInfoDownloadWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            [self.headBtn sd_setImageWithURL:[NSURL URLWithString:result[@"headUrl"]] forState:UIControlStateNormal placeholderImage:DEF_IMAGENAME(@"mine_head_80")];
            self.nameTF.text = result[@"nickName"];
            self.sex = result[@"sex"];
            self.brithField.text = result[@"birthday"];
            self.provinceField.text = result[@"location"];
            self.cityCode = result[@"cityCode"];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

#pragma mark - 头像按钮的点击

-(void)headBtnBtnClick{
    UIActionSheet * sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",nil];
    sheetView.tag = 1006;
    [sheetView showInView:self.view];
}

-(void)sexTapGesture{
    UIActionSheet * sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
    sheetView.tag = 1007;
    [sheetView showInView:self.view];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * headImage = info[@"UIImagePickerControllerEditedImage"];
    self.headImage = headImage;
    self.headImgUrl = [ATUtility ret32bitString];
    [self.headBtn setImage:headImage forState:UIControlStateNormal];
    //缓存在本地
    NSData *headImgData = UIImagePNGRepresentation(headImage);
    self.headImgData = headImgData;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1006) {
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
    else {
        if (buttonIndex<2) {
            switch (buttonIndex) {
                case 0:
                    self.sex = @"0";
                    break;
                case 1:
                   self.sex = @"1";
                     break;
                default:
                    break;
            }
        }
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
          UIBarButtonItem * cancelBarButtonItem = [UIBarButtonItem barBtnItemWithTitle:@"取消" target:self action:@selector(cancelBtnClick)];
    viewController.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

-(void)cancelBtnClick{
      [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        // 不用设置尺寸
        _datePicker = [[UIDatePicker alloc] init];
        // 设置地区
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        // 设置显示模式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        
        _datePicker.maximumDate = [NSDate date];
        
        _datePicker.backgroundColor = [UIColor whiteColor];
        
     [_datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

-(void)valueChanged:(UIDatePicker *)sender{
    
    self.brithField.text = [self stringFromDate:[self.datePicker date]];
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//pickerViewDateSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        return self.provinces.count;
    } else {
        NSInteger pRow = [pickerView selectedRowInComponent:0];
        Province *p =  self.provinces[pRow];
        return p.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        Province *p =  self.provinces[row];
        return p.name;
    } else {
        // 获得第0列选中行号
        NSInteger pRow = [pickerView selectedRowInComponent:0];
        // 取出对应行号的模型
        Province *p =  self.provinces[pRow];
        if (p.cities.count <= row) return nil;
        // 返回第row行对应的城市名字
        City *city = (City *)p.cities[row];
        return city.name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        // 刷新第一个数据
        [pickerView reloadComponent:1];
        // 默认选中第一列的第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        self.selectedProinvce = self.provinces[row];
    }
    // 获得城市的名字
    City *city  = (City *)self.selectedProinvce.cities[(component == 0)? 0:row];
    self.cityCode = city.code;
   self.provinceField.text = [NSString stringWithFormat:@"%@ %@",self.selectedProinvce.name,city.name];
}
-(void)setSex:(NSString *)sex{
    _sex = sex;
    if ([sex integerValue] == 0) {
        self.sexField.text = @"男";
    }
    else{
        self.sexField.text = @"女";
    }
}
#pragma mark - 初始化UI

-(void)initUI{
    self.navigationItem.title = @"资料设置";
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    self.mainScr = mainScr;
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    mainScr.userInteractionEnabled = YES;
    [self.view addSubview:mainScr];
    
    //headBg
    UIView * headBgView = [[UIView alloc]init];
    headBgView.backgroundColor = COLOR_f2f2f2;
    headBgView.layer.borderColor = COLOR_cccccc.CGColor;
    headBgView.layer.borderWidth = 1;
    headBgView.frame = CGRectMake(DEF_RESIZE_UI(50), DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60), DEF_RESIZE_UI(80));
    [mainScr addSubview:headBgView];
    //tipLb
    UILabel *tip1Lb = [[UILabel alloc]init];
    tip1Lb.textAlignment = NSTextAlignmentLeft;
    tip1Lb.text = @"更换头像";
    tip1Lb.font = DEF_MyFont(15);
    tip1Lb.textColor = COLOR_999999;
    tip1Lb.frame = CGRectMake(DEF_RESIZE_UI(50), 0, DEF_RESIZE_UI(100), DEF_RESIZE_UI(80));
    [headBgView addSubview:tip1Lb];
    
    UIButton * headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headBtn = headBtn;
    [headBtn setImage:DEF_IMAGENAME(@"mine_head_80") forState:UIControlStateNormal];
    headBtn.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(80), DEF_RESIZE_UI(80));
    headBtn.imageView.contentMode = UIViewContentModeScaleToFill;
    headBtn.layer.cornerRadius = DEF_RESIZE_UI(40);
    headBtn.layer.masksToBounds = YES;
    [headBtn addTarget:self action:@selector(headBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:headBtn];
    
    CGFloat titleLbW = DEF_RESIZE_UI(100);
    CGFloat titleTFW = DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)- titleLbW;
    CGFloat rowH = DEF_RESIZE_UI(44);
    
    //姓名
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(headBgView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    nameView.layer.borderWidth = 1;
    nameView.layer.borderColor = COLOR_cccccc.CGColor;
    nameView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:nameView];
    
    UILabel *nameLb = [[UILabel alloc]init];
    nameLb.textAlignment = NSTextAlignmentLeft;
    nameLb.textColor = COLOR_999999;
    nameLb.font = DEF_MyFont(12);
    nameLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    nameLb.text = @"姓名";
    [nameView addSubview:nameLb];
    
    UITextField *nameTF = [[UITextField alloc]init];
    self.nameTF = nameTF;
    nameTF.placeholder = @"姓名";
    nameTF.textColor = COLOR_333333;
    nameTF.font = DEF_MyFont(12);
    nameTF.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, DEF_RESIZE_UI(44));
    [nameView addSubview:nameTF];

    //所在城市
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(nameView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    addressView.layer.borderWidth = 1;
    addressView.layer.borderColor = COLOR_cccccc.CGColor;
    addressView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:addressView];
    
    UILabel *addressLb = [[UILabel alloc]init];
    addressLb.textAlignment = NSTextAlignmentLeft;
    addressLb.textColor = COLOR_999999;
    addressLb.font = DEF_MyFont(12);
    addressLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    addressLb.text = @"所在城市";
    [addressView addSubview:addressLb];
    
    UITextField *provinceField = [[UITextField alloc]init];
    self.provinceField = provinceField;
    provinceField.placeholder = @"北京-北京市";
    provinceField.textColor = COLOR_333333;
    provinceField.font = DEF_MyFont(12);
    provinceField.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, rowH);
    [addressView addSubview:provinceField];
    
    UIImageView *addressImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_arrow_down")];
    addressImgView.contentMode = UIViewContentModeCenter;
    addressImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)-DEF_RESIZE_UI(26), 0, DEF_RESIZE_UI(12), rowH);
    [addressView addSubview:addressImgView];
    //出生年月
    UIView *birthView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(addressView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    birthView.layer.borderWidth = 1;
    birthView.layer.borderColor = COLOR_cccccc.CGColor;
    birthView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:birthView];
    
    UILabel *birthLb = [[UILabel alloc]init];
    birthLb.textAlignment = NSTextAlignmentLeft;
    birthLb.textColor = COLOR_999999;
    birthLb.font = DEF_MyFont(12);
    birthLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    birthLb.text = @"出身年月";
    [birthView addSubview:birthLb];
    
    UITextField *brithField = [[UITextField alloc]init];
    self.brithField = brithField;
    brithField.placeholder = @"北京-北京市";
    brithField.textColor = COLOR_333333;
    brithField.font = DEF_MyFont(12);
    brithField.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, rowH);
    [birthView addSubview:brithField];
    
    UIImageView *brithImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_arrow_down")];
    brithImgView.contentMode = UIViewContentModeCenter;
    brithImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)-DEF_RESIZE_UI(26), 0, DEF_RESIZE_UI(12), rowH);
    [birthView addSubview:brithImgView];
    
    //性别
    UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(birthView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    sexView.userInteractionEnabled = YES;
    sexView.layer.borderWidth = 1;
    sexView.layer.borderColor = COLOR_cccccc.CGColor;
    sexView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:sexView];
    
    UILabel *sexLb = [[UILabel alloc]init];
    sexLb.textAlignment = NSTextAlignmentLeft;
    sexLb.textColor = COLOR_999999;
    sexLb.font = DEF_MyFont(12);
    sexLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    sexLb.text = @"性别";
    [sexView addSubview:sexLb];
    
    UILabel *sexField = [[UILabel alloc]init];
    self.sexField = sexField;
    sexField.userInteractionEnabled = YES;
    sexField.textColor = COLOR_333333;
    sexField.font = DEF_MyFont(12);
    sexField.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, rowH);
    UITapGestureRecognizer *sexTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexTapGesture)];
    [sexField addGestureRecognizer:sexTapGesture];
    [birthView addSubview:brithField];
    [sexView addSubview:sexField];
    
    UIImageView *sexImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_arrow_down")];
    sexImgView.contentMode = UIViewContentModeCenter;
    sexImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)-DEF_RESIZE_UI(26), 0, DEF_RESIZE_UI(12), rowH);
    [sexView addSubview:sexImgView];
    
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = COLOR_ff6060;
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = DEF_MyFont(16);
    saveBtn.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(94)-DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44));
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:saveBtn];
    
    self.brithField.inputView = self.datePicker;
    self.provinceField.inputView = self.pickerView;
    self.selectedProinvce = self.provinces[0];
    self.sex = @"0";
    self.brithField.text = @"";
    self.nameTF.text = @"";
    self.cityCode = @"110100";
    City *city  = (City *)self.selectedProinvce.cities[0];
    self.cityCode = city.code;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
