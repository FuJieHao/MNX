//
//  KTscrollModel2.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//img : "http://img01.bqstatic.com/upload/goods/000/006/4865/0000064865_60360.jpg@200w_200h_90Q"
//partner_price : 29.9
//long_name : "[次日达]进口牛油果560.0-720g 4粒/盒"

#import <Foundation/Foundation.h>

@interface KTscrollModel2 : NSObject
@property (nonatomic,copy) NSString *img;

@property (nonatomic,strong) NSNumber *partner_price;

@property (nonatomic,copy) NSString *long_name;
+ (instancetype)scrollModel2WithDict:(NSDictionary *)dict;
@end
