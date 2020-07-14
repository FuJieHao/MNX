//
//  KTclassifyCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTclassifyModel.h"

@interface KTclassifyCell : UITableViewCell
@property (nonatomic,strong) NSArray *modelArray;
@property (nonatomic,copy) void (^btnBlock)(UIButton*);


@end
