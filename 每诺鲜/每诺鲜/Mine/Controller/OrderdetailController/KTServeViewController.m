//
//  ViewController.m
//  YYLUIOne
//
//  Created by wangddj on 16/10/15.
//  Copyright © 2016年 wangddj. All rights reserved.
//

#import "KTServeViewController.h"

@interface KTServeViewController ()

@end

@implementation KTServeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) setupUI {
    
    UIImageView *imageV = [[UIImageView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    imageV.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
       // make.centerY.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(100);
        
    }];
    
    UILabel *xinxiLb = [[UILabel alloc] init];
    xinxiLb.text = @"想快速提升便利店的销售额吗?  想让更多客户知道您的店铺吗?  想在便利店的残酷竞争中脱颖而出吗?  一切从加入爱鲜蜂开始,  快快填写您的信息, 做未来的o2o社区入口!";
    xinxiLb.font = [UIFont systemFontOfSize:10];
    [xinxiLb sizeToFit];
    xinxiLb.numberOfLines = 0;
    xinxiLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xinxiLb];
    [xinxiLb mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.right.mas_equalTo(20);
        make.width.mas_equalTo(180);
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageV.mas_bottom).offset(15);
    }];
    /*
     NSTextAlignmentCenter    = 2,
     #endif
     NSTextAlignmentJustified = 3,
     NSTextAlignmentNatural
     */
    
    UILabel *explainLb = [[UILabel alloc] init];
    explainLb.text = @"------   提交申请信息   ------";
    [self.view addSubview:explainLb];
    [explainLb sizeToFit];
    explainLb.font = [UIFont systemFontOfSize:12];
    [explainLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(xinxiLb.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        
    }];
    
    UILabel *userLb = [[UILabel alloc] init];
    userLb.text = @"其中*项为必填项,请认真填写";
    [self.view addSubview:userLb];
    [userLb sizeToFit];
    userLb.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:userLb];
    [userLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(explainLb.mas_bottom).offset(15);
    }];
    
    UILabel *nameLb = [[UILabel alloc]init];
    nameLb.text = @"申请人姓名*";
    [nameLb sizeToFit];
    nameLb.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userLb.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
    }];
    
    UITextField *nameFd = [[UITextField alloc] init];
    [nameFd setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:nameFd];
    [nameFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.top.equalTo(nameLb.mas_bottom).offset(5);
    }];
    
    UILabel *phoneLb = [[UILabel alloc] init];
    phoneLb.text = @"联系电话*";
    [phoneLb sizeToFit];
    phoneLb.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneLb];
    [phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameFd.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
    }];
    
    
    
    UITextField *phoneFd = [[UITextField alloc] init];
    [phoneFd setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:phoneFd];
    [phoneFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.top.equalTo(phoneLb.mas_bottom).offset(5);
    }];
    
    UILabel *shopNameLb = [[UILabel alloc] init];
    shopNameLb.text = @"店铺名称*";
    [shopNameLb sizeToFit];
    shopNameLb.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:shopNameLb];
    [shopNameLb  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(phoneFd.mas_bottom).offset(15);
        
    }];
    
    UITextField *shopNameFd = [[UITextField alloc] init];
    [shopNameFd setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:shopNameFd];
    [shopNameFd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.top.equalTo(shopNameLb.mas_bottom).offset(5);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
