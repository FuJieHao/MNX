//
//  KTdetailModel.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTdetailModel.h"
#import "KTdetailModel2.h"

@implementation KTdetailModel
+ (instancetype)detailModelWithDict:(NSDictionary *)dict{
    
    id instance = [[self alloc]init];
    [instance setValuesForKeysWithDictionary:dict];
    return instance;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

- (void)setCategory_detail:(NSDictionary *)category_detail{
    NSArray <NSDictionary*>*array = category_detail[@"goods"];
    NSMutableArray *mArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KTdetailModel2 *model = [KTdetailModel2 detailModel2WithDict:obj];
        [mArray addObject:model];
    }];
    self.dataArray = mArray;

}

@end
