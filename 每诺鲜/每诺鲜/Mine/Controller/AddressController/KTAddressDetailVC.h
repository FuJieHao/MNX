//
//  KTAddressDetailVC.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTAddressModel.h"

@interface KTAddressDetailVC : UITableViewController
@property (nonatomic,strong) KTAddressModel *addressModel;
@property (nonatomic,copy) void (^addressBlock) (KTAddressModel *);
@end
