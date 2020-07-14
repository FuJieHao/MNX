//
//  YYLFoodCell.h
//  KTAiXianFeng
//
//  Created by wangddj on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KTSuperMarketRightModel;
#import "CZAdditions.h"
#import  <UIImageView+WebCache.h>
@interface YYLFoodCell : UITableViewCell
// 菜品cell,需要的菜品数据
@property (nonatomic, strong) KTSuperMarketRightModel *foodModel;
@end;
