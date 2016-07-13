//
//  CreatNewAddreesController.h
//  arthome
//
//  Created by 海修杰 on 16/3/21.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^AddressBlock)();

@interface CreatNewAddreesController : UIViewController

@property (nonatomic,assign) BOOL  isFromOrder;

@property (nonatomic,copy) AddressBlock  addressBlock;

@property (nonatomic,copy) NSString * receName;

@property (nonatomic,copy) NSString * recePhone;

@property (nonatomic,copy) NSString * receLocation;

@end
