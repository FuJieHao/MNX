//
//  KTCycleViewModel.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTCycleViewModel.h"

@implementation KTCycleViewModel
+ (instancetype)cycleViewModelWithDict:(NSDictionary *)dict{

    id instance = [[self alloc]init];
    [instance setValuesForKeysWithDictionary:dict];
    return instance;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

- (NSString *)description{

    return [NSString stringWithFormat:@"%@",self.img];
}
@end
