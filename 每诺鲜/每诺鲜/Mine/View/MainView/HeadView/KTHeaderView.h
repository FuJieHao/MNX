//
//  KTHeaderView.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTHeaderView : UIView
@property (nonatomic,copy) void (^setControllerBlock)(UIButton*);
@end
