//
//  ShopCartCommentsView.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "ShopCartCommentsView.h"

@implementation ShopCartCommentsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
        [self setupUI];
    }
    return self;
}

#pragma make - 搭建界面
- (void)setupUI{

    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"备注";
    [titleLabel sizeToFit];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleLabel];
    
    UILabel *otherLabel = [[UILabel alloc]init];
    otherLabel.text = @"其他要求（如带一盒黄鹤楼）";
    otherLabel.font = [UIFont systemFontOfSize:14];
    otherLabel.textColor = [UIColor grayColor];
    [self addSubview:otherLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
    [self addSubview:arrowImageView];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.width.mas_equalTo(60);
        make.centerY.equalTo(self);
    }];
    [otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20);
    }];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    
    //开启label的交互
    otherLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)];
    [otherLabel addGestureRecognizer:tap];
}

//等待回调
- (void)labelClick:(UIGestureRecognizer *)sender{

    if (self.SuccessClickBlock) {
        self.SuccessClickBlock();
    }
}

@end
