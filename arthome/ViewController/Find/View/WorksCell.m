//
//  WorksCell.m
//  arthome
//
//  Created by 海修杰 on 16/4/6.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "WorksCell.h"

@interface  WorksCell()

@property (nonatomic,weak) UIImageView * imgView ;

@property (nonatomic,weak) UILabel * worksNameLb ;

@property (nonatomic,weak) UILabel * artistNameLb ;

@property (nonatomic,weak) UILabel * workTypeLb ;

@property (nonatomic,weak) UILabel * workIntroLb ;

@property (nonatomic,weak) UILabel * workPriceLb ;

@property (nonatomic,weak) UIButton * collectBtn ;

@end

@implementation WorksCell

+(instancetype)worksCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"worksCell";
    WorksCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(cell == nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //添加分割线
        UIView *sepaView = [[UIView alloc]init];
        sepaView.backgroundColor = COLOR_f2f2f2;
        sepaView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10));
        [self.contentView addSubview:sepaView];
        //添加展示图片
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        self.imgView = imgView;
        imgView.frame = CGRectMake(0, CGRectGetMaxY(sepaView.frame), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(250));
        //收藏按钮
        UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [imgView addSubview:collectBtn];
        self.collectBtn = collectBtn;
        collectBtn.imageView.contentMode = UIViewContentModeCenter;
        [collectBtn setImage:DEF_IMAGENAME(@"global_collection_layer") forState:UIControlStateNormal ];
        [collectBtn setImage:DEF_IMAGENAME(@"global_collection_selectmax") forState:UIControlStateSelected ];
        collectBtn.frame = CGRectMake(imgView.width-DEF_RESIZE_UI(50), DEF_RESIZE_UI(10), DEF_RESIZE_UI(40),DEF_RESIZE_UI(40));
        
        //艺术品名称
        UILabel *worksNameLb = [[UILabel alloc]init];
        [self.contentView addSubview:worksNameLb];
        self.worksNameLb = worksNameLb;
        worksNameLb.textColor = COLOR_333333;
        worksNameLb.font = DEF_MyBoldFont(14);
        worksNameLb.textAlignment = NSTextAlignmentLeft;
        worksNameLb.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(imgView.frame)+DEF_RESIZE_UI(10), DEF_RESIZE_UI(140), DEF_RESIZE_UI(14));
        
        //艺术家名字
        UILabel *artistNameLb = [[UILabel alloc]init];
        [self.contentView addSubview:artistNameLb];
        self.artistNameLb = artistNameLb;
        artistNameLb.textColor = COLOR_cccccc;
        artistNameLb.font = DEF_MyFont(11);
        artistNameLb.textAlignment = NSTextAlignmentCenter;
        artistNameLb.frame = CGRectMake(CGRectGetMaxX(worksNameLb.frame)+DEF_RESIZE_UI(2), worksNameLb.y, DEF_RESIZE_UI(40), DEF_RESIZE_UI(13));
       
        //作品类型
        UILabel *workTypeLb = [[UILabel alloc]init];
        [self.contentView addSubview:workTypeLb];
        self.workTypeLb = workTypeLb;
        workTypeLb.textColor = COLOR_cccccc;
        workTypeLb.font = DEF_MyFont(11);
        workTypeLb.textAlignment = NSTextAlignmentLeft;
        workTypeLb.frame = CGRectMake(CGRectGetMaxX(artistNameLb.frame)+DEF_RESIZE_UI(5), worksNameLb.y, DEF_RESIZE_UI(30), DEF_RESIZE_UI(13));
       
        //作品介绍
        UILabel *workIntroLb = [[UILabel alloc]init];
        [self.contentView addSubview:workIntroLb];
        self.workIntroLb = workIntroLb;
        workIntroLb.textColor = COLOR_cccccc;
        workIntroLb.font = DEF_MyFont(11);
        workIntroLb.textAlignment = NSTextAlignmentLeft;
        workIntroLb.frame = CGRectMake(CGRectGetMaxX(workTypeLb.frame)+DEF_RESIZE_UI(5), worksNameLb.y, DEF_RESIZE_UI(100), DEF_RESIZE_UI(13));
      
        //作品价格
        UILabel *workPriceLb = [[UILabel alloc]init];
        [self.contentView addSubview:workPriceLb];
        self.workPriceLb = workPriceLb;
        workPriceLb.textColor = COLOR_ff6060;
        workPriceLb.font = DEF_MyFont(13);
        workPriceLb.textAlignment = NSTextAlignmentRight;
        workPriceLb.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(80)-DEF_RESIZE_UI(10), worksNameLb.y, DEF_RESIZE_UI(80), DEF_RESIZE_UI(13));
       
        //加入购物按钮
        UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shopCartBtn setImage:DEF_IMAGENAME(@"find_cart_red") forState:UIControlStateNormal];
        [shopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [shopCartBtn setTitleColor:COLOR_ff6060 forState:UIControlStateNormal];
        shopCartBtn.titleLabel.font = DEF_MyFont(13);
        shopCartBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        shopCartBtn.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(worksNameLb.frame)+DEF_RESIZE_UI(5), DEF_RESIZE_UI(110), DEF_RESIZE_UI(50));
        [shopCartBtn addTarget:self action:@selector(shopCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView  addSubview:shopCartBtn];
        
        //购买按钮
        UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:buyBtn];
        buyBtn.backgroundColor = COLOR_ff6060;
        [buyBtn setTitleColor:COLOR_ffffff forState:UIControlStateNormal];
        [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        buyBtn.titleLabel.font = DEF_MyFont(13);
        [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        buyBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(100)-DEF_RESIZE_UI(10), shopCartBtn.y+DEF_RESIZE_UI(10), DEF_RESIZE_UI(100), DEF_RESIZE_UI(30));
    }
    return self;
}


