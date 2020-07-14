//
//  KTscrollModel.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTscrollModel.h"
#import "KTscrollModel2.h"

@implementation KTscrollModel
+ (instancetype)scrollModelWithDict:(NSDictionary *)dict{
    
    id instance = [[self alloc]init];
    [instance setValuesForKeysWithDictionary:dict];
    return instance;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@",self.banner_img];
}

- (void)setActiv_detail:(NSDictionary *)activ_detail{
    NSArray <NSDictionary*>*array = activ_detail[@"goods"];
    NSMutableArray *Marray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTscrollModel2 *model2 = [KTscrollModel2 scrollModel2WithDict:obj];
        [Marray addObject:model2];
    }];
    self.dataArray = Marray;



}

@end
