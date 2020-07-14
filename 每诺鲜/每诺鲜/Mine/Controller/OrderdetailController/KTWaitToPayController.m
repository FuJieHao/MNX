//
//  KTWaitToPayController.m
//  KTAiXianFeng
//
//  Created by 周东川 on 2016/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTWaitToPayController.h"

@interface KTWaitToPayController ()

@end

@implementation KTWaitToPayController

-(void)setupUI {
    
    UIImageView *orderImage = [[UIImageView alloc]init];
    orderImage.image = [UIImage imageNamed:@"OJ{(C1M[IDC2VQ`QH[74CQA"];
    [orderImage sizeToFit];
    [self.view addSubview:orderImage];
    [orderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(20);
        make.height.offset(500);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
