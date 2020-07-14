//
//  KTSuperMarketLeftModel.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KTSuperMarketRightModel;
@interface KTSuperMarketLeftModel : NSObject

@property (nonatomic,copy) NSString *signName;
@property (nonatomic,copy) NSString *hotImg;

@property (nonatomic,assign) NSNumber *idNumber;

@property (nonatomic,strong) NSArray <KTSuperMarketRightModel *> *arrModel;

+ (NSArray <KTSuperMarketLeftModel *> *)superMarketLeftArrModel;

@end
