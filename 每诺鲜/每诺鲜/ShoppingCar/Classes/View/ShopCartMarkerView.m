//
//  ShopCartMarkerView.m
//
//  OrderPayWayViewController.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//


#import "ShopCartMarkerView.h"

@implementation ShopCartMarkerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_lighting"]];
        [self addSubview:imageView];
        
        UILabel *marketTitleLabel = [[UILabel alloc]init];
        marketTitleLabel.text = @"闪送超市";
        marketTitleLabel.font = [UIFont systemFontOfSize:12];
        marketTitleLabel.textColor = [UIColor lightGrayColor];
        [marketTitleLabel sizeToFit];
        [self addSubview:marketTitleLabel];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(self);
            
        }];
        [marketTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(imageView.mas_trailing).offset(15);
            make.centerY.equalTo(imageView);
        }];
    }
    return self;
}

@end
