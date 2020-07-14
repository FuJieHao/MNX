//
//  KTdetailModel2.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTdetailModel2 : NSObject
@property (nonatomic,copy) NSString *img;

@property (nonatomic,assign) CGFloat partner_price;

@property (nonatomic,copy) NSString *long_name;

+ (instancetype)detailModel2WithDict:(NSDictionary *)dict;

@end
