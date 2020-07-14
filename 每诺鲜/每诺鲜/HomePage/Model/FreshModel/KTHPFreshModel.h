//
//  KTHPFreshModel.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTHPFreshGoods1Model.h"
#import "KTHPFreshGoods2Model.h"

@interface KTHPFreshModel : NSObject

@property (nonatomic,copy) NSString *freshImg;
@property (nonatomic,copy) NSString *recommendImg;
@property (nonatomic,copy) NSString *buyImg;

@property (nonatomic,copy) NSString *moreGoodImg;

@property (nonatomic,strong) KTHPFreshGoods1Model *model_1;
@property (nonatomic,strong) KTHPFreshGoods2Model *model_2;

+ (instancetype)freshModel;

@end
