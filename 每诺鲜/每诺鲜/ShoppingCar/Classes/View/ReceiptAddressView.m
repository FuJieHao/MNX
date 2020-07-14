//
//  ReceiptAddressView.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "ReceiptAddressView.h"

@interface ReceiptAddressView()


@property (nonatomic,strong) UILabel *consigneeLabel;
@property (nonatomic,strong) UILabel *receiptLabel;

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UIImageView *bottomImageView;
@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,copy) ModifyBtnCliked modifyBtnCliked;

@end

@implementation ReceiptAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
        _bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
        [self addSubview:_topImageView];
        [self addSubview:_bottomImageView];
        
        _consigneeLabel = [[UILabel alloc]init];
        [self initLabel:_consigneeLabel title:@"每诺鲜^需要您的精确坐标😍😘"];
        
        _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
        [self addSubview:_arrowImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyAddress)];
        _consigneeLabel.userInteractionEnabled = YES;
        [_consigneeLabel addGestureRecognizer:tap];
    }
    return self;
}

//布局子控件
- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat leftMargin = 15;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.topImageView.frame = CGRectMake(0, 0, width, 2);
    self.bottomImageView.frame = CGRectMake(0, height - 2, width, 2);
    
    self.consigneeLabel.frame = CGRectMake(leftMargin, (height - self.arrowImageView.frame.size.height) * 0.5, self.consigneeLabel.frame.size.width, self.consigneeLabel.frame.size.height);
    
    //***格式设置
    self.consigneeLabel.textColor = [UIColor colorWithRed:157/255.0 green:194/255.0 blue:95.0/255.0 alpha:1];
    self.consigneeLabel.font = [UIFont systemFontOfSize:15];
    [self.consigneeLabel sizeToFit];

    self.arrowImageView.frame = CGRectMake(width - 15, (height - self.arrowImageView.frame.size.height) * 0.5, self.arrowImageView.frame.size.width, self.arrowImageView.frame.size.height);
}

- (void)initLabel:(UILabel *)label title:(NSString *)text {
    label.text = text;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    [self addSubview:label];
}

- (void)modifyAddress {
    if (self.modifyBtnCliked) {
        self.modifyBtnCliked();
    }
}

- (instancetype)initWithFrame:(CGRect)frame modify:(ModifyBtnCliked)modifyBtnCliked {
    self = [self initWithFrame:frame];
    self.modifyBtnCliked = modifyBtnCliked;
    return self;
}

@end
