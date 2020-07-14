//
//  ShopCarTableFootView.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "ShopCarTableFootView.h"

@interface ShopCarTableFootView()

@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *sureButton;

@end

@implementation ShopCarTableFootView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        //****添加备注view
        _carcommentView = [[ShopCartCommentsView alloc] init];
        [self addSubview:_carcommentView];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_priceLabel];
        
        _sureButton = [[UIButton alloc]init];
        _sureButton.backgroundColor = [UIColor colorWithRed:253/255.0 green:212/255.0 blue:49/255.0 alpha:1.0];
        [_sureButton setTitle:@"选好了" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureButton addTarget:self action:@selector(sureButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureButton];
        
        
        ///****添加备注约束
        [_carcommentView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self).offset(-50);
        }];
        
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_carcommentView.mas_bottom);
            make.width.mas_equalTo(100);
            make.height.equalTo(_carcommentView);
        }];
        
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(_carcommentView.mas_bottom);
            make.width.mas_equalTo(90);
            make.height.equalTo(_carcommentView);
        }];
    }
    return self;
}

- (void)sureButtonCliked:(id)sender {
    if (self.sureButtonCliked) {
        self.sureButtonCliked();
    }
}

@end
