//
//  ChangeAddressViewController.m
//  arthome
//
//  Created by 海修杰 on 16/5/18.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ChangeAddressController.h"
#import "Province.h"

@interface ChangeAddressController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UITextField * nameTF ;

@property (nonatomic,strong) UITextField * phoneTF ;

@property (nonatomic,strong) UITextField * postalTF ;

@property (nonatomic,strong) UITextField * localTF ;

@property (nonatomic,strong) UITextField * detailTV ;

@property (nonatomic,strong) UITextField * provinceField ;

@property (nonatomic,strong) UIScrollView * mainScr ;

@property (nonatomic,strong) UIPickerView * pickerView;

@property (nonatomic,copy) NSString * isDefaulted;

@property (nonatomic,copy) NSString * cityCode;

@property (nonatomic,strong) UIButton * defaultedBtn ;


/**
 *  记录当前选中的省份
 */
@property (nonatomic,strong) Province * selectedProinvce;
/**
 *  所有省市
 */
@property (nonatomic,strong) NSArray * provinces;

@end

@implementation ChangeAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self downLoadData];
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

- (NSArray *)provinces {
    if (_provinces == nil) {
        _provinces = [Province provinces];
    }
    return _provinces;
}

#pragma mark - 保存按钮的点击

-(void)saveBtnClick{
    if (self.nameTF.text.length&&self.phoneTF.text.length&&self.postalTF.text.length&&self.localTF.text.length&&self.detailTV.text.length) {
        
        NSDictionary *dic = @{
                              @"receName" : self.nameTF.text,
                              @"recePhone": self.phoneTF.text,
                              @"recePost" : self.postalTF.text,
                              @"receLocal": self.cityCode,
                              @"receLocalDetail" : self.detailTV.text,
                              @"isDefaulted" : self.isDefaulted,
                              @"locationId" : self.locationId
                              };
        if ( [ATUtility validateMobile:self.phoneTF.text]) {
           [self mineAddressUpLoadHttpRequestWithDictionary:dic];
        }
        else{
            [ATUtility showTipMessage:WRONGPHONENUMBER];
        }
    }
    else{
        [ATUtility showTipMessage:WRONGADDRESSTIP];
    }

    if (self.isDefaulted) {
        ATUserInfo *userInfo = [ATUserInfo shareUserInfo];
        userInfo.receName =  self.nameTF.text ;
        userInfo.recePhone = self.phoneTF.text;
        userInfo.receLocation = [NSString stringWithFormat:@"%@ %@",self.provinceField.text,self.detailTV.text];
        [userInfo saveAccountToSandBox];
    }
}

-(void)downLoadData{
    NSDictionary *dic = @{
                          @"locationId" : self.locationId
                          };
    [self mineAddressDownLoadHttpRequestWithDictionary:dic];
}

/**
 下拉地址数据
 */
