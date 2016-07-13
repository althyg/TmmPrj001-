//
//  ChoseAddressController.h
//  arthome
//
//  Created by 海修杰 on 16/5/17.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^AddressChoseBlock)(NSString * userName,NSString * userPhone,NSString *shippingAddress,NSString *locationId);

@interface ChoseAddressController : UIViewController

@property (nonatomic,copy) AddressChoseBlock  addressChoseBlock;

@end
