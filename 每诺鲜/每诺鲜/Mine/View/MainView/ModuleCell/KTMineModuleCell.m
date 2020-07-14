//
//  KTMineModuleCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTMineModuleCell.h"

@implementation KTMineModuleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIImageView *topImage = [[UIImageView alloc]init];
    topImage.image = [UIImage imageNamed:@"222"];
    topImage.userInteractionEnabled = YES;
    [self.contentView addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).offset(0);
    }];
    
    UIImageView *bottomImage = [[UIImageView alloc]init];
    bottomImage.image = [UIImage imageNamed:@"222"];
    [self.contentView addSubview:bottomImage];
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.mas_bottom).offset(0);
        make.height.equalTo(topImage.mas_height);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.left.equalTo(self.contentView).offset(0);
    }];
#warning mark - 这里开始添加按钮
    CGFloat scW= [UIScreen mainScreen].bounds.size.width*0.25;
    UIButton *putBtn = [[UIButton alloc]init];
    [putBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [topImage addSubview:putBtn];
    [putBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.offset(0);
        make.bottom.equalTo(topImage.mas_bottom).offset(-25);
        make.width.offset(scW);
    }];
    [putBtn addTarget:self action:@selector(jumpToJiFController:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *putLabel = [[UILabel alloc]init];
    putLabel.text = @"积分商城";
    putLabel.font = [UIFont systemFontOfSize:10];
    [topImage addSubview:putLabel];
    [putLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(putBtn);
        make.top.equalTo(putBtn.mas_bottom).offset(2);
        make.bottom.equalTo(bottomImage.mas_top).offset(-5);
    }];
    
    UIButton *goosBtn = [[UIButton alloc]init];
    [goosBtn setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [topImage addSubview:goosBtn];
    [goosBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(putBtn.mas_right).offset(0);
        make.bottom.equalTo(topImage.mas_bottom).offset(-25);
        make.width.offset(scW);
    }];
#warning mark - 收货按钮添加点击事件
    [goosBtn addTarget:self action:@selector(jumpToAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *goosLabel = [[UILabel alloc]init];
    goosLabel.text = @"收货地址";
    goosLabel.font = [UIFont systemFontOfSize:10];
    [topImage addSubview:goosLabel];
    [goosLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(goosBtn);
        make.top.equalTo(goosBtn.mas_bottom).offset(2);
        make.bottom.equalTo(bottomImage.mas_top).offset(-5);
    }];
    
    
    UIButton *evaluateBtn = [[UIButton alloc]init];
    [evaluateBtn setImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
    [topImage addSubview:evaluateBtn];
    [evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(goosBtn.mas_right).offset(0);
        make.bottom.equalTo(topImage.mas_bottom).offset(-25);
        make.width.offset(scW);
    }];
    [evaluateBtn addTarget:self action:@selector(jumpToChat:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *evaluateLabel = [[UILabel alloc]init];
    evaluateLabel.text = @"我的消息";
    evaluateLabel.font = [UIFont systemFontOfSize:10];
    [topImage addSubview:evaluateLabel];
    [evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(evaluateBtn);
        make.top.equalTo(evaluateBtn.mas_bottom).offset(2);
        make.bottom.equalTo(bottomImage.mas_top).offset(-5);
    }];
    
    
    
    UIButton *serviceBtn = [[UIButton alloc]init];
    [serviceBtn setImage:[UIImage imageNamed:@"8"] forState:UIControlStateNormal];
    [topImage addSubview:serviceBtn];
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(evaluateBtn.mas_right).offset(0);
        make.bottom.equalTo(topImage.mas_bottom).offset(-25);
        make.width.offset(scW);
    }];
    [serviceBtn addTarget:self action:@selector(jumpToViewC:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *serviceLabel = [[UILabel alloc]init];
    serviceLabel.text = @"客服/反馈";
    serviceLabel.font = [UIFont systemFontOfSize:10];
    [topImage addSubview:serviceLabel];
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(serviceBtn);
        make.top.equalTo(serviceBtn.mas_bottom).offset(2);
        make.bottom.equalTo(bottomImage.mas_top).offset(-5);
    }];
    
    
#warning mark - bottomimage 设置
    UIButton *joinBtn = [[UIButton alloc]init];
    [joinBtn setImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];
    [bottomImage addSubview:joinBtn];
    [joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImage.mas_bottom).offset(0);
        make.left.offset(0);
        make.bottom.offset(-25);
        make.width.offset(scW);
    }];
    
    UILabel *joinLabel = [[UILabel alloc]init];
    joinLabel.text = @"成人用品";
    joinLabel.font = [UIFont systemFontOfSize:10];
    [bottomImage addSubview:joinLabel];
    [joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(joinBtn);
        make.top.equalTo(joinBtn.mas_bottom).offset(2);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
}

-(void)jumpToAddress:(UIButton*)sender{
    if (self.adddressBlock) {
        self.adddressBlock(sender);
    }

}

-(void)jumpToJiFController:(UIButton*)sender{
    if (self.jiFControllerBlock) {
        self.jiFControllerBlock(sender);
    }


}

- (void)jumpToViewC:(UIButton*)sender{
    if (self.viewControllerBlock) {
        self.viewControllerBlock(sender);
    }

}

- (void)jumpToChat:(UIButton*)btn{
    if (self.chatBlock) {
        self.chatBlock(btn);
    }

}
@end
