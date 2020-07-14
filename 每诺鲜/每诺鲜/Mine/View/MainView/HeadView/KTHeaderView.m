//
//  KTHeaderView.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHeaderView.h"

@implementation KTHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor yellowColor];
    UIImageView *backgroundImage = [[UIImageView alloc]init];
    backgroundImage.userInteractionEnabled = YES;
    backgroundImage.image = [UIImage imageNamed:@"v2_my_avatar_bg"];
    [self addSubview:backgroundImage];
    [backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(140);
    }];
    
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setImage:[UIImage imageNamed:@"v2_my_settings_icon"] forState:UIControlStateNormal];
    [backgroundImage addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.top.offset(15);
    }];
    [setBtn addTarget:self action:@selector(jumpToSetController:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *headImage = [[UIImageView alloc]init];
    headImage.image = [UIImage imageNamed:@"author"];
    headImage.layer.cornerRadius= 40;//(值越大，角就越圆)
    headImage.layer.masksToBounds= YES;
    [backgroundImage addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(30);
        make.height.width.offset(80);
        
    }];

    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"开拓创新";
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.font = [UIFont systemFontOfSize:18];
    [backgroundImage addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImage);
        make.left.equalTo(headImage.mas_right).offset(10);
    }];
    
    UIImageView *vipImage = [[UIImageView alloc]init];
    vipImage.image = [UIImage imageNamed:@"icon_next"];
    [vipImage sizeToFit];
    [backgroundImage addSubview:vipImage];
    [vipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel);
        make.top.equalTo(phoneLabel.mas_bottom).offset(15);
        make.height.offset(25);
        make.width.offset(60);
    }];
    
    
    UIImageView *arrowHead = [[UIImageView alloc]init];
    arrowHead.image = [UIImage imageNamed:@"icon_go"];
    [backgroundImage addSubview:arrowHead];
    [arrowHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImage.mas_centerY);
        make.right.offset(-10);
        make.height.offset(15);
        make.width.offset(10);
    }];
    
    UIImageView *btnView = [[UIImageView alloc]init];
    btnView.image = [UIImage imageNamed:@"v2_my_avatar_bg"];
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(60);
    }];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width*0.5;
    UIButton *shopBtn = [[UIButton alloc]init];
    [shopBtn setTitle:@"商品收藏" forState:UIControlStateNormal];
    [shopBtn setImage:[UIImage imageNamed:@"icon_mystore"] forState:UIControlStateNormal];
    shopBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [btnView addSubview:shopBtn];
    [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.equalTo(btnView);
        make.width.offset(screenW);
    }];
    
    
    
    
    UIButton *goodsBtn = [[UIButton alloc]init];
    [goodsBtn setTitle:@"店铺收藏" forState:UIControlStateNormal];
    goodsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [goodsBtn setImage:[UIImage imageNamed:@"icon_tomorrow"] forState:UIControlStateNormal];
    [btnView addSubview:goodsBtn];
    [goodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(btnView);
        make.left.equalTo(shopBtn.mas_right).offset(0);
        make.width.offset(screenW);
    }];
}

- (void)jumpToSetController:(UIButton*)sender{
    if (self.setControllerBlock) {
        self.setControllerBlock(sender);
    }


}
@end
