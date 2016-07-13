//
//  RequestHelp.m
//  dahai
//
//  Created by CaiMiao on 15/11/19.
//  Copyright © 2015年 HaiXiuJie. All rights reserved.
//

#import "RequestHelp.h"
#import "ATUserInfo.h"
#import "ApiDefine.h"

@interface RequestHelp()

@property (nonatomic ,strong ,readonly) NSDictionary *universalParameters;              /** 通用参数 */
@property (nonatomic ,strong ,readonly) NSArray *unNeedAddUniversalParameterList;       /** 不需要增加通用参数的接口集合 */
@end

@implementation RequestHelp

static RequestHelp * operationManager;

+(RequestHelp *)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationManager = [[RequestHelp alloc] init];
        operationManager.requestSerializer.timeoutInterval = 15;
//        operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    return operationManager;
}

/**
 *  网络请求成功处理
 */
+ (void)requestSuccess:(id)responseObject operation:(NSURLSessionTask *)operation finishHandle:(successBlock)finishHandle failHandle:(failtureBlock)failHandle{
    if (responseObject[@"code"] || [responseObject[@"code"] integerValue] == 200) {
        //正确逻辑处理
        finishHandle(responseObject);
    }else
    {
        //错误逻辑处理
        [[iToast makeText:responseObject[@"message"]] show];
        
        NSError *error = [NSError errorWithDomain:ERRORDAOMAIN code:[responseObject[@"code"] integerValue] userInfo:responseObject];
        failHandle(error);
    }
}

/**
 *  网络请求失败处理
 */
+ (void)requestError:(NSError *)error operation:(NSURLSessionTask *)operation failHandle:(failtureBlock)failHandle{
    NSString *message;
    
    if(error.code == kCFURLErrorNotConnectedToInternet || error.code == kCFURLErrorCannotConnectToHost)
    {
        message = @"网络不可用，请检查网络连接";
    }else if (error.code == kCFURLErrorTimedOut)
    {
        message = @"网络请求超时";
    }else
    {
        message = @"请求失败，请稍后再试";
    }
    
    [[iToast makeText:message] show];
    
    CC_LOG_VALUE(error.localizedDescription);
    
    failHandle(error);
}

//带图片的post请求
+ (RequestHelp *)requestPostImageWithParameters:(NSDictionary *)parameters
                                      urlString:(NSString *)urlString
                                   finishHandle:(successBlock)finishHandle
                                     failHandle:(failtureBlock)failHandle
{
    
    RequestHelp * manager = [[RequestHelp alloc] initWithBaseURL:[NSURL URLWithString:DEF_IPAddress]];
    
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    [para removeObjectForKey:@"pics"];
    
    NSDictionary *dic = [manager addParametersForWithUrlPath:urlString :para];
    urlString = [NSString stringWithFormat:@"%@/%@",UPLOAD_IPAddress,urlString];
    [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *keys = [parameters[@"pics"] allKeys];
        
        for (NSString *key in keys)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(parameters[@"pics"][key], 1.0f) name:@"file" fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/jpg"];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [RequestHelp requestSuccess:responseObject operation:task finishHandle:finishHandle failHandle:(failtureBlock)failHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [RequestHelp requestError:error operation:task failHandle:failHandle];
        
    }];
    
    return manager;
}

/**
 *  get请求
 */
+ (RequestHelp *)requestGetWithParameters:(NSDictionary *)parameters
                                urlString:(NSString *)urlString
                             finishHandle:(successBlock)finishHandle
                               failHandle:(failtureBlock)failHandle
{
    RequestHelp *manager = [RequestHelp shareInstance];
    
    NSDictionary *dic = [manager addParametersForWithUrlPath:urlString :parameters];
    urlString = [NSString stringWithFormat:@"%@/%@",DEF_IPAddress,urlString];
    [manager GET:urlString parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"--------\n%@\n--------%@\n",task.response,responseObject);
        [RequestHelp requestSuccess:responseObject operation:task finishHandle:finishHandle failHandle:(failtureBlock)failHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"======\n%@======\n%@\n",task,error);
        [RequestHelp requestError:error operation:task failHandle:failHandle];
    }];
    
    return manager;
}

/**
 *  post请求
 */
+ (RequestHelp *)requestPostWithParameters:(NSDictionary *)parameters
                                 urlString:(NSString *)urlString
                              finishHandle:(successBlock)finishHandle
                                failHandle:(failtureBlock)failHandle
{
    RequestHelp *manager = [RequestHelp shareInstance];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    
    NSDictionary *dic = [manager addParametersForWithUrlPath:urlString :parameters];
    
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [RequestHelp requestSuccess:responseObject operation:task finishHandle:finishHandle failHandle:(failtureBlock)failHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [RequestHelp requestError:error operation:task failHandle:failHandle];
    }];
    return manager;
}

#pragma mark - private

/**
 *  所有接口增加参数
 */
- (NSDictionary *)addParametersForWithUrlPath:(NSString *)urlPath :(NSDictionary *)paras{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:paras];
    [dic addEntriesFromDictionary:self.universalParameters];
    return dic;
}

#pragma mark - getter、setter

/**
 *  通用参数
 */
-(NSDictionary *)universalParameters{
    if ([ATUserInfo shareUserInfo].appToken) {
        return @{
                 @"appToken":[ATUserInfo shareUserInfo].appToken
                 };
    }
    else{
        return nil;
    }
}

@end
