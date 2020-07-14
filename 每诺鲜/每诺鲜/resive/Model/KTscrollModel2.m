//
//  KTscrollModel2.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTscrollModel2.h"

@implementation KTscrollModel2
+ (instancetype)scrollModel2WithDict:(NSDictionary *)dict{
    
    id instance = [[self alloc]init];
    [instance setValuesForKeysWithDictionary:dict];
    return instance;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}


@end
