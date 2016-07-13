//
//  RequestManager.m
//  EconomicAnalysis
//
//  Created by CaiMiao on 15/12/4.
//  Copyright © 2015年 Huo.com. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager
#pragma mark ------------------------Member--------------------------------------
/**
 *  用户中心艺术家
 */
+(void)mineInfoArtistWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_Member_InfoArtist
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  用户中心普通用户
 */
+(void)mineInfoNormalWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_Member_InfoNormal
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
#pragma mark ------------------------艺术品---------------------------------------
/**
 *  艺术品首页
 */
+ (void)findHomepageWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_homepage
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}

/**
 *  发现首页的内容
 */
+ (void)findHomeContentWithParametersDic:(NSDictionary *)parameterDic success:(void(^)(NSDictionary *result))successBlock failture:(void (^)(id result))failtureBlock{


    [RequestHelp requestGetWithParameters:parameterDic urlString:k_find_home_content finishHandle:^(id result) {
        successBlock(result);
    } failHandle:^(id result) {
        failtureBlock(result);
    }];

}

/**
 *  艺术品详情
 */
+ (void)findArtdetailWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_artdetail
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  加入购物车
 */
+(void)findPutIntoCartWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_putintocart
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  订单确认
 */
+(void)findOrderconfirWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_orderconfir
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
    
}
#pragma mark ------------------------艺术家---------------------------------------
#pragma mark ------------------------资讯-----------------------------------------
#pragma mark ------------------------购物车---------------------------------------
/**
 *  用户资料上传
 */
+(void)mineInfoUploadWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestPostImageWithParameters:parameterDic urlString:k_mine_infoupload finishHandle:^(id result) {
        successBlock(result);
    } failHandle:^(NSError *result) {
        failtureBlock(result);
    }];
}
/**
 *  用户资料下载
 */
+(void)mineInfoDownloadWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_infodownload
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  设置登录密码
 */
+(void)mineLoginPwdSettingWithParametersDic:(NSDictionary *)parameterDic
                                    success:(void (^)(NSDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_loginpwdchange
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  修改登录密码 loginpwdchange
 */
+(void)mineLoginPwdChangeWithParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_loginpwdchange
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  获取验证码
 */
+(void)mineGetAuthCodeWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_getauthcode
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}

/**
 *  购物车
 */
+(void)mineshopcartWithParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_shopcart
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  收藏列表
 */
+(void)minecollectionWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_collection
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  关注列表
 */
+(void)minefocusWithParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_focus
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  粉丝列表
 */
+(void)minefunsWithParametersDic:(NSDictionary *)parameterDic
                         success:(void (^)(NSDictionary *result))successBlock
                        failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_funs
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  购物车删除
 */
+(void)mineDeletecartWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_deletecart
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
    
}
/**
 *  新建收货地址
 */
+(void)mineCreataddressWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_creataddress
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  修改收货地址upload
 */
+(void)mineAddressUpLoadWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_addressupload
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  修改收货地址download
 */
+(void)mineAddressDownLoadWithParametersDic:(NSDictionary *)parameterDic
                                    success:(void (^)(NSDictionary *result))successBlock
                                   failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_addressdownload
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  收货地址列表
 */
+(void)mineAddressesWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_addresses
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  删除收货地址
 */
+(void)mineDeleteaddressWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_deleteaddress
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}


/**
 *  意见反馈
 */
+(void)mineFeedBackWithParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_feedback
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  登录
 */
+(void)mineLoginWithParametersDic:(NSDictionary *)parameterDic
                          success:(void (^)(NSDictionary *result))successBlock
                         failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_Member_Login
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  注册
 */
+(void)mineRegisterWithParametersDic:(NSDictionary *)parameterDic
                             success:(void (^)(NSDictionary *result))successBlock
                            failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_register
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  忘记密码
 */
+(void)mineGetBackPwdWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_getbackpwd
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  艺术家首页
 */
+(void)artistHomepageWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_artist_homepage
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  艺术家关注
 */
+(void)artistFocusWithParametersDic:(NSDictionary *)parameterDic
                            success:(void (^)(NSDictionary *result))successBlock
                           failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_artist_focus
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  艺术家详情页
 */
+(void)artistChamberWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_artist_chamber
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  艺术家作品集
 */
+(void)artistArtWorksWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_artist_artworks
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  搜索艺术品
 */
+(void)artistArtSearchWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_artsearch
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  艺术家搜索
 */
+(void)artistArtistSearchWithParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_artistsearch
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}

+(void)findGetordernoWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_getorderno
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  绑定手机号验证码
 */
+(void)mineBindConfirWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_bindconfir
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  绑定重置密码
 */
+(void)mineBindResetPwdWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_bindresetpwd
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  第三方登录
 */
+(void)mineThirdLoginWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_thirdlogin
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  艺术品收藏
 */
+(void)findArtLikeWithParametersDic:(NSDictionary *)parameterDic
                            success:(void (^)(NSDictionary *result))successBlock
                           failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_find_artlike
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  申请退款
 */
+(void)mineRefundUploadWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestPostImageWithParameters:parameterDic urlString:k_mine_refundupload finishHandle:^(id result) {
        successBlock(result);
    } failHandle:^(NSError *result) {
        failtureBlock(result);
    }];
    
}
/**
 *  退款详情
 */
+(void)mineRefundDetailWithParametersDic:(NSDictionary *)parameterDic
                                 success:(void (^)(NSDictionary *result))successBlock
                                failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_refunddetail
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  订单详情
 */
+(void)mineOrderDetailWithParametersDic:(NSDictionary *)parameterDic
                                success:(void (^)(NSDictionary *result))successBlock
                               failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_orderdetail
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
    
}
/**
 *  订单列表
 */
+(void)mineOrderListWithParametersDic:(NSDictionary *)parameterDic
                              success:(void (^)(NSDictionary *result))successBlock
                             failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_orderlist
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  关闭交易
 */
+(void)mineCloseTradeWithParametersDic:(NSDictionary *)parameterDic
                               success:(void (^)(NSDictionary *result))successBlock
                              failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_closetrade
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  确认收货
 */
+(void)mineAffirmReceiveWithParametersDic:(NSDictionary *)parameterDic
                                  success:(void (^)(NSDictionary *result))successBlock
                                 failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_affirmreceive
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
/**
 *  选择地址为默认地址
 */
+(void)mineChoseDefaultedWithParametersDic:(NSDictionary *)parameterDic
                                   success:(void (^)(NSDictionary *result))successBlock
                                  failture:(void (^)(id result))failtureBlock{
    [RequestHelp requestGetWithParameters:parameterDic
                                urlString: k_mine_chosedefaulted
                             finishHandle:^(id result) {
                                 successBlock(result);
                             } failHandle:^(id result) {
                                 failtureBlock(result);
                             }];
}
@end




