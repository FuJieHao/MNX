//
//  KTMineModuleCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTMineModuleCell : UITableViewCell
@property (nonatomic,copy) void (^adddressBlock)(UIButton*);
@property (nonatomic,copy) void (^jiFControllerBlock)(UIButton*);
@property (nonatomic,copy) void (^viewControllerBlock)(UIButton*);
@property (nonatomic,copy) void (^chatBlock)(UIButton*);
@end
