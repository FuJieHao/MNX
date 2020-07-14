//
//  ShopCartCell.h
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "KTHPOtherGoodsModel.h"
#import "KTModel.h"

@interface ShopCartCell : UITableViewCell

@property (nonatomic,strong) KTModel *goods;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
