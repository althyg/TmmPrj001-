//
//  AddressChoseCell.m
//  arthome
//
//  Created by 海修杰 on 16/7/4.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AddressChoseCell.h"

@interface AddressChoseCell ()

@property (nonatomic,weak) UILabel * userName ;

@property (nonatomic,weak) UILabel * userPhone ;

@property (nonatomic,weak) UILabel * defaultedLb ;

@property (nonatomic,weak) UILabel * addressLb ;

@property (nonatomic,weak) UIView * partingView ;

@end

@implementation AddressChoseCell

+(instancetype)addressChoseCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"AddressChoseCell";
    AddressChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        userName.textColor = COLOR_666666;
        userName.font = DEF_MyBoldFont(14);
        userName.frame = CGRectMake(DEF_RESIZE_UI(20),DEF_RESIZE_UI(13), DEF_RESIZE_UI(60), DEF_RESIZE_UI(15));
        
        //收货人号码
        UILabel * userPhone = [[UILabel alloc]init];
        [self.contentView addSubview:userPhone];
        self.userPhone = userPhone;
        userPhone.textAlignment = NSTextAlignmentRight;
        userPhone.textColor = COLOR_666666;
        userPhone.font = DEF_MyFont(13);
        userPhone.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(120), userName.y, DEF_RESIZE_UI(100), DEF_RESIZE_UI(15));
        
        //地址
        UILabel *addressLb = [[UILabel alloc]init];
        [self.contentView addSubview:addressLb];
        self.addressLb = addressLb;
        addressLb.textColor = COLOR_666666;
        addressLb.font = DEF_MyFont(12);
        addressLb.textAlignment = NSTextAlignmentLeft;
        addressLb.frame = CGRectMake(DEF_RESIZE_UI(20), CGRectGetMaxY(userName.frame)+DEF_RESIZE_UI(11), DEF_DEVICE_WIDTH-DEF_RESIZE_UI(40), DEF_RESIZE_UI(13));
        
        //downLine
        UIView *downLine = [[UIView alloc]init];
        [self.contentView addSubview:downLine];
        downLine.backgroundColor =COLOR_e4e4e4;
        downLine.frame = CGRectMake(0,DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(1));
    }
    return self;
}

-(void)setAddressDetail:(AddressDetail *)addressDetail{
    _addressDetail = addressDetail;
    self.userName.text = addressDetail.userName;
    self.userPhone.text = addressDetail.userPhone;
    self.addressLb.text = addressDetail.shippingAddress;
    self.defaultedLb.alpha = [addressDetail.isDefaulted integerValue];
}

@end
