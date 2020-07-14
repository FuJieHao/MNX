//
//  KTdetailModel.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//banner_img : "http://img01.bqstatic.com//upload/activity/cms_113589_1473842395.jpg@90Q.jpg"
//

#import <Foundation/Foundation.h>

@interface KTdetailModel : NSObject
@property (nonatomic,copy) NSString *banner_img;
@property (nonatomic,strong) NSDictionary *category_detail;
@property (nonatomic,strong) NSArray *dataArray;
+ (instancetype)detailModelWithDict:(NSDictionary *)dict;
@end
