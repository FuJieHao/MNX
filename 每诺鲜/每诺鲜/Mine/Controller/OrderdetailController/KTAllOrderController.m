//
//  KTAllOrderController.m
//  KTAiXianFeng
//
//  Created by 周东川 on 2016/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAllOrderController.h"
//#import "KTOrderDetailCell.h"

//static NSString *orderID = @"orderID";

@interface KTAllOrderController ()// <UITableViewDataSource, UITableViewDelegate>

@end

@implementation KTAllOrderController

- (void)viewDidLoad{
    [self setupUI];

}

-(void)setupUI {
    UIImageView *orderImage = [[UIImageView alloc]init];
    orderImage.image = [UIImage imageNamed:@"68$H1TLGAN86LT5@HMD)B7X"];
    [orderImage sizeToFit];
    [self.view addSubview:orderImage];
    [orderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(20);
        make.height.offset(500);
    }];
    
}
    
@end
