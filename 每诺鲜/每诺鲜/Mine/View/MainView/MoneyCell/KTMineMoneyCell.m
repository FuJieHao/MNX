//
//  KTMineMoneyCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTMineMoneyCell.h"

@implementation KTMineMoneyCell
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
    [self.contentView addSubview:oderImage];
    [oderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).offset(0);
        make.height.offset(35);
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"我的钱包";
    nameLabel.font = [UIFont systemFontOfSize:13];
    [oderImage addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(oderImage.mas_centerY);
        make.left.equalTo(oderImage.mas_left).offset(13);
        // make.width.offset(100);
    }];
    
    CGFloat scW= [UIScreen mainScreen].bounds.size.width/3;
    UIView *balanceView = [[UIView alloc]init];
    //balanceView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:balanceView];
    [balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.left.bottom.equalTo(self.contentView).offset(0);
        make.width.offset(scW);
    }];
    
    UILabel *balanceLabel = [[UILabel alloc]init];
    balanceLabel.text = @"$0.00";
    balanceLabel.font = [UIFont systemFontOfSize:12];
    [balanceView addSubview:balanceLabel];
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(balanceView.mas_centerX).offset(0);
        make.top.equalTo(oderImage.mas_bottom).offset(15);
        make.height.offset(12);
    }];
    
    UILabel *balanceLabel2 = [[UILabel alloc]init];
    balanceLabel2.text = @"余额";
    balanceLabel2.font = [UIFont systemFontOfSize:12];
    [balanceView addSubview:balanceLabel2];
    [balanceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(balanceView.mas_centerX).offset(0);
        make.top.equalTo(balanceLabel.mas_bottom).offset(10);
        make.height.offset(12);
    }];


    
    
    UIView *chargeView = [[UIView alloc]init];
    //chargeView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:chargeView];
    [chargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.left.equalTo(balanceView.mas_right).offset(0);
        make.width.offset(scW);
    }];
    
    UILabel *chargeLabel = [[UILabel alloc]init];
    chargeLabel.text = @"0";
    chargeLabel.font = [UIFont systemFontOfSize:12];
    [chargeView addSubview:chargeLabel];
    [chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chargeView.mas_centerX).offset(0);
        make.top.equalTo(oderImage.mas_bottom).offset(15);
        make.height.offset(12);
    }];
    
    UILabel *chargeLabel2 = [[UILabel alloc]init];
    chargeLabel2.text = @"优惠券";
    chargeLabel2.font = [UIFont systemFontOfSize:12];
    [chargeView addSubview:chargeLabel2];
    [chargeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chargeView.mas_centerX).offset(0);
        make.top.equalTo(chargeLabel.mas_bottom).offset(10);
        make.height.offset(12);
    }];

    
    UIView *integralView = [[UIView alloc]init];
    //integralView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:integralView];
    [integralView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oderImage.mas_bottom).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.left.equalTo(chargeView.mas_right).offset(0);
        make.width.offset(scW);
    }];
    
    UILabel *integralLabel = [[UILabel alloc]init];
    integralLabel.text = @"0";
    integralLabel.font = [UIFont systemFontOfSize:12];
    [integralView addSubview:integralLabel];
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(integralView.mas_centerX).offset(0);
        make.top.equalTo(oderImage.mas_bottom).offset(15);
        make.height.offset(12);
    }];
    
    UILabel *integralLabel2 = [[UILabel alloc]init];
    integralLabel2.text = @"积分";
    integralLabel2.font = [UIFont systemFontOfSize:12];
    [integralView addSubview:integralLabel2];
    [integralLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(integralView.mas_centerX).offset(0);
        make.top.equalTo(integralLabel.mas_bottom).offset(10);
        make.height.offset(12);
    }];



    
}

@end
