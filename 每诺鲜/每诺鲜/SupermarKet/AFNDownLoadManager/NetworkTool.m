//
//  NetworkTool.m
//  网易新闻
//
//  Created by HM on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

+ (instancetype)sharedNetworkTool
{
    static NetworkTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 设置相对路径
        NSURL *BaseURL = [NSURL URLWithString:@"https://raw.githubusercontent.com/wangbiaoWB/aixianfei008/master/"];
        // 实例化Manager
        instance = [[self alloc] initWithBaseURL:BaseURL];
        // 增加AFN支持的文件类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    
    return instance;
}

// 网络工具类实现GET请求的主方法
- (void)GETWithURLString:(NSString *)URLString success:(void (^)(id))success faile:(void (^)(NSError *))faile
{
    
    [self GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faile) {
            faile(error);
        }

    }];
}

@end
