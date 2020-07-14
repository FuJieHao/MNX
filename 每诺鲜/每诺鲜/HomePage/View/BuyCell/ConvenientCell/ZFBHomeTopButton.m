//
//  ZFBHomeTopButton.m
//  支付宝
//
//  Created by chao on 16/8/16.
//  Copyright © 2016年 chao. All rights reserved.
//

#import "ZFBHomeTopButton.h"

@implementation ZFBHomeTopButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(0, 0, 60, 50);
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, 25);
    self.imageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 - 10);
    self.titleLabel.center = CGPointMake(self.bounds.size.width * 0.5 + 22, self.bounds.size.height * 0.5 + self.titleLabel.bounds.size.height);
}

@end
