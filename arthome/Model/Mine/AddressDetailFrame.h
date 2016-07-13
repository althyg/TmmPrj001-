//
//  AddressDetailFrame.h
//  arthome
//
//  Created by 海修杰 on 16/4/11.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressDetail.h"

@interface AddressDetailFrame : NSObject

@property (nonatomic,strong) AddressDetail * detail ;

//如果是内部计算出来属性，一般都要定义readonly防止别修改，导致数据错误
@property (nonatomic,assign,readonly) CGRect nameF;

@property (nonatomic,assign,readonly) CGRect phoneF;

@property (nonatomic,assign,readonly) CGRect defaultF;

@property (nonatomic,assign,readonly) CGRect addressF;

@property (nonatomic,assign,readonly) CGRect arrowF;

@property (nonatomic,assign,readonly) CGRect partLineF;

@property (nonatomic,assign,readonly) CGFloat rowHeight;

@end
