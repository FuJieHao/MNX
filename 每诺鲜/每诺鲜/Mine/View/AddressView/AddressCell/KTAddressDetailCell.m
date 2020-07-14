//
//  KTAddressDetailCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAddressDetailCell.h"

@interface KTAddressDetailCell ()
@property (nonatomic,weak) UITextField *nameTextFiled;
@property (nonatomic,weak) UITextField *phoneTextFiled;
@property (nonatomic,weak) UITextField *addressTextFiled;
@end

@implementation KTAddressDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
    
}

- (void)setupUI{
    CGFloat nameW = [UIScreen mainScreen].bounds.size.width/8;
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"姓名:";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(10);
        make.width.offset(nameW);
    }];
    
     UITextField *nameTextFiled = [[UITextField alloc]init];
    nameTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:nameTextFiled];
    [nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel.mas_centerY).offset(0);
        make.top.bottom.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.offset(-10);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"电话:";
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
        make.width.offset(nameW);
    }];
    
    UITextField *phoneTextFiled = [[UITextField alloc]init];
    phoneTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:phoneTextFiled];
    [phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneLabel.mas_centerY).offset(0);
        make.top.bottom.equalTo(phoneLabel);
        make.left.equalTo(nameTextFiled.mas_left);
        make.right.equalTo(nameTextFiled.mas_right);
    }];

    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.text = @"地址:";
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(phoneLabel.mas_bottom).offset(15);
        make.width.offset(nameW);

    }];
    
    UITextField *addressTextFiled = [[UITextField alloc]init];
    addressTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:addressTextFiled];
    [addressTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressLabel.mas_centerY).offset(0);
        make.top.bottom.equalTo(addressLabel);
        make.left.equalTo(nameTextFiled.mas_left);
        make.right.equalTo(nameTextFiled.mas_right);

    }];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [saveBtn addTarget:self action:@selector(clickPop:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameTextFiled = nameTextFiled;
    self.phoneTextFiled = phoneTextFiled;
    self.addressTextFiled = addressTextFiled;



}


- (void)setModel1:(KTAddressModel *)model1{
    _model1 = model1;
    self.nameTextFiled.text = model1.name;
    self.phoneTextFiled.text = model1.phone;
    self.addressTextFiled.text = model1.address;
}



- (void)clickPop:(UIButton*)sender{
    self.model1.name = self.nameTextFiled.text;
    self.model1.phone = self.phoneTextFiled.text;
    self.model1.address = self.addressTextFiled.text;
    
    if (self.popBlock) {
        self.popBlock(self.model1);
    }

}
@end
