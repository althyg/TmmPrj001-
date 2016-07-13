//
//  ScreeningPriceCell.m
//  arthome
//
//  Created by qzwh on 16/7/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ScreeningPriceCell.h"
@interface ScreeningPriceCell(){
    
    BOOL isKeyboardShowing;
    UITextField *leftTextTf;
    UITextField *rightTextTf;
    
    
    
    UIView *centerLineView;
    UILabel *l_DollerLabel;
    UILabel *r_DollerLabel;
    UIView *leftView;
    UIView *rightView;
}
@end

@implementation ScreeningPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        NSInteger centerLineWidth = 14;
        
        
        // ************************************** 代码清晰度分割线
        centerLineView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          DEF_RESIZE_UI(centerLineWidth),
                                                                          1)];
        centerLineView.center = self.contentView.center;
        centerLineView.backgroundColor = [UIColor grayColor];
        [self addSubview:centerLineView];
        
        
        
        // ************************************** 代码清晰度分割线
        
        
        
        l_DollerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_RESIZE_UI(10),
                                                                           CGRectGetHeight(self.frame))];
        l_DollerLabel.text = @"¥";
        
        r_DollerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEF_RESIZE_UI(10),
                                                                           CGRectGetHeight(self.frame))];
        r_DollerLabel.text = @"¥";
        
        
        // ************************************** 代码清晰度分割线
        leftView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                             5,
         CGRectGetWidth(self.frame)/2 - 16 - centerLineWidth/2,
                                 CGRectGetHeight(self.frame))];
        
        
        leftTextTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(l_DollerLabel.frame)+5,
                                                                   5,
                                                                   CGRectGetWidth(leftView.frame) - CGRectGetWidth(l_DollerLabel.frame),
                                                                   CGRectGetHeight(leftView.frame))];
        leftTextTf.tag = 0;
        leftTextTf.keyboardType = UIKeyboardTypeNumberPad;
        leftTextTf.placeholder = @" 最低价格";
        leftTextTf.delegate = self;
        
        
        
        // ************************************** 代码清晰度分割线
        
        rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(centerLineView.frame) + 30,
                                                                    10,
                                                                    CGRectGetWidth(leftView.frame) - CGRectGetWidth(l_DollerLabel.frame),
                                                                    CGRectGetHeight(leftView.frame))];
        
        
        rightTextTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(r_DollerLabel.frame)+5,
                                                                    0,
                                                                    DEF_RESIZE_UI(120),
                                                                    DEF_RESIZE_UI(44))];
        rightTextTf.tag = 1;
        rightTextTf.keyboardType = UIKeyboardTypeNumberPad;
        rightTextTf.placeholder = @" 最高价格";
        rightTextTf.delegate = self;
        
        
        
        
        [leftView addSubview:l_DollerLabel];
        [leftView addSubview:leftTextTf];
        leftTextTf.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:leftView];
        
        
        [rightView addSubview:r_DollerLabel];
        [rightView addSubview:rightTextTf];
        rightTextTf.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:rightView];
        
        
        
        // 开始监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
        isKeyboardShowing = NO;
    }
    
    return self;
}

#pragma mark - textField 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

#pragma mark - 监听键盘并响应
// 监听键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *infoDic = notification.userInfo;
    
    CGFloat animationDura = [[infoDic objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect keyboardRect = [[infoDic objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    
    if (!isKeyboardShowing) {
        self.keyboardShowBlock(animationDura, keyboardRect);
        isKeyboardShowing = YES;
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *infoDic = notification.userInfo;
    
    
    isKeyboardShowing = NO;
    CGFloat animationDura = [[infoDic objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    CGRect keyboardRect = [[infoDic objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    
    self.keyboardHideBlock(animationDura, keyboardRect);
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resignAllTextField {
    
    // TODO
    if (leftTextTf.text.length == 0) {
        
        // 这里提示用户不能输入空置
    }
    
    if (rightTextTf.text.length == 0) {
        
        // 这里提示用户不能输入空置
    }
    
    
    if (leftTextTf.text.length != 0 && rightTextTf.text.length != 0) {
        
        self.intervalPriceNumber([leftTextTf.text integerValue], [rightTextTf.text integerValue]);
    }
    
    [leftTextTf resignFirstResponder];
    [rightTextTf resignFirstResponder];
}

- (void)clearTextContent {
    
    leftTextTf.text = @"";
    leftTextTf.placeholder = @"最低价格";
    
    
    rightTextTf.text = @"";
    rightTextTf.placeholder = @"最高价格";
    
    [leftTextTf resignFirstResponder];
    [rightTextTf resignFirstResponder];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat lr_height = CGRectGetHeight(self.frame) -10;
    
    
    centerLineView.center = self.contentView.center;
    
    l_DollerLabel.frame = CGRectMake(0, 0, DEF_RESIZE_UI(20),
                               lr_height);
    
    r_DollerLabel.frame = CGRectMake(0, 0, DEF_RESIZE_UI(20),
                                     lr_height);
    
    
    
    
    leftView.frame = CGRectMake(8,
                                5,
                                CGRectGetWidth(self.frame)/2 - 16 - CGRectGetWidth(centerLineView.frame)/2,
                                lr_height);
    
    leftTextTf.frame = CGRectMake(CGRectGetMaxX(l_DollerLabel.frame)+5,
                                  0,
                                  CGRectGetWidth(leftView.frame) - CGRectGetWidth(l_DollerLabel.frame) -5,
                                  CGRectGetHeight(leftView.frame));
    
    
    
    
    
    
    rightView.frame = CGRectMake(CGRectGetMaxX(centerLineView.frame) + 8,
                           5,
                           CGRectGetWidth(self.frame)/2 - 16 - CGRectGetWidth(centerLineView.frame)/2,
                                 lr_height);
    
    rightTextTf.frame = CGRectMake(CGRectGetMaxX(r_DollerLabel.frame)+5,
                                   0,
                                   CGRectGetWidth(rightView.frame) - CGRectGetWidth(r_DollerLabel.frame) -5,
                                   CGRectGetHeight(rightView.frame));
}
@end
