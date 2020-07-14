//
//  KTHuoXingViewController.m
//  每诺鲜
//
//  Created by Mac on 16/10/15.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHuoXingViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface KTHuoXingViewController () <CLLocationManagerDelegate>

@property (nonatomic,copy) NSString *adressStr;

@end

@implementation KTHuoXingViewController
{
    CLLocationManager * locationManager;
    NSString * currentCity;//当前城市
}

- (IBAction)openAdress:(UIButton *)sender {
    
    [self locate];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

-(void)locate{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        //        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc]init];
        [locationManager startUpdatingLocation];
    }
    
}

#pragma mark CoreLocation delegate

//定位失败则执行此代理方法
//定位失败弹出提示框，点击"打开定位"按钮,则会打开系统的设置，提示打开定位服务

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settinsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settinsURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            
            NSLog(@"%@",currentCity); //这就是当前的城市
            self.adressStr = [NSString stringWithFormat:@"%@ %@",currentCity, placeMark.name];

        }else if (error == nil && placemarks.count == 0){
            NSLog(@"No location and error return");;
        }else if (error){
            NSLog(@"location error: %@ ",error);
        }
    }];
    [locationManager stopUpdatingLocation];
}

- (void)back
{
    if ([self.delegate respondsToSelector:@selector(huoXingViewController:andAdress:)]) {
        [self.delegate huoXingViewController:self andAdress:self.adressStr];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