-(void)mineAddressDownLoadHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineAddressDownLoadWithParametersDic:dic success:^(NSDictionary *result) {
        [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            self.nameTF.text = result[@"receName"];
            self.phoneTF.text = result[@"recePhone"];
            self.postalTF.text = result[@"recePost"];
            self.provinceField.text = result[@"receLocal"];
            self.detailTV.text = result[@"receLocalDetail"];
            self.isDefaulted = result[@"isDefaulted"];
            self.cityCode = result[@"citycode"];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}
/**
 *  上传地址数据
 */
-(void)mineAddressUpLoadHttpRequestWithDictionary:(NSDictionary *)dic{
    [ATUtility showMBProgress:self.view];
    [RequestManager mineAddressUpLoadWithParametersDic:dic success:^(NSDictionary *result) {
         [ATUtility hideMBProgress:self.view];
        if ([result[@"code"] integerValue] == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [ATUtility showTipMessage:result[@"message"]];
        }
    } failture:^(id result) {
        [ATUtility hideMBProgress:self.view];
    }];
}

-(void)setIsDefaulted:(NSString *)isDefaulted{
    _isDefaulted = isDefaulted;
    self.defaultedBtn.selected = [isDefaulted integerValue];
}

-(void)initUI{
    self.navigationItem.title = @"修改收货地址";
    self.view.backgroundColor = COLOR_ffffff;
    
    UIScrollView *mainScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    self.mainScr = mainScr;
    mainScr.bounces = YES ;
    mainScr.contentSize = CGSizeMake(0, mainScr.height-63);
    mainScr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScr];
    
    
    CGFloat titleLbW = DEF_RESIZE_UI(100);
    CGFloat titleTFW = DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10)- titleLbW;
    CGFloat rowH = DEF_RESIZE_UI(44);
    //姓名
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    nameView.layer.borderWidth = 1;
    nameView.layer.borderColor = COLOR_cccccc.CGColor;
    nameView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:nameView];
    
    UILabel *nameLb = [[UILabel alloc]init];
    nameLb.textAlignment = NSTextAlignmentLeft;
    nameLb.textColor = COLOR_999999;
    nameLb.font = DEF_MyFont(12);
    nameLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    nameLb.text = @"收货人";
    [nameView addSubview:nameLb];
    
    UITextField *nameTF = [[UITextField alloc]init];
    self.nameTF = nameTF;
    nameTF.placeholder = @"姓名";
    nameTF.textColor = COLOR_333333;
    nameTF.font = DEF_MyFont(12);
    nameTF.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, DEF_RESIZE_UI(44));
    [nameView addSubview:nameTF];
    
    //手机号码
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(nameView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = COLOR_cccccc.CGColor;
    phoneView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:phoneView];
    
    UILabel *phoneLb = [[UILabel alloc]init];
    phoneLb.textAlignment = NSTextAlignmentLeft;
    phoneLb.textColor = COLOR_999999;
    phoneLb.font = DEF_MyFont(12);
    phoneLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    phoneLb.text = @"手机号码";
    [phoneView addSubview:phoneLb];
    
    UITextField *phoneTF = [[UITextField alloc]init];
    self.phoneTF = phoneTF;
    phoneTF.placeholder = @"手机号码";
    phoneTF.textColor = COLOR_333333;
    phoneTF.font = DEF_MyFont(12);
    phoneTF.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, DEF_RESIZE_UI(44));
    [phoneView addSubview:phoneTF];
    
    //地址
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(phoneView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    addressView.layer.borderWidth = 1;
    addressView.layer.borderColor = COLOR_cccccc.CGColor;
    addressView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:addressView];
    
    UILabel *addressLb = [[UILabel alloc]init];
    addressLb.textAlignment = NSTextAlignmentLeft;
    addressLb.textColor = COLOR_999999;
    addressLb.font = DEF_MyFont(12);
    addressLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    addressLb.text = @"地址";
    [addressView addSubview:addressLb];
    
    UITextField *provinceField = [[UITextField alloc]init];
    self.provinceField = provinceField;
    provinceField.placeholder = @"北京-北京市";
    provinceField.textColor = COLOR_333333;
    provinceField.font = DEF_MyFont(12);
    provinceField.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, rowH);
    [addressView addSubview:provinceField];
    
    //详细地址
    UIView *detailTVView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(addressView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    detailTVView.layer.borderWidth = 1;
    detailTVView.layer.borderColor = COLOR_cccccc.CGColor;
    detailTVView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:detailTVView];
    
    UILabel *detailTVLb = [[UILabel alloc]init];
    detailTVLb.textAlignment = NSTextAlignmentLeft;
    detailTVLb.textColor = COLOR_999999;
    detailTVLb.font = DEF_MyFont(12);
    detailTVLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    detailTVLb.text = @"详细地址";
    [detailTVView addSubview:detailTVLb];
    
    UITextField *detailTV = [[UITextField alloc]init];
    self.detailTV = detailTV;
    detailTV.placeholder = @"详细地址";
    detailTV.textColor = COLOR_333333;
    detailTV.font = DEF_MyFont(12);
    detailTV.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, rowH);
    [detailTVView addSubview:detailTV];
    
    //邮编
    UIView *postalView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(10),CGRectGetMaxY(detailTVView.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), rowH)];
    postalView.layer.borderWidth = 1;
    postalView.layer.borderColor = COLOR_cccccc.CGColor;
    postalView.backgroundColor = COLOR_f2f2f2;
    [mainScr addSubview:postalView];
    
    UILabel *postalLb = [[UILabel alloc]init];
    postalLb.textAlignment = NSTextAlignmentLeft;
    postalLb.textColor = COLOR_999999;
    postalLb.font = DEF_MyFont(12);
    postalLb.frame = CGRectMake(DEF_RESIZE_UI(20), 0, titleLbW, rowH);
    postalLb.text = @"邮编";
    [postalView addSubview:postalLb];
    
    UITextField *postalTF = [[UITextField alloc]init];
    self.postalTF = postalTF;
    postalTF.placeholder = @"邮编";
    postalTF.textColor = COLOR_333333;
    postalTF.font = DEF_MyFont(12);
    postalTF.frame = CGRectMake(CGRectGetMaxX(nameLb.frame), 0, titleTFW, rowH);
    [postalView addSubview:postalTF];
    
    //是否默认
    UIButton *defaultedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.defaultedBtn = defaultedBtn;
    defaultedBtn.titleLabel.font = DEF_MyFont(11);
    [defaultedBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    defaultedBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, DEF_RESIZE_UI(10));
    [defaultedBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
    [defaultedBtn setTitleColor:COLOR_da1025 forState:UIControlStateSelected];
    [defaultedBtn setImage:DEF_IMAGENAME(@"global_item_unselected") forState:UIControlStateNormal];
    [defaultedBtn setImage:DEF_IMAGENAME(@"global_item_selected") forState:UIControlStateSelected];
    defaultedBtn.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(postalView.frame)+DEF_RESIZE_UI(8), DEF_RESIZE_UI(100), DEF_RESIZE_UI(30));
    [defaultedBtn addTarget:self action:@selector(defaultedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:defaultedBtn];
    
    //保存按钮
    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = COLOR_ff6060;
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = DEF_MyFont(16);
    saveBtn.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_DEVICE_HEIGHT-DEF_RESIZE_UI(94)-64, DEF_DEVICE_WIDTH-2*DEF_RESIZE_UI(10), DEF_RESIZE_UI(44));
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainScr addSubview:saveBtn];
    // 修改文本输入框的输入内容的辅助控件
    self.provinceField.inputView = self.pickerView;
    self.selectedProinvce = self.provinces[0];
    self.isDefaulted = @"0";
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)defaultedBtnClick:(UIButton *) btn{
    btn.selected ? (btn.selected = NO) : (btn.selected = YES);
    if (btn.selected) {
        self.isDefaulted = @"1";
    }
    else{
        self.isDefaulted = @"0";
    }
}


@end
