//
//  KTSuperMarketRightModel.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTSuperMarketRightModel.h"
#import "KTSuperMarketLeftModel.h"

@implementation KTSuperMarketRightModel

+ (NSArray <KTSuperMarketRightModel *> *)superMarketRightArrModelWithWhichPage:(KTSuperMarketLeftModel *)idNumber
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"supermarket.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *idNum = [NSString stringWithFormat:@"%@",idNumber.idNumber];
    
    NSArray *arr = dict[@"data"][@"products"][idNum];
    
    for (NSDictionary *dict in arr) {
        KTSuperMarketRightModel *model = [[KTSuperMarketRightModel alloc]init];
        model.name = dict[@"name"];
        model.specifics = dict[@"specifics"];
        model.market_price = dict[@"market_price"];
        model.partner_price = dict[@"partner_price"];
        model.img = dict[@"img"];
        if (dict[@"pm_desc"] != nil) {
            model.pm_desc = dict[@"pm_desc"];
        } else {
            model.pm_desc = @"";
        }
        [arrM addObject:model];
    }
    
    return arrM.copy;
}

@end
