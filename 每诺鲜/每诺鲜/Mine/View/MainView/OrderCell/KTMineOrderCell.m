//
//  KTMineOrderCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTMineOrderCell.h"

@implementation KTMineOrderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIImageView *oderImage = [[UIImageView alloc]init];
    oderImage.image = [UIImage imageNamed:@"222"];
    oderImage.alpha = 0.8;
    oderImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpMyOder:)];
    [oderImage addGestureRecognizer:tap];
    [self.contentView addSubview:oderImage];
    [oderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).offset(0);
        make.height.offset(35);
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"我的订单";
    nameLabel.font = [UIFont systemFontOfSize:13];
    [oderImage addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(oderImage.mas_centerY);
        make.left.equalTo(oderImage.mas_left).offset(13);
       // make.width.offset(100);
    }];
    
    UILabel *allOrderLabel = [[UILabel alloc]init];
    allOrderLabel.text = @"查看全部订单";
    allOrderLabel.textColor = [UIColor redColor];
    allOrderLabel.font = [UIFont systemFontOfSize:13];
    [oderImage addSubview:allOrderLabel];
    [allOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(oderImage.mas_centerY);
        make.right.equalTo(oderImage.mas_right).offset(-13);
    }];
    
    CGFloat scW= [UIScreen mainScreen].bounds.size.width*0.25;
    UIButton *putBtn = [[UIButton alloc]init];
    [putBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    putBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:putBtn];
    [putBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.left.offset(0);
        make.bottom.offset(-15);
        make.width.offset(scW);
    }];
    UILabel *putLabel = [[UILabel alloc]init];
    putLabel.text = @"待付款";
    putLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:putLabel];
    [putLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(putBtn);
        make.top.equalTo(putBtn.mas_bottom).offset(2);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];
    
    UIButton *goosBtn = [[UIButton alloc]init];
    [goosBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [self.contentView addSubview:goosBtn];
    [goosBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.left.equalTo(putBtn.mas_right).offset(0);
        make.bottom.offset(-15);
        make.width.offset(scW);
    }];
    
    UILabel *goosLabel = [[UILabel alloc]init];
    goosLabel.text = @"待收货";
    goosLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:goosLabel];
    [goosLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(goosBtn);
        make.top.equalTo(goosBtn.mas_bottom).offset(2);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];

    
    UIButton *evaluateBtn = [[UIButton alloc]init];
    [evaluateBtn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [self.contentView addSubview:evaluateBtn];
    [evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.left.equalTo(goosBtn.mas_right).offset(0);
        make.bottom.offset(-15);
        make.width.offset(scW);
    }];
    
    UILabel *evaluateLabel = [[UILabel alloc]init];
    evaluateLabel.text = @"待评价";
    evaluateLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:evaluateLabel];
    [evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(evaluateBtn);
        make.top.equalTo(evaluateBtn.mas_bottom).offset(2);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];

    
    UIButton *serviceBtn = [[UIButton alloc]init];
    [serviceBtn setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [self.contentView addSubview:serviceBtn];
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.left.equalTo(evaluateBtn.mas_right).offset(0);
        make.bottom.offset(-15);
        make.width.offset(scW);
    }];
    
    UILabel *serviceLabel = [[UILabel alloc]init];
    serviceLabel.text = @"退款/售后";
    serviceLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:serviceLabel];
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(serviceBtn);
        make.top.equalTo(serviceBtn.mas_bottom).offset(2);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
    }];
    
}

- (void)jumpMyOder:(UITapGestureRecognizer*)sender{
    if (self.oderBlock) {
        self.oderBlock();
    }

}
@end
