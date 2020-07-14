//
//  KTHPConvenientModel.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTHPConvenientModel : NSObject

@property (nonatomic,copy) NSString *convenientImg;
@property (nonatomic,copy) NSString *sellImg;
@property (nonatomic,copy) NSString *discountImg;

@property (nonatomic,strong) NSArray<NSString *> *listViews;
@property (nonatomic,strong) NSArray<NSString *> *collectionViewCell;

+ (instancetype)convenientModel;

@end
