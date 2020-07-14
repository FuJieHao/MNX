//
//  KTSuperMarketLeftModel.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTSuperMarketLeftModel.h"
#import "KTSuperMarketRightModel.h"

@implementation KTSuperMarketLeftModel

+ (NSArray <KTSuperMarketLeftModel *> *)superMarketLeftArrModel
{
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"supermarket.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = dict[@"data"][@"categories"];
    
    for (NSDictionary *dict_model in arr) {
        KTSuperMarketLeftModel *model = [[KTSuperMarketLeftModel alloc]init];
        
        model.signName = dict_model[@"name"];
        model.idNumber = dict_model[@"id"];
        
        if (dict_model[@"flag"] != nil) {
            model.hotImg = dict_model[@"flag"];

            [arrM addObject:model];
        }
        
        NSArray *arr = [KTSuperMarketRightModel superMarketRightArrModelWithWhichPage:model];
        model.arrModel = arr;
    }
    return arrM.copy;
}

@end
