//
//  ShopCartCommentsView.h
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^SuccessClickBlock)();
@interface ShopCartCommentsView : UIView

@property (nonatomic, copy) SuccessClickBlock SuccessClickBlock;

@end
