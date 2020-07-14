//
//  JGScanHelper.m
//  二维码
//
//  Created by stkcctv on 16/8/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "JGScanHelper.h"
//#import "UIView+JGExtension.h"

#import <AVFoundation/AVFoundation.h>

@interface JGScanHelper () <AVCaptureMetadataOutputObjectsDelegate> {

    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_layer;
    AVCaptureMetadataOutput *_output;
    AVCaptureDeviceInput *_input;
    UIView *_superView;
    UIView *_superSuperView;  //传入的所有视图的父视图
    UIButton *_lampBtn;
}

@end


@implementation JGScanHelper

+ (instancetype)manager {
    
    static JGScanHelper *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
      singleton = [[JGScanHelper alloc] init];
    });
    return singleton;
}


//- (void)setSubViewsThroughSuperView:(UIView *)superSuperView {
//    
//    _superSuperView = superSuperView;
//    
//    CGSize windowSize = [UIScreen mainScreen].bounds.size;
//    
//    CGFloat Y = windowSize.height - 250;
//    CGFloat W = 100;
//    CGFloat H = 100;
//    CGFloat LeftMagin = (windowSize.width - W*2 - 75) / 2;
//    
//    
//    CGFloat backBtnX = LeftMagin + W + 75;
//    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(backBtnX, Y, W, H)];
//    [backBtn addTarget:self action:@selector(btnClickToBack) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//}
- (void)btnClickToBack {
    
    [[JGScanHelper manager] stopRunning];
    
    [_superSuperView removeFromSuperview];
}

- (void)createScanSession {
    
        //初始化连接对象
        _session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        //避免模拟器运行崩溃
        if (!TARGET_IPHONE_SIMULATOR) {
            
            //获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            [_session addInput:_input];
            
            //添加输出设备
            _output = [[AVCaptureMetadataOutput alloc] init];
            [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [_session addOutput:_output];
            
            
            [_output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code]];

        }
        
        //添加扫描图层
        _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (void)startRunning {
    
    //开始捕获
    [_session startRunning];
    
    [self lineAnimation];
}

- (void)stopRunning {
    
    //结束捕获
    [_session stopRunning];
    _session = nil;
    
    [_superView removeFromSuperview];
    [self.scanView removeFromSuperview];
    [_layer removeFromSuperlayer];
    
    
}


#pragma mark 初始化扫描界面
-(void)lineAnimation
{
    
    CGRect superFrame = _superView.frame;
    
    UIImageView *line = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, superFrame.size.width, 9)];
    
    line.image = [UIImage imageNamed:@"scanLine"];
    
    [_superView addSubview:line ];
    
    /* 添加动画 */
    
    [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        
        line.frame = CGRectMake(0, superFrame.size.height - 9, superFrame.size.width, 9);
        
    } completion:nil];
  
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        
        if (self.scanBlock) {
            self.scanBlock(object.stringValue);
        }

    }else {
        self.scanBlock(@"没有数据");
    }
}

/**
 *  设置扫描区域
 */
- (void)setScanningWithscanView:(UIView *)scanView {
    
    _output.rectOfInterest = _superView.bounds;

    self.scanView = scanView;
    
    if (self.scanView) {
        self.scanView.frame = _superView.bounds;
        if (_superView) {
            [_superView addSubview:self.scanView];
        }
    }
}

- (void)showLayer:(UIView *)superView {

    _superView = superView;
    _layer.frame = superView.layer.bounds;
    [superView.layer insertSublayer:_layer atIndex:0];
    
}

@end
