//
//  KTAddressModel.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAddressModel.h"

@implementation KTAddressModel
+ (instancetype)addressModelWith:(NSDictionary *)dict{
    id instance = [[self alloc]init];
    [instance setValuesForKeysWithDictionary:dict];
    return instance;

}
@end
