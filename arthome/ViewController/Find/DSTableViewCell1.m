//
//  DSTableViewCell1.m
//  arthome
//
//  Created by maiziedu on 7/9/16.
//  Copyright © 2016 qizhiwenhua. All rights reserved.
//

#import "DSTableViewCell1.h"

@interface DSTableViewCell1()

@property (strong, nonatomic) NSArray *subMenuTitles;
@property (strong, nonatomic) UIButton *stateButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *subMenuBtnContaierView;

@end

@implementation DSTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    //    stateButton.selected = YES;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _stateButton = [[UIButton alloc] initWithFrame:CGRectMake(12, 8, 32, 32)];
        _stateButton.selected = NO;
        [_stateButton setImage:[UIImage imageNamed:@"find_screening_yuan"] forState:UIControlStateNormal];
        [_stateButton setImage:[UIImage imageNamed:@"find_screening_selection_yuan"] forState:UIControlStateSelected];
        [self addSubview:_stateButton];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 110,
                                                                8,
                                                                100,
                                                                20)];
        _titleLabel.text = @"国画";
        _titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_titleLabel];
        
        
        
        _subMenuTitles = @[@"山水",
                           @"人物",
                           @"花鸟",
                           @"走兽",
                           @"写意",
                           @"工笔"];
        
        [self addSubMenuButtons];
    }
    return self;
}

- (void)addSubMenuButtons {
    
    CGFloat v_space = 8;
    CGFloat h_space = 8;
    CGFloat buttonWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - (6*h_space))/5;
    CGFloat buttonHeight = 30;
    
    
    _subMenuBtnContaierView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                       50,
                                                                       CGRectGetWidth([UIScreen mainScreen].bounds),
                                                                       150)];
    
    
    [self.contentView addSubview:_subMenuBtnContaierView];
    _subMenuBtnContaierView.backgroundColor = [UIColor colorWithRed:245/250.0
                                                              green:249/250.0
                                                               blue:250/250.0
                                                              alpha:1.0];
    
    for (NSInteger index=0; index<_subMenuTitles.count; index++) {
        
        
        UIButton *subMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        subMenuBtn.frame = CGRectMake(index > 4 ? (h_space + buttonWidth)*(index-5)+8 : (h_space + buttonWidth)*index+8,
                                      index > 4 ? v_space*2+buttonHeight : v_space,
                                      buttonWidth,
                                      buttonHeight);
        
        [subMenuBtn setTitle:[_subMenuTitles objectAtIndex:index] forState:UIControlStateNormal];
        subMenuBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [subMenuBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [subMenuBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

        subMenuBtn.tag = index;
        
        subMenuBtn.layer.borderWidth = 1;
        subMenuBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        
        [subMenuBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_subMenuBtnContaierView addSubview:subMenuBtn];
        NSLog(@"%ld", index);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _subMenuBtnContaierView.frame = CGRectMake(0,
                                               50,
                                               CGRectGetWidth(self.frame),
                                               CGRectGetHeight(self.frame) -50);
}


- (void)setSelectedState:(BOOL)state {
    
    if (state) {
        _stateButton.selected = YES;
    } else {
        _stateButton.selected = NO;
        
        for (UIButton *btn in self.subMenuBtnContaierView.subviews) {
            
            btn.layer.borderColor = [[UIColor grayColor] CGColor];
            btn.selected = NO;
        }
    }
}

- (void)buttonPressed:(UIButton *)s_btn {
    
    _selectedCellsClass(self, _titleLabel.text, s_btn.titleLabel.text);


    
    for (UIButton *btn in self.subMenuBtnContaierView.subviews) {
        
        if (btn.tag == s_btn.tag) {
            
            btn.layer.borderColor = [[UIColor redColor] CGColor];
            btn.selected = YES;
        } else {
            btn.layer.borderColor = [[UIColor grayColor] CGColor];
            btn.selected = NO;
        }
    }
}


@end
