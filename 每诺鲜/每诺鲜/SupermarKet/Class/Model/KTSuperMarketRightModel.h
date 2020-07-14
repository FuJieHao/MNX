//
//  KTSuperMarketRightModel.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KTSuperMarketLeftModel;
@interface KTSuperMarketRightModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *specifics;
@property (nonatomic,copy) NSNumber *market_price;
@property (nonatomic,copy) NSNumber *partner_price;
@property (nonatomic,copy) NSString *img;

/**
 *  这里做了仿空判断，也就是你在添加的时候，如果没有值的话，我就设置为@“”，不是Nil。注意
 */
@property (nonatomic,copy) NSString *pm_desc;

+ (NSArray <KTSuperMarketRightModel *> *)superMarketRightArrModelWithWhichPage:(KTSuperMarketLeftModel *)idNumber;

@end
