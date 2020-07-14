//
//  KTRemarkViewController.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/15.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTRemarkViewController.h"

#import "UserFeedBackViewController.h"
#import "AboutUsViewController.h"

@interface KTRemarkViewController ()

@property (nonatomic, strong) UIView *adviceView;
@property (nonatomic, strong) UIView *textView;

@end

@implementation KTRemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma make - 搭建界面
- (void)setupUI{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"测试";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 150, self.view.frame.size.width, 40);
    button.tag = 100;
    [button setTitle:@"用户反馈" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor = [UIColor redColor];
    button2.frame = CGRectMake(0, 250, self.view.frame.size.width, 40);
    button2.tag = 200;
    [button2 setTitle:@"关于" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

}

- (void)buttonClick:(UIButton *)sender{
    
    if (sender.tag == 100) {
        
        [self.navigationController pushViewController:[[UserFeedBackViewController alloc]init] animated:YES];
        
    }else if (sender.tag == 200){
        
        [self.navigationController pushViewController:[[AboutUsViewController alloc]init] animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
