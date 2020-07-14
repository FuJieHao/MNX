//
//  KTTodyVC.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTTodyVC.h"

@interface KTTodyVC ()

@end

@implementation KTTodyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.offset(0);
    }];

    NSString *str = @"https://fresh.jd.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [webView loadRequest:request];
    // Do view setup here.
}

@end
