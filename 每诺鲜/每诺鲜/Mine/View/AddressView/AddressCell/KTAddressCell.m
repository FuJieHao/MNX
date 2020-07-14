//
//  KTAddressCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAddressCell.h"

@interface KTAddressCell ()





@end

@implementation KTAddressCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;

}

- (void)setupUI{
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"哇o";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(10);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"1123123";
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top).offset(0);
        make.left.equalTo(nameLabel.mas_right).offset(10);
    }];
    self.phoneLabel = phoneLabel;
    
    UILabel *addressLabel = [[UILabel alloc]init];
   CGFloat addLabelW = [UIScreen mainScreen].bounds.size.width*5/7;
    addressLabel.text = @"asddsadkadasdadsasdasdasdasdasdasdasd";
    addressLabel.numberOfLines = 0;
    addressLabel.font = [UIFont systemFontOfSize:12];
    addressLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left).offset(0);
        make.top.equalTo(nameLabel.mas_bottom).offset(6);
        make.width.offset(addLabelW);
    }];
    self.addressLabel = addressLabel;
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"v2_address_edit_highlighted"] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.offset(0);
    }];
    
#warning mark - 点击事件
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];


}
#warning mark - address跳转方法
- (void)clickBtn:(UIButton*)btn{

    if (self.addressCellBlock) {
        self.addressCellBlock(btn,self.addressModel);
    }


}

- (void)setAddressModel:(KTAddressModel *)addressModel{
    _addressModel = addressModel;
    self.nameLabel.text = addressModel.name;
    self.phoneLabel.text = addressModel.phone;
    self.addressLabel.text = addressModel.address;
    
    
}

@end
