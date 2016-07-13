//
//  ArtFavoCell.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArtFavoCell.h"

@interface ArtFavoCell ()

@property (nonatomic,strong) UIImageView * artImgView ;

@property (nonatomic,strong) UILabel * artNameLb ;

@property (nonatomic,strong) UILabel * artIntroLb ;

@property (nonatomic,strong) UILabel * artPriceLb ;

@end

@implementation ArtFavoCell

+(instancetype)artFavoCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"ArtFavoCell";
    ArtFavoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        UIImageView *artImgView = [[UIImageView alloc]init];
        self.artImgView = artImgView;
        artImgView.frame = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(70), DEF_RESIZE_UI(70));
        [self.contentView addSubview:artImgView];
        //作品名称
        UILabel *artNameLb = [[UILabel alloc]init];
        self.artNameLb = artNameLb;
        artNameLb.font = DEF_MyFont(14);
        artNameLb.textColor = COLOR_666666;
        artNameLb.textAlignment = NSTextAlignmentLeft;
        artNameLb.frame = CGRectMake(CGRectGetMaxX(artImgView.frame)+DEF_RESIZE_UI(10), artImgView.y+DEF_RESIZE_UI(10), DEF_RESIZE_UI(100), DEF_RESIZE_UI(14));
        [self.contentView addSubview:artNameLb];
        //作品介绍
        UILabel *artIntroLb = [[UILabel alloc]init];
        self.artIntroLb = artIntroLb;
        artIntroLb.font = DEF_MyFont(11);
        artIntroLb.textColor = COLOR_999999;
        artIntroLb.textAlignment = NSTextAlignmentLeft;
        artIntroLb.frame = CGRectMake(artNameLb.x,CGRectGetMaxY(artNameLb.frame)+DEF_RESIZE_UI(15), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(90), DEF_RESIZE_UI(11));
        [self.contentView addSubview:artIntroLb];
        //作品价格
        UILabel *artPriceLb = [[UILabel alloc]init];
        self.artPriceLb = artPriceLb;
        artPriceLb.font = DEF_MyFont(14);
        artPriceLb.textColor = COLOR_666666;
        artPriceLb.textAlignment = NSTextAlignmentRight;
        artPriceLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60), artNameLb.y, DEF_RESIZE_UI(60), DEF_RESIZE_UI(14));
        [self.contentView addSubview:artPriceLb];
        //分割线
        UIView *partLine = [[UIView alloc]init];
        partLine.backgroundColor = COLOR_f2f2f2;
        partLine.frame = CGRectMake(0,CGRectGetMaxY(artImgView.frame)+DEF_RESIZE_UI(10) , DEF_DEVICE_WIDTH, 1);
        [self.contentView addSubview:partLine];
    }
    return self;
}

-(void)setArtFavo:(ArtFavo *)artFavo{
    _artFavo = artFavo;
    [self.artImgView sd_setImageWithURL:[NSURL URLWithString:artFavo.artImgUrl] placeholderImage:DEF_DEFAULPLACEHOLDIMG];
    self.artNameLb.text = artFavo.artName;
    self.artIntroLb.text = artFavo.artInfo;
    self.artPriceLb.text = [NSString stringWithFormat:@"¥%@",artFavo.artPrice];
}


@end
