//
//  JGScanHelper.h
//  二维码
//
//  Created by stkcctv on 16/8/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^JGScanSuccessBlock)(NSString *scanResult);

@interface JGScanHelper : NSObject

+ (instancetype)manager;

@property (strong, nonatomic) UIView *scanView;

@property (copy, nonatomic) JGScanSuccessBlock scanBlock;

- (void)createScanSession;

- (void)startRunning;

- (void)stopRunning;

- (void)showLayer:(UIView *)superView;

- (void)setScanningWithscanView:(UIView *)scanView;
@end
