//
//  ATUserInfo.h
//  arthome
//
//  Created by 海修杰 on 16/3/14.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ATUserInfo : NSObject

+(instancetype)shareUserInfo;
/**
 *  appToken
 */
@property (nonatomic,copy) NSString * appToken;
/**
 *  用户类型
 */
@property (nonatomic,copy) NSString * userType;
/**
 *  手机号
 */
@property (nonatomic,copy) NSString * phone;
/**
 *  昵称
 */
@property (nonatomic,copy) NSString * nickName;
/**
 *  头像图片url
 */
@property (nonatomic,copy) NSString * headUrl;
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
 *  是否绑定手机
 */
@property (nonatomic,copy) NSString * phoneBind;
/**
 *  userName
 */
@property (nonatomic,copy) NSString * userName;
/**
 *  usid
 */
@property (nonatomic,copy) NSString * usid;
/**
 *  accessToken
 */
@property (nonatomic,copy) NSString * accessToken;
/**
 *  iconURL
 */
@property (nonatomic,copy) NSString * iconURL;
/**
 *  artistTip
 */
@property (nonatomic,copy) NSString *isArtistTip ;

- (void)userInformationFormLoginData:(NSDictionary *)infoDic;

-(void)saveAccountToSandBox;

-(void)clearUserInfo;

@end
