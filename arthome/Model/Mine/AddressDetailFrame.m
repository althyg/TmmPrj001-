//
//  AddressDetailFrame.m
//  arthome
//
//  Created by 海修杰 on 16/4/11.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "AddressDetailFrame.h"

@implementation AddressDetailFrame

-(void)setDetail:(AddressDetail *)detail{
    _detail = detail;
    
    _nameF = CGRectMake(DEF_RESIZE_UI(10), DEF_RESIZE_UI(10), DEF_RESIZE_UI(80), DEF_RESIZE_UI(14));
    
    _phoneF = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(110+55), DEF_RESIZE_UI(10), DEF_RESIZE_UI(100), DEF_RESIZE_UI(14));
    
    _defaultF = CGRectMake(DEF_RESIZE_UI(10), CGRectGetMaxY(_nameF)+10, DEF_RESIZE_UI(35), DEF_RESIZE_UI(11));
    
    CGSize maxSize = CGSizeMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(100), CGFLOAT_MAX);
    CGSize textSize = [self sizeOfString:self.detail.shippingAddress withMaxSize:maxSize andFont:DEF_MyFont(11)];
    _addressF = (CGRect){DEF_RESIZE_UI(45),CGRectGetMaxY(_nameF)+10,textSize};
    
    _partLineF = CGRectMake(0, CGRectGetMaxY(_addressF)+DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH, 1);
    
    _arrowF = CGRectMake(DEF_DEVICE_WIDTH-DEF_RESIZE_UI(30), CGRectGetMaxY(_partLineF)*0.5-DEF_RESIZE_UI(4), DEF_RESIZE_UI(7), DEF_RESIZE_UI(12));
    
    _rowHeight = CGRectGetMaxY(_partLineF);
    
}

- (CGSize) sizeOfString:(NSString *) text withMaxSize:(CGSize ) maxSize andFont:(UIFont *) font{
    NSDictionary *attr = @{NSFontAttributeName:font} ;
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
