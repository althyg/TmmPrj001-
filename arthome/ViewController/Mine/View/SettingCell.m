//
//  SettingCell.m
//  weike
//
//  Created by CaiMiao on 15/10/14.
//  Copyright © 2015年 CaiMiao. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingGroup.h"
#import "SettingItemArrow.h"
#import "SettingItemLabel.h"
#import "SettingLabelArrow.h"

@interface SettingCell ()
/**
 *  分割线
 */
@property (nonatomic,strong) UIView *lineView;
/**
 *  箭头
 */
@property (nonatomic,strong) UIImageView *arrowView;

/**
 *  文本标签
 */
@property (nonatomic,strong) UILabel *labelView;
/**
 *  开关
 */
@property (nonatomic,strong) UISwitch *st;
/**
 *  文本和图片
 */
@property(nonatomic,strong) UIView  * LabelImg;
@property(nonatomic,strong) UILabel * arrowLabel;
@end

@implementation SettingCell

/**
 *  分割线
 */
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =COLOR_f2f2f2 ;
    }
    return _lineView;
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    // 0.创建cell
    static NSString *ID = @"cell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = DEF_MyFont(14);
        self.textLabel.textColor = COLOR_666666;
        self.detailTextLabel.font = DEF_MyFont(13);
        //self.detailTextLabel.textColor = CZColor(110,72,28);
        // 添加分割线
//        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_arrow_right"]];
    }
    return _arrowView;
}

- (UILabel *)labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.frame = CGRectMake(0, 0, 100, 40);
        _labelView.textColor=COLOR_RGB(100, 100, 100);
        _labelView.textAlignment=NSTextAlignmentRight;
        _labelView.font=DEF_MyFont(13);
    }
    return _labelView;
}

-(UIView *)LabelImg{
    if (_LabelImg==nil) {
        _LabelImg=[[UIView alloc]init];
        _LabelImg.frame=CGRectMake(0, 0, 180, 40);
        
        UILabel * subLabel=[[UILabel alloc] init];
        self.arrowLabel=subLabel;
        subLabel.frame=CGRectMake(0, 0, 160, 40);
        subLabel.textAlignment=NSTextAlignmentRight;
        subLabel.font=[UIFont systemFontOfSize:13];
        subLabel.textColor=COLOR_RGB(100, 100, 100);
        
        UIImageView * subArrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_arrow_right"]];
        subArrowView.frame=CGRectMake(160, 0, 20, 40);
        subArrowView.contentMode= UIViewContentModeCenter;
        [_LabelImg addSubview:subLabel];
        [_LabelImg addSubview:subArrowView];
    }
    return _LabelImg;
}

- (void)setItem:(SettingItem *)item {
    _item = item;
    // 1.设置子控件内容
    [self setData];
    // 2.设置cell右边显示的内容
    [self setRightData];
    
}
- (void)setData{
    self.textLabel.text = _item.title;
    if (_item.icon.length != 0) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
}

- (void)setRightData{
    if ([_item isKindOfClass:[SettingItemArrow class]]) { // 显示箭头
        // 设置cell选中的样式
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryView = self.arrowView;
    }
    else if([_item isKindOfClass:[SettingItemLabel class]]) { // 显示文本标签
        SettingItemLabel * itemLb=(SettingItemLabel *)_item;
        self.accessoryView = self.labelView;
        self.labelView.text=itemLb.value;
        
    }
    else if([_item isKindOfClass:[SettingLabelArrow class]]){//显示文本和箭头
        SettingLabelArrow *itemLabelImg=(SettingLabelArrow *)_item;
        self.accessoryView=self.LabelImg;
        self.arrowLabel.text=itemLabelImg.arrowTitle;
        
    }
    else {
        self.accessoryView = nil;
    }
}

- (void)setShowLine:(BOOL)showLine {
//    _showLine = showLine;
//    self.lineView.hidden = !showLine;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lineH = 1;
    CGFloat lineX = self.imageView.x;
    CGFloat lineW = self.frame.size.width - lineX*2;
    CGFloat lineY = self.frame.size.height - lineH;
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
}

@end