/**
 *  立即购买按钮
 */
-(void)buyBtnClick{
    self.buttonBlock();
}
/**
 *  加入购物车按钮
 */
-(void)shopCartBtnClick{
  self.addCartBlock();
}

-(void)setWork:(Work *)work{
    _work = work;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:work.imgUrl] placeholderImage:DEF_IMAGENAME(@"global_default_img")];
    self.worksNameLb.text = work.workName;
    self.artistNameLb.text = work.artistName;
    self.workTypeLb.text = work.workType;
    self.workIntroLb.text = work.workIntro;
    self.workPriceLb.text = [NSString stringWithFormat:@"¥%@",work.workPrice];
    CGSize maxSize = CGSizeMake(DEF_RESIZE_UI(140), DEF_RESIZE_UI(13));
    CGSize textSize = [ATUtility sizeOfString:work.workName withMaxSize:maxSize andFont:self.worksNameLb.font];
    if (work.workName&&textSize.width<=1.0) {
        self.worksNameLb.frame = (CGRect){DEF_RESIZE_UI(10), CGRectGetMaxY(self.imgView.frame)+DEF_RESIZE_UI(10),maxSize};
    }
    else{
     self.worksNameLb.frame = (CGRect){DEF_RESIZE_UI(10), CGRectGetMaxY(self.imgView.frame)+DEF_RESIZE_UI(10),textSize};
    }
     self.artistNameLb.frame = CGRectMake(CGRectGetMaxX(self.worksNameLb.frame)+DEF_RESIZE_UI(10), self.worksNameLb.y+DEF_RESIZE_UI(2), DEF_RESIZE_UI(40), DEF_RESIZE_UI(13));
     self.workTypeLb.frame = CGRectMake(CGRectGetMaxX(self.artistNameLb.frame)+DEF_RESIZE_UI(5), self.worksNameLb.y+DEF_RESIZE_UI(2), DEF_RESIZE_UI(30), DEF_RESIZE_UI(13));
     self.workIntroLb.frame = CGRectMake(CGRectGetMaxX(self.workTypeLb.frame)+DEF_RESIZE_UI(5), self.worksNameLb.y+DEF_RESIZE_UI(2), DEF_RESIZE_UI(100), DEF_RESIZE_UI(13));
}

@end
