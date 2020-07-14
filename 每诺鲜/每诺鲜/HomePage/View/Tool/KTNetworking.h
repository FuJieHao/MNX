//
//  KTNetworking.h
//  爱鲜蜂接口调试
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^responseBlock)(id responseObject);
typedef void (^failedBlock)(NSError *error);

@interface KTNetworking : AFHTTPSessionManager

/**
 *  单例封装（内部进行了baseURL设置，ContentType设置，requestSerializer设置）
 */
+ (KTNetworking *)shareInstance;

/**
 *  GET请求
 *
 *  @param url     请求的后缀
 *  @param param   请求参数设置
 *  @param responseObjects 服务器响应后的回调
 *  @param errors   错误信息回调
 */
+ (void)getUrlString:(NSString *)url
        withParam:(NSDictionary *)param
        withSuccessBlock:(responseBlock)responseObjects
        withErrorBlock:(failedBlock)errors;

/**
 *  POST请求
 *
 *  @param url            请求的后缀
 *  @param param          请求参数设置
 *  @param responseObjects 服务器响应后的回调
 *  @param errors          错误信息回调
 */
+ (void)postUrlString:(NSString *)url
        withParam:(NSDictionary *)param
        withSuccessBlock:(responseBlock)responseObjects
        withErrorBlock:(failedBlock)errors;

@end
