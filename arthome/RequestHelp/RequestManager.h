//
//  RequestManager.h
//  EconomicAnalysis
//
//  Created by CaiMiao on 15/12/4.
//  Copyright © 2015年 Huo.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHelp.h"

@interface RequestManager : NSObject
#pragma mark ------------------------登录-----------------------------------------
/**
 *  登录
 */
+(void)mineLoginWithParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock;
#pragma mark ------------------------用户中心--------------------------------------
/**
 *  用户中心艺术家
 */
+(void)mineInfoArtistWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  用户中心普通用户
 */
+(void)mineInfoNormalWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;

#pragma mark ------------------------艺术品---------------------------------------
/**
 *  艺术品
 */
+ (void)findHomepageWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock;
/**
 *  艺术品详情
 */
+ (void)findArtdetailWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  加入购物车
 */
+(void)findPutIntoCartWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock;
/**
 *  订单确认
 */
+(void)findOrderconfirWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock;
#pragma mark ------------------------艺术家---------------------------------------
#pragma mark ------------------------资讯-----------------------------------------
/**
 *  用户资料上传
 */
+(void)mineInfoUploadWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  用户资料下载
 */
+(void)mineInfoDownloadWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock;
/**
 *  获取验证码
 */
+(void)mineGetAuthCodeWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock;
/**
 *  设置登录密码
 */
+(void)mineLoginPwdSettingWithParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock;
/**
 *  修改登录密码
 */
+(void)mineLoginPwdChangeWithParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock;
#pragma mark ------------------------购物车---------------------------------------
/**
 *  购物车
 */
+(void)mineshopcartWithParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock;



/**
 *  收藏列表
 */
+(void)minecollectionWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  关注列表
 */
+(void)minefocusWithParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock;
/**
 *  粉丝列表
 */
+(void)minefunsWithParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock;
/**
 *  购物车删除
 */
+(void)mineDeletecartWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  新建收货地址
 */
+(void)mineCreataddressWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock;
/**
 *  收货地址列表
 */
+(void)mineAddressesWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock;
/**
 *  修改收货地址upload
 */
+(void)mineAddressUpLoadWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock;
/**
 *  修改收货地址download
 */
+(void)mineAddressDownLoadWithParametersDic:(NSDictionary *)parameterDic
                                    success:(void (^)(NSDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock;
/**
 *  删除收货地址
 */
+(void)mineDeleteaddressWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock;
/**
 *  意见反馈
 */
+(void)mineFeedBackWithParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock;
/**
 *  注册
 */
+(void)mineRegisterWithParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock;
/**
 *  忘记密码
 */
+(void)mineGetBackPwdWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;

/**
 *  发现首页的内容
 */
+ (void)findHomeContentWithParametersDic:(NSDictionary *)parameterDic success:(void(^)(NSDictionary *result))successBlock failture:(void (^)(id result))failtureBlock;

/**
 *  艺术家首页
 */
+(void)artistHomepageWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  艺术家关注
 */
+(void)artistFocusWithParametersDic:(NSDictionary *)parameterDic
                            success:(void (^)(NSDictionary *result))successBlock
                           failture:(void (^)(id result))failtureBlock;
/**
 *  艺术家详情页
 */
+(void)artistChamberWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock;
/**
 *  艺术家作品集
 */
+(void)artistArtWorksWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  搜索艺术品
 */
+(void)artistArtSearchWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock;
/**
 *  艺术家搜索
 */
+(void)artistArtistSearchWithParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock;
/**
 *  获取订单号
 */
+(void)findGetordernoWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  绑定手机号验证码
 */
+(void)mineBindConfirWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  绑定重置密码
 */
+(void)mineBindResetPwdWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock;
/**
 *  第三方登录
 */
+(void)mineThirdLoginWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  艺术品收藏
 */
+(void)findArtLikeWithParametersDic:(NSDictionary *)parameterDic
                            success:(void (^)(NSDictionary *result))successBlock
                           failture:(void (^)(id result))failtureBlock;
/**
 *  申请退款
 */
+(void)mineRefundUploadWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock;
/**
 *  退款详情
 */
+(void)mineRefundDetailWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock;
/**
 *  订单详情
 */
+(void)mineOrderDetailWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock;
/**
 *  订单列表
 */
+(void)mineOrderListWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock;
/**
 *  关闭交易
 */
+(void)mineCloseTradeWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock;
/**
 *  确认收货
 */
+(void)mineAffirmReceiveWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock;
/**
 *  选择地址为默认地址
 */
+(void)mineChoseDefaultedWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock;
@end

