//
//  ScreeningCell.m
//  arthome
//
//  Created by qzwh on 16/7/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ScreeningCell.h"

@interface ScreeningCell()

/**
 *  UIButton
 */
@property (nonatomic,strong) UIButton *btn;



@end

@implementation ScreeningCell

+(instancetype)screeningCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"screeningCell";
    //  去检测有没有空闲的cell
    ScreeningCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //  如果没有就创建一个新的
    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

//- (instancetype)initWithFrame:(CGRect)frame{

//    _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//    [_btn setImage:[UIImage imageNamed:@"find_screening_yuan"] forState:UIControlStateNormal];
//    [self addSubview:_btn];


//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化UI界面
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, 16, 40)];
        [_btn setImage:[UIImage imageNamed:@"find_screening_yuan"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"find_screening_selection_yuan"] forState:UIControlStateSelected];
        //添加事件
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_btn];
        
        //添加右边的分类总称
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(DEF_DEVICE_WIDTH-50, 20, 30, 10);
        nameLabel.text = @"油画";
        nameLabel.tag = 40;
        [nameLabel setTextColor:COLOR_666666];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:nameLabel];
        
        //创建按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 50, 60, 26)];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"风景" forState:UIControlStateNormal];
        [btn setTintColor:[UIColor blackColor]];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.contentView addSubview:btn];
        
    }
    return self;
}

- (void)btnClick:(UIButton *)btn{
    
    //调用代码块
    if (self.buttonBlock) {
        self.buttonBlock();
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isSelected) {
        _btn.selected = YES;
    } else {
        _btn.selected = NO;
    }
}

@end
