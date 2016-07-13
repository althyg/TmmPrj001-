//
//  OrderConHeaderView.h
//  arthome
//
//  Created by 海修杰 on 16/4/17.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderConHeaderView;

@protocol orderConHeaderViewDelegate <NSObject>

@optional

-(void)addNewAddress:(OrderConHeaderView *) orderConHeaderView;

-(void)choseAddress:(OrderConHeaderView *) orderConHeaderView;

@end

@interface OrderConHeaderView : UIView

-(instancetype)initWithAddressExit:(BOOL) exit;

@property (nonatomic,weak) id <orderConHeaderViewDelegate> deleagate ;

/**
 *  收货人姓名
 */
@property (nonatomic,copy) NSString * receName;
/**
 *  收货人号码
 */
@property (nonatomic,copy) NSString * recePhone;
/**
 *  收货人详细地址
 */
@property (nonatomic,copy) NSString * receLocation;
/**
 *  支付方式
 */
@property (nonatomic,copy) NSString * payStyle ;
@end
