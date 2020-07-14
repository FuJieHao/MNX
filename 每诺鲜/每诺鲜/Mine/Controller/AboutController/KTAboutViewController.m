//
//  KTAboutViewController.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAboutViewController.h"

@interface KTAboutViewController ()

@end

@implementation KTAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *aboutImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    aboutImage.image = [UIImage imageNamed:@"start"];
    [aboutImage sizeThatFits:[UIScreen mainScreen].bounds.size];
    [self.view addSubview:aboutImage];
    UILabel *aboutLabel  = [[UILabel alloc]init];
    aboutLabel.text = @"版本号:v1.0.D748";
    aboutLabel.textColor = [UIColor whiteColor];
    [aboutImage addSubview:aboutLabel];
    [aboutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-300);
    }];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"wao"];
    [aboutImage addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-100);
    }];
    // Do any additional setup after loading the view.
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
