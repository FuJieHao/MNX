//
//  NetworkTool.h
//  网易新闻
//
//  Created by HM on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>


// 第一步 : 继承自 AFHTTPSessionManager
@interface NetworkTool : AFHTTPSessionManager

/**
 *  网络请求工具类全局访问点
 *
 *  @return AFHTTPSessionManager的实例
 */
+ (instancetype)sharedNetworkTool;

/**
 *  网络请求工具类GET请求的主方法
 *
 *  @param URLString 请求地址
 *  @param success   成功的回调
 *  @param faile     失败的回调
 */
- (void)GETWithURLString:(NSString *)URLString success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile;

@end
