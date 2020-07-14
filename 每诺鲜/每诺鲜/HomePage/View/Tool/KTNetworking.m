//
//  KTNetworking.m
//  爱鲜蜂接口调试
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "KTNetworking.h"

@implementation KTNetworking

+ (KTNetworking *)shareInstance
{
    static KTNetworking *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:@"http://iosapi.itcast.cn/loveBeen/"];
        
        instance = [[KTNetworking alloc]initWithBaseURL:url];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    
    return instance;
}

+ (void)getUrlString:(NSString *)url
           withParam:(NSDictionary *)param
           withSuccessBlock:(responseBlock)responseObjects
           withErrorBlock:(failedBlock)errors
{
    [[self shareInstance] GET:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        responseObjects(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errors(error);
    }];
}

+ (void)postUrlString:(NSString *)url
            withParam:(NSDictionary *)param
            withSuccessBlock:(responseBlock)responseObjects
            withErrorBlock:(failedBlock)errors
{
    [[self shareInstance] POST:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        responseObjects(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errors(error);
    }];
}

@end
