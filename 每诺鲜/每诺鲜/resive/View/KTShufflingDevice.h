//
//  KTShufflingDevice.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTCycleViewModel.h"

@interface ZFBCycleView : UIView
// 用来接收所有的广告图片
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic,copy) void (^mediationBlock)(UIImageView*);
@property (nonatomic,strong) NSArray <KTCycleViewModel*>* modelArray;
@end
