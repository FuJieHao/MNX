//
//  KTMineOrderCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTMineOrderCell : UITableViewCell
@property (nonatomic,copy) void (^oderBlock)();
@end
