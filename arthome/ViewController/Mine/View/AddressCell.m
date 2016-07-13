//
//  AddressCell.m
//  arthome
//
//  Created by 海修杰 on 16/4/11.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell ()

@property (nonatomic,weak) UILabel * userName ;

@property (nonatomic,weak) UILabel * userPhone ;

@property (nonatomic,weak) UILabel * defaultedLb ;

@property (nonatomic,weak) UILabel * addressLb ;

@property (nonatomic,weak) UIImageView * arrowImgView ;

@property (nonatomic,weak) UIView * partingView ;


@end

@implementation AddressCell

+(instancetype)addressCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"AddressCell";
    //  去检测有没有空闲的cell
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        //收货人姓名
        UILabel *userName = [[UILabel alloc]init];
        [self.contentView addSubview:userName];
        self.userName = userName;
        userName.textAlignment = NSTextAlignmentLeft;
        userName.textColor = COLOR_333333;
        userName.font = DEF_MyFont(14);
        
        //收货人号码
        UILabel * userPhone = [[UILabel alloc]init];
        [self.contentView addSubview:userPhone];
        self.userPhone = userPhone;
        userPhone.textAlignment = NSTextAlignmentRight;
        userPhone.textColor = COLOR_666666;
        userPhone.font = DEF_MyFont(14);
     
        //是否默认
        UILabel * defaultedLb = [[UILabel alloc]init];
        [self.contentView addSubview:defaultedLb];
        self.defaultedLb = defaultedLb;
        defaultedLb.text = @"[默认]";
        defaultedLb.textAlignment = NSTextAlignmentLeft;
        defaultedLb.textColor = COLOR_ff6060;
        defaultedLb.font = DEF_MyFont(11);
 
        //收货地址
        UILabel * addressLb = [[UILabel alloc]init];
        [self.contentView addSubview:addressLb];
        self.addressLb = addressLb;
        addressLb.numberOfLines = 0;
        addressLb.textAlignment = NSTextAlignmentLeft;
        addressLb.textColor = COLOR_666666;
        addressLb.font = DEF_MyFont(11);
   
        //添加分割线
        UIView *partingView = [[UIView alloc]init];
        [self.contentView addSubview:partingView];
        self.partingView = partingView;
        partingView.backgroundColor = COLOR_f2f2f2;
        
        //箭头IMG
        UIImageView *arrowImgView = [[UIImageView alloc]initWithImage:DEF_IMAGENAME(@"mine_arrow_right")];
        [self.contentView addSubview:arrowImgView];
        self.arrowImgView = arrowImgView;
    }
    return self;
}

-(void)setAddressDetailFrame:(AddressDetailFrame *)addressDetailFrame{
    _addressDetailFrame = addressDetailFrame;
    [self setDataForSubviews];
    [self setFrameForSubviews];
}

-(void)setDataForSubviews{
    self.userName.text = self.addressDetailFrame.detail.userName;
    self.userPhone.text = self.addressDetailFrame.detail.userPhone;
    self.addressLb.text = self.addressDetailFrame.detail.shippingAddress;
    self.defaultedLb.alpha = [self.addressDetailFrame.detail.isDefaulted integerValue];
}

-(void)setFrameForSubviews{
    self.userName.frame = self.addressDetailFrame.nameF;
    self.userPhone.frame = self.addressDetailFrame.phoneF;
    self.defaultedLb.frame = self.addressDetailFrame.defaultF;
    self.addressLb.frame = self.addressDetailFrame.addressF;
    self.partingView.frame = self.addressDetailFrame.partLineF;
    self.arrowImgView.frame = self.addressDetailFrame.arrowF;
}

@end
