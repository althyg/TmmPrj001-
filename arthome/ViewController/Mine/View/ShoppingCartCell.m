//
//  ShoppingCartCell.m
//  arthome
//
//  Created by 海修杰 on 16/4/13.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ShoppingCartCell.h"

@interface ShoppingCartCell ()

@property (nonatomic,weak) UIButton * selectBtn ;

@property (nonatomic,weak) UIImageView * workImgView ;

@property (nonatomic,weak) UILabel * workNameLb ;

@property (nonatomic,weak) UILabel * workIntroLb ;

@property (nonatomic,weak) UILabel * workPriceLb ;



@end

@implementation ShoppingCartCell

+(instancetype)shoppingCartCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"ShoppingCartCell";
    //  去检测有没有空闲的cell
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        //添加选中按钮
        UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView  addSubview:selectBtn];
        self.selectBtn = selectBtn;
        [selectBtn setImage:DEF_IMAGENAME(@"global_item_unselected") forState:UIControlStateNormal];
        [selectBtn setImage:DEF_IMAGENAME(@"global_item_selected") forState:UIControlStateSelected];
        selectBtn.frame = CGRectMake(0, 0, DEF_RESIZE_UI(40), DEF_RESIZE_UI(95));
        selectBtn.imageView.contentMode = UIViewContentModeCenter;
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     
        //添加作品图片
        UIImageView *workImgView = [[UIImageView alloc]init];
        self.workImgView = workImgView;
        workImgView.backgroundColor = [UIColor yellowColor];
        workImgView.frame = CGRectMake(CGRectGetMaxX(selectBtn.frame), DEF_RESIZE_UI(10), DEF_RESIZE_UI(75), DEF_RESIZE_UI(75));
        [self.contentView addSubview:workImgView];
        //作品名称
        UILabel *workNameLb = [[UILabel alloc]init];
        self.workNameLb = workNameLb;
        workNameLb.text = @"作品名称";
        workNameLb.font = DEF_MyFont(14);
        workNameLb.textColor = COLOR_333333;
        workNameLb.textAlignment = NSTextAlignmentLeft;
        workNameLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y, DEF_RESIZE_UI(80), DEF_RESIZE_UI(16));
        [self.contentView addSubview:workNameLb];
        //作品介绍
        UILabel *workIntroLb = [[UILabel alloc]init];
        self.workIntroLb = workIntroLb;
        workIntroLb.text = @"国画/60*50cm/2011";
        workIntroLb.font = DEF_MyFont(12);
        workIntroLb.textColor = COLOR_cccccc;
        workIntroLb.textAlignment = NSTextAlignmentLeft;
        workIntroLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y+DEF_RESIZE_UI(25), DEF_DEVICE_WIDTH-CGRectGetMaxX(workImgView.frame), DEF_RESIZE_UI(12));
        [self.contentView addSubview:workIntroLb];
        //作品价格
        UILabel *workPriceLb = [[UILabel alloc]init];
        self.workPriceLb = workPriceLb;
        workPriceLb.text = @"1500";
        workPriceLb.font = DEF_MyFont(14);
        workPriceLb.textColor = COLOR_ff6060;
        workPriceLb.textAlignment = NSTextAlignmentLeft;
        workPriceLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workIntroLb.y+DEF_RESIZE_UI(25), DEF_DEVICE_WIDTH-CGRectGetMaxX(workImgView.frame), DEF_RESIZE_UI(14));
        [self.contentView addSubview:workPriceLb];
        //分割线
        UIView *partLine = [[UIView alloc]init];
        partLine.backgroundColor = COLOR_f2f2f2;
        partLine.frame = CGRectMake(0, DEF_RESIZE_UI(95), DEF_DEVICE_WIDTH, 1);
        [self.contentView addSubview:partLine];

    }
    return self;
}

-(void)selectBtnClick:(UIButton *)btn{
    btn.selected ? (btn.selected = NO) : (btn.selected = YES);
    self.shoppingCart.selected = btn.selected;
    self.selectBtnBlock ();
}

-(void)setShoppingCart:(ShoppingCart *)shoppingCart{
    _shoppingCart = shoppingCart;
    [self.workImgView sd_setImageWithURL:[NSURL URLWithString:shoppingCart.imgUrl] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    self.workNameLb.text = shoppingCart.workName;
    self.workIntroLb.text = shoppingCart.workIntro;
    self.workNameLb.text = shoppingCart.workName;
    self.workPriceLb.text = shoppingCart.workPrice;
    self.selectBtn.selected = shoppingCart.selected;
}
@end
