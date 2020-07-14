//
//  KTscrollModel.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//banner_img : "http://img01.bqstatic.com//upload/activity/2016070117351813.png@90Q.png"

#import <Foundation/Foundation.h>

@interface KTscrollModel : NSObject
@property (nonatomic,copy) NSString *banner_img;
@property (nonatomic,strong) NSDictionary *activ_detail;
@property (nonatomic,strong) NSArray *dataArray;
+ (instancetype)scrollModelWithDict:(NSDictionary *)dict;
@end
