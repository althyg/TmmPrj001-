//
//  CollectCell.m
//  arthome
//
//  Created by 海修杰 on 16/4/27.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "CollectCell.h"

@interface CollectCell ()

@property (nonatomic,weak) UIImageView * workImgView ;

@property (nonatomic,weak) UILabel * workNameLb ;

@property (nonatomic,weak) UILabel * workIntroLb ;

@property (nonatomic,weak) UILabel * workPriceLb ;

@end

@implementation CollectCell

+(instancetype)collectionCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"collectionCell";
    //  去检测有没有空闲的cell
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        workNameLb.frame = CGRectMake(CGRectGetMaxX(workImgView.frame)+DEF_RESIZE_UI(10), workImgView.y, DEF_RESIZE_UI(150), DEF_RESIZE_UI(16));
        
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
        
        //arrow
        UIImageView *arrowImgView = [[UIImageView alloc]init];
        [self.contentView addSubview:arrowImgView];
        arrowImgView.contentMode = UIViewContentModeCenter;
        arrowImgView.image = DEF_IMAGENAME(@"mine_arrow_right");
        arrowImgView.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(30), 0, DEF_RESIZE_UI(7),DEF_RESIZE_UI(95));
        
    }
    return self;
}

-(void)setCollection:(Collection *)collection{
    _collection = collection;
    [self.workImgView sd_setImageWithURL:[NSURL URLWithString:collection.artImgUrl] placeholderImage:DEF_IMAGENAME(@"global_default_img")];
    self.workNameLb.text = collection.artName;
    self.workIntroLb.text = collection.artInfo;
    self.workPriceLb.text = collection.artPrice;
}

@end
