//
//  KTHPFreshModel.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHPFreshModel.h"

@implementation KTHPFreshModel

+ (instancetype)freshModel
{
    KTHPFreshModel *model = [[self alloc]init];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aixianfeng.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = dict[@"data"][@"act_info"][5][@"act_rows"];
    NSString *freshImg = arr[0][@"act_rows"][0][@"chead_detail"][@"img"];
    NSString *recommendImg = arr[1][@"act_rows"][0][@"cactivity_detail"][@"img"];
    NSString *buyImg = arr[1][@"act_rows"][1][@"cactivity_detail"][@"img"];
    
    NSString *moreGoodImg = arr[2][@"act_rows"][0][@"cgoods_detail"][@"goods"][2][@"img"];
    
    NSDictionary *dict_1 = arr[2][@"act_rows"][0][@"cgoods_detail"][@"goods"][0];
    
    KTHPFreshGoods1Model *model_1 = [[KTHPFreshGoods1Model alloc]init];
    
    
    model_1.name = dict_1[@"name"];
    model_1.specifics = dict_1[@"specifics"];
    model_1.market_price = dict_1[@"market_price"];
    
    model_1.partner_price = dict_1[@"partner_price"];
    model_1.img = dict_1[@"img"];
    
    model.model_1 = model_1;
    
    KTHPFreshGoods2Model *model_2 = [[KTHPFreshGoods2Model alloc]init];
    
    NSDictionary *dict_2 = arr[2][@"act_rows"][0][@"cgoods_detail"][@"goods"][1];
    
    model_2.name = dict_2[@"name"];
    model_2.specifics = dict_2[@"specifics"];
    model_2.market_price = dict_2[@"market_price"];
    model_2.partner_price = dict_2[@"partner_price"];
    model_2.img = dict_2[@"img"];
    
    model.model_2 = model_2;
    
    model.freshImg = freshImg;
    model.recommendImg = recommendImg;
    model.buyImg = buyImg;
    model.moreGoodImg = moreGoodImg;
    return model;
}

@end
