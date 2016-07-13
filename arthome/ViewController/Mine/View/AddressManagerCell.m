//
//  AddressManagerCell.m
//  arthome
//
//  Created by 海修杰 on 16/6/29.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AddressManagerCell.h"

@interface AddressManagerCell ()

@property (nonatomic,weak) UILabel * userName ;

@property (nonatomic,weak) UILabel * userPhone ;

@property (nonatomic,weak) UILabel * addressLb ;

@property (nonatomic,weak) UIImageView * arrowImgView ;

@property (nonatomic,weak) UIView * partingView ;

@property (nonatomic,strong) UIButton * defaultedBtn ;

@end

@implementation AddressManagerCell

+(instancetype)addressManagerCellFromTableView:(UITableView *) tableView{
    static NSString *reuseId = @"AddressManagerCell";
    AddressManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
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
        UIView *partingView = [[UIView alloc]init];
        [self.contentView addSubview:partingView];
        partingView.backgroundColor = COLOR_f2f2f2;
        partingView.frame = CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_RESIZE_UI(10));
        //收货人姓名
        UILabel *userName = [[UILabel alloc]init];
        [self.contentView addSubview:userName];
        self.userName = userName;
        userName.textAlignment = NSTextAlignmentLeft;
        userName.textColor = COLOR_666666;
        userName.font = DEF_MyBoldFont(14);
        userName.frame = CGRectMake(DEF_RESIZE_UI(20),CGRectGetMaxY(partingView.frame)+DEF_RESIZE_UI(13), DEF_RESIZE_UI(60), DEF_RESIZE_UI(15));
        
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
        downLine.frame = CGRectMake(0, CGRectGetMaxY(addressLb.frame)+DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(1));
        
        //是否默认
        UIButton *defaultedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:defaultedBtn];
        self.defaultedBtn = defaultedBtn;
        defaultedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, DEF_RESIZE_UI(10), 0, 0);
        [defaultedBtn setTitle:@"默认地址" forState:UIControlStateNormal];
        [defaultedBtn setTitleColor:COLOR_da1025 forState:UIControlStateNormal];
        [defaultedBtn setImage:DEF_IMAGENAME(@"global_item_selected") forState:UIControlStateNormal];
        defaultedBtn.imageView.contentMode = UIViewContentModeCenter;
        defaultedBtn.titleLabel.font = DEF_MyFont(11);
        defaultedBtn.frame = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(downLine.frame), DEF_RESIZE_UI(80), DEF_RESIZE_UI(36));
        //删除
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:deleteBtn];
        deleteBtn.titleLabel.font = DEF_MyFont(12);
        deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, DEF_RESIZE_UI(10), 0, 0);
        [deleteBtn setImage:DEF_IMAGENAME(@"mine_address_delete") forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        deleteBtn.frame = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(80), defaultedBtn.y, DEF_RESIZE_UI(60), DEF_RESIZE_UI(36));
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //编辑
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:editBtn];
        editBtn.titleLabel.font = DEF_MyFont(12);
        editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, DEF_RESIZE_UI(10), 0, 0);
        [editBtn setImage:DEF_IMAGENAME(@"mine_address_edit") forState:UIControlStateNormal];
        [editBtn setTitle:@"修改" forState:UIControlStateNormal];
        [editBtn setTitleColor:COLOR_999999 forState:UIControlStateNormal];
        editBtn.frame = CGRectMake(CGRectGetMinX(deleteBtn.frame)-DEF_RESIZE_UI(70), defaultedBtn.y, DEF_RESIZE_UI(60), DEF_RESIZE_UI(36));
        [editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setAddressDetail:(AddressDetail *)addressDetail{
    _addressDetail = addressDetail;
    self.userName.text = addressDetail.userName;
    self.userPhone.text = addressDetail.userPhone;
    self.addressLb.text = addressDetail.shippingAddress;
    self.defaultedBtn.alpha = [addressDetail.isDefaulted integerValue];
}

-(void)deleteBtnClick{
    self.blockDelete();
}
-(void)editBtnClick{
    self.blockEdit();
}

@end
