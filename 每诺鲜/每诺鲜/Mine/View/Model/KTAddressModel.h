//
//  KTAddressModel.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTAddressModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *address;

+ (instancetype)addressModelWith:(NSDictionary *)dict;
@end
