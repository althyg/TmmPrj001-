//
//  RequestHelp.h
//  dahai
//
//  Created by CaiMiao on 15/11/19.
//  Copyright © 2015年 HaiXiuJie. All rights reserved.
//

#import "AFNetworking.h"

#define ERRORDAOMAIN  @"error:customer"
/**
 *  请求数据结果block
 */
typedef void(^successBlock)(id result);

typedef void (^failtureBlock)(NSError *error);

@interface RequestHelp : AFHTTPSessionManager

/**
 *  取消request请求
 */
//+ (void)cancelRequestWithPath:(NSString *)path;

/** 
 *  get请求
 */
+ (RequestHelp *)requestGetWithParameters:(NSDictionary *)parameters
                                urlString:(NSString *)urlString
                             finishHandle:(successBlock)finishHandle
                               failHandle:(failtureBlock)failHandle;

/**
 *  post请求
 */
+ (RequestHelp *)requestPostWithParameters:(NSDictionary *)parameters
                                 urlString:(NSString *)urlString
                              finishHandle:(successBlock)finishHandle
                                failHandle:(failtureBlock)failHandle;
/**
 *  带图片的post请求
 */
+ (AFHTTPSessionManager *)requestPostImageWithParameters:(NSDictionary *)parameters
                                                        urlString:(NSString *)urlString
                                                     finishHandle:(successBlock)finishHandle
                                                       failHandle:(failtureBlock)failHandle;
@end
