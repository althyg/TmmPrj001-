//
//  ArticleFavoCell.m
//  arthome
//
//  Created by 海修杰 on 16/6/28.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ArticleFavoCell.h"

@interface ArticleFavoCell ()

@property (nonatomic,strong) UILabel * titleLb ;

@property (nonatomic,strong) UILabel * sourceLb ;

@property (nonatomic,strong) UIImageView * collTipImgView ;

@property (nonatomic,strong) UILabel * collectionLb ;

@property (nonatomic,strong) UILabel * timeLb ;

@end

@implementation ArticleFavoCell
+(instancetype)articleFavoCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"ArticleFavoCell";
    ArticleFavoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        CGFloat padding = DEF_RESIZE_UI(10);
        //添加文章标题
        UILabel *titleLb = [[UILabel alloc]init];
        self.titleLb = titleLb;
        titleLb.font = DEF_MyFont(16);
        titleLb.textAlignment = NSTextAlignmentLeft;
        titleLb.textColor = COLOR_333333;
        titleLb.frame = CGRectMake(padding, DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(40), DEF_RESIZE_UI(16));
         [self.contentView addSubview:titleLb];
        //添加文章来源
        UILabel *sourceLb = [[UILabel alloc]init];
        self.sourceLb = sourceLb;
        sourceLb.font = DEF_MyFont(11);
        sourceLb.textColor = COLOR_cccccc;
        sourceLb.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:sourceLb];
        //收藏数Tip
        UIImageView * collTipImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_article_collection")];
        self.collTipImgView = collTipImgView;
        [self.contentView addSubview:collTipImgView];
        //收藏数Lb
        UILabel *collectionLb = [[UILabel alloc]init];
        self.collectionLb = collectionLb;
        collectionLb.font = DEF_MyFont(11);
        collectionLb.textColor = COLOR_999999;
        collectionLb.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:collectionLb];
        //时间Lb
        UILabel *timeLb = [[UILabel alloc]init];
        self.timeLb = timeLb;
        collectionLb.font = DEF_MyFont(12);
        collectionLb.textColor = COLOR_cccccc;
        collectionLb.textAlignment = NSTextAlignmentRight;
        collectionLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(80), CGRectGetMaxY(titleLb.frame), DEF_RESIZE_UI(70), DEF_RESIZE_UI(11));
        [self.contentView addSubview:collectionLb];
        //分割线
        UIView *partLine = [[UIView alloc]init];
        partLine.backgroundColor = COLOR_f2f2f2;
        partLine.frame = CGRectMake(0,DEF_RESIZE_UI(80) , DEF_DEVICE_WIDTH, 1);
        [self.contentView addSubview:partLine];
    }
    return self;
}

-(void)setArticleFavo:(ArticleFavo *)articleFavo{
    _articleFavo = articleFavo;
    self.titleLb.text = articleFavo.articleTitle;
    self.timeLb.text = articleFavo.articleDate;
    self.sourceLb.text = articleFavo.articleSource;
    self.collectionLb.text = articleFavo.articleNo;
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, DEF_RESIZE_UI(11));
    CGSize textSize = [ATUtility sizeOfString:self.sourceLb.text withMaxSize:maxSize andFont:self.sourceLb.font];
    self.sourceLb.frame = (CGRect){DEF_RESIZE_UI(10),CGRectGetMaxY(self.timeLb.frame),textSize};
    self.collTipImgView.frame = CGRectMake(CGRectGetMaxX(self.sourceLb.frame)+DEF_RESIZE_UI(10),  self.sourceLb.y-DEF_RESIZE_UI(1.5), DEF_RESIZE_UI(16), DEF_RESIZE_UI(14));
    self.collectionLb.frame = CGRectMake(CGRectGetMaxX(self.collTipImgView.frame)+DEF_RESIZE_UI(5),self.sourceLb.y, DEF_RESIZE_UI(50), DEF_RESIZE_UI(11));
}

@end
