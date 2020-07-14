//
//  KTHuoXingViewController.h
//  每诺鲜
//
//  Created by Mac on 16/10/15.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KTHuoXingViewController;
@protocol HuoXingViewControllerDelegate <NSObject>

- (void)huoXingViewController:(KTHuoXingViewController *)vc andAdress:(NSString *)adress;

@end

@interface KTHuoXingViewController : UIViewController

@property (nonatomic,weak) id <HuoXingViewControllerDelegate> delegate;

@end
