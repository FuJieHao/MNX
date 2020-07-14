//
//  KTAddressCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTAddressModel.h"

@interface KTAddressCell : UITableViewCell
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *phoneLabel;
@property (nonatomic,weak) UILabel *addressLabel;
@property (nonatomic,copy) void (^addressCellBlock)(UIButton*,KTAddressModel*);
@property (nonatomic,strong) KTAddressModel *addressModel;
@end
