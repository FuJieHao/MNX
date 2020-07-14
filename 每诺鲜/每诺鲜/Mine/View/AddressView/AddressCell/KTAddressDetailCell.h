//
//  KTAddressDetailCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTAddressModel.h"

@interface KTAddressDetailCell : UITableViewCell
@property (nonatomic,strong) KTAddressModel *model1;
@property (nonatomic,copy) void (^popBlock) (KTAddressModel *);
@end
