//
//  KTSaoYiSaoViewController.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTSaoYiSaoViewController.h"
#import "JGScanHelper.h"
#import "CZAdditions.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

@interface KTSaoYiSaoViewController ()

@end

@implementation KTSaoYiSaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"qrcode_scanline_qrcode"];
    img.frame = CGRectMake(100, 130, kDeviceWidth - 200, kDeviceWidth - 200);
    [self.view addSubview:img];
    
    self.view.backgroundColor = [UIColor grayColor];
    //扫描定义
    UIView *scanRectView = [UIView new];
    scanRectView.layer.borderColor = [UIColor whiteColor].CGColor;
    scanRectView.layer.borderWidth = 1;
    
    UIView *ssView = [[UIView alloc] initWithFrame:CGRectMake(100, 130, kDeviceWidth - 200, kDeviceWidth - 206)];
    [self.view addSubview:ssView];
    
    //封装方法的调用
    [[JGScanHelper manager] createScanSession];
    [[JGScanHelper manager] showLayer:ssView];
    [[JGScanHelper manager] setScanningWithscanView:scanRectView];
    [[JGScanHelper manager] setScanBlock:^(NSString *scanResult){
        
        if (scanResult) {
            
            [[JGScanHelper manager] stopRunning];
        }

    }];
    
    [[JGScanHelper manager] startRunning];
    
    UILabel *label = [UILabel cz_labelWithText:@"将店铺二维码对准方块内即可收藏店铺" fontSize:11 color:[UIColor whiteColor]];
    label.frame = CGRectMake(100, 120 + kDeviceWidth - 206, kDeviceWidth - 186, 20);
    label.center = self.view.center;
    
    [self.view addSubview:label];
}

@end
