//
//  KTHPWebViewController.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHPWebViewController.h"

@interface KTHPWebViewController ()

@end

@implementation KTHPWebViewController

- (instancetype)initWithURL:(NSURL *)URL
{
    if (self = [super init]) {
        
        UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:webView];
        [webView loadRequest:[NSURLRequest requestWithURL:URL]];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
