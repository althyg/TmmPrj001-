//
//  OrderConfirCell.m
//  arthome
//
//  Created by 海修杰 on 16/4/20.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "OrderConfirCell.h"

@interface OrderConfirCell ()

@property (nonatomic,weak) UIImageView * workImgView ;

@property (nonatomic,weak) UILabel * workNameLb ;

@property (nonatomic,weak) UILabel * workIntroLb ;

@property (nonatomic,weak) UILabel * workPriceLb ;

@end


@implementation OrderConfirCell

+(instancetype)orderConfirCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"OrderConfirCell";
    //  去检测有没有空闲的cell
    OrderConfirCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        //添加作品图片
        UIImageView *workImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:workImgView];
        self.workImgView = workImgView;
        workImgView.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(75), DEF_RESIZE_UI(75));
        
        //作品名称
        UILabel *workNameLb = [[UILabel alloc]init];
        [self.contentView addSubview:workNameLb];
        self.workNameLb = workNameLb;
        workNameLb.font = DEF_MyFont(14);
        workNameLb.textColor = COLOR_333333;
        workNameLb.textAlignment = NSTextAlignmentLeft;
        workNameLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y, DEF_RESIZE_UI(140), DEF_RESIZE_UI(16));
      
        //作品介绍
        UILabel *workIntroLb = [[UILabel alloc]init];
        workIntroLb.numberOfLines = 0;
        [self.contentView addSubview:workIntroLb];
        self.workIntroLb = workIntroLb;
        workIntroLb.font = DEF_MyFont(12);
        workIntroLb.textColor = COLOR_cccccc;
        workIntroLb.textAlignment = NSTextAlignmentLeft;
        workIntroLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y+DEF_RESIZE_UI(15), DEF_DEVICE_WIDTH-CGRectGetMaxX(workImgView.frame)-DEF_RESIZE_UI(20), DEF_RESIZE_UI(40));
    
        //作品价格
        UILabel *workPriceLb = [[UILabel alloc]init];
        [self.contentView addSubview:workPriceLb];
        self.workPriceLb = workPriceLb;
        workPriceLb.font = DEF_MyFont(14);
        workPriceLb.textColor = COLOR_ff6060;
        workPriceLb.textAlignment = NSTextAlignmentLeft;
        workPriceLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), CGRectGetMaxY(workIntroLb.frame), DEF_DEVICE_WIDTH-CGRectGetMaxX(workImgView.frame), DEF_RESIZE_UI(14));
       
        //分割线
        UIView *partLine = [[UIView alloc]init];
        partLine.backgroundColor = COLOR_f2f2f2;
        partLine.frame = CGRectMake(0, DEF_RESIZE_UI(95), DEF_DEVICE_WIDTH, 1);
        [self.contentView addSubview:partLine];
        
    }
    return self;
}

-(void)setOrderConfir:(OrderConfir *)orderConfir{
    _orderConfir = orderConfir;
    [self.workImgView sd_setImageWithURL:[NSURL URLWithString:orderConfir.artImgUrl] placeholderImage:DEF_IMAGENAME(@"global_default_img")];
    self.workNameLb.text = orderConfir.artName;
    self.workIntroLb.text = orderConfir.artInfo;
    self.workPriceLb.text = orderConfir.artPrice;
}

@end
