//
//  ShopCarTableFootView.h
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopCartCommentsView.h"


typedef void(^SureButtonCliked)();
@interface ShopCarTableFootView : UIView
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,copy) SureButtonCliked sureButtonCliked;

@property (nonatomic, strong) ShopCartCommentsView *carcommentView;
@end
