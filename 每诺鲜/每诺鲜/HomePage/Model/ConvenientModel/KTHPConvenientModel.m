//
//  KTHPConvenientModel.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHPConvenientModel.h"

@implementation KTHPConvenientModel

+ (instancetype)convenientModel
{
    KTHPConvenientModel *model = [[self alloc]init];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aixianfeng.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = dict[@"data"][@"act_info"][4][@"act_rows"];
    NSString *convenientImg = arr[0][@"act_rows"][0][@"chead_detail"][@"img"];
    NSString *sellImg = arr[1][@"act_rows"][0][@"cactivity_detail"][@"img"];
    NSString *discountImg = arr[1][@"act_rows"][1][@"cactivity_detail"][@"img"];
    
    NSMutableArray *arrMList = [NSMutableArray array];
    NSMutableArray *arrMCollection = [NSMutableArray array];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *listView = arr[2][@"act_rows"][i][@"cicons_detail"][@"img"];
        [arrMList addObject:listView];
        NSString *collectionViewCell = arr[3][@"act_rows"][i][@"activity"][@"img"];
        [arrMCollection addObject:collectionViewCell];
    }
    
    model.listViews = arrMList.copy;
    model.collectionViewCell = arrMCollection.copy;
    
    model.convenientImg = convenientImg;
    model.sellImg = sellImg;
    model.discountImg = discountImg;
    return model;
}

@end
