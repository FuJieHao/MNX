//
//  ReceiptAddressView.h
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ModifyBtnCliked)();
@interface ReceiptAddressView : UIView

- (instancetype)initWithFrame:(CGRect)frame modify:(ModifyBtnCliked)modifyBtnCliked ;
@end
