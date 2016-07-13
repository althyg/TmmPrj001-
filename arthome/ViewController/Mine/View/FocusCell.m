//
//  FocusCell.m
//  arthome
//
//  Created by 海修杰 on 16/4/26.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "FocusCell.h"

@interface FocusCell ()


@property (nonatomic,weak) UIImageView * headImgView ;

@property (nonatomic,weak) UILabel * nameLb ;

@end

@implementation FocusCell

+(instancetype)focusCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"focusCell";
    //  去检测有没有空闲的cell
    FocusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //  如果没有就创建一个新的
    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //添加image
        UIImageView *headImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:headImgView];
        self.headImgView = headImgView;
        
        headImgView.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(12.5), DEF_RESIZE_UI(50), DEF_RESIZE_UI(50));
        headImgView.layer.cornerRadius = headImgView.width*0.5;
        headImgView.layer.masksToBounds = YES;
        //姓名
        UILabel *nameLb = [[UILabel alloc]init];
        [self.contentView addSubview:nameLb];
        self.nameLb = nameLb;
        nameLb.font = DEF_MyFont(13);
        nameLb.textColor = COLOR_333333;
        nameLb.textAlignment = NSTextAlignmentLeft;
        nameLb.frame = CGRectMake(CGRectGetMaxX(headImgView.frame)+DEF_RESIZE_UI(10), 0, DEF_RESIZE_UI(100), DEF_RESIZE_UI(75));
        //arrow
        UIImageView *arrowImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:arrowImgView];
        arrowImgView.contentMode = UIViewContentModeCenter;
        arrowImgView.image = DEF_IMAGENAME(@"mine_arrow_right");
        arrowImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(30), 0, DEF_RESIZE_UI(7), DEF_RESIZE_UI(75));
        //分割线
        UIView *partLine = [[UIView alloc]init];
        partLine.backgroundColor = COLOR_f2f2f2;
        partLine.frame = CGRectMake(0, DEF_RESIZE_UI(75), DEF_DEVICE_WIDTH, 1);
        [self.contentView addSubview:partLine];
        
    }
    return self;
}

-(void)setFocus:(Focus *)focus{
    _focus = focus;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:focus.artistHeadUrl] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    self.nameLb.text = focus.artistName;
}
@end
