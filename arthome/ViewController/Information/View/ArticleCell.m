//
//  ArticleCell.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArticleCell.h"

@interface ArticleCell ()

@property (nonatomic,strong) UIImageView * articleImgView ;

@end

@implementation ArticleCell

+(instancetype)articleCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"ArticleCell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //分割线
        UIView *apartLine = [[UIView alloc]init];
        apartLine.backgroundColor = COLOR_f2f2f2;
        apartLine.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10));
        [self.contentView addSubview:apartLine];
        CGFloat padding = DEF_RESIZE_UI(10);
        //leftView
        UIView * leftView = [[UIView alloc]init];
        leftView.backgroundColor = COLOR_ffffff;
        leftView.frame = CGRectMake(0, padding, DEF_RESIZE_UI(50), DEF_RESIZE_UI(220));
        [self.contentView addSubview:leftView];
        //IMG
        UIImageView *articleImgView = [[UIImageView alloc]init];
        self.articleImgView = articleImgView;
        articleImgView.frame = CGRectMake(DEF_RESIZE_UI(50), DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(60), DEF_RESIZE_UI(140));
        [self.contentView addSubview:articleImgView];
        //titleLb
        UILabel * titleLb = [[UILabel alloc]init];
        titleLb.font = DEF_MyFont(16);
        titleLb.textColor = COLOR_333333;
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.frame = CGRectMake(DEF_RESIZE_UI(50), CGRectGetMaxY(articleImgView.frame)+DEF_RESIZE_UI(20), DEF_RESIZE_UI(140), DEF_RESIZE_UI(17));
        [self.contentView addSubview:titleLb];
        //sourceLb
        UILabel *sourceLb = [[UILabel alloc]init];
        sourceLb.textAlignment = NSTextAlignmentLeft;
        sourceLb.textColor = COLOR_999999;
        sourceLb.font = DEF_MyFont(11);
        sourceLb.frame = CGRectMake(DEF_RESIZE_UI(50), CGRectGetMaxY(titleLb.frame)+DEF_RESIZE_UI(8), DEF_RESIZE_UI(80), DEF_RESIZE_UI(13));
        [self.contentView addSubview:sourceLb];
        //collectBtn
        UIButton * collecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [collecBtn setImage:DEF_IMAGENAME(@"mine_article_collection") forState:UIControlStateNormal];
        collecBtn.imageView.contentMode  = UIViewContentModeCenter;
        collecBtn.titleLabel.font = DEF_MyFont(11);
        [collecBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        collecBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(50), CGRectGetMaxY(titleLb.frame), DEF_RESIZE_UI(50), DEF_RESIZE_UI(30));
    }
    return self;
}

@end
