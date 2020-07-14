//
//  YYLFoodCell.m
//  KTAiXianFeng
//
//  Created by wangddj on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "YYLFoodCell.h"
#import "KTSuperMarketRightModel.h"
#import "BuyView.h"

@interface YYLFoodCell () <buyViewDelegate>
// 头像
@property (nonatomic, weak) UIImageView *iconView;

// 名称
@property (nonatomic, weak) UILabel *nameLbl;
// 价格
@property (nonatomic, weak) UILabel *priceLbl;
// 月售出
@property (nonatomic, weak) UILabel *monthLbl;
// 点赞数量
@property (nonatomic, weak) UILabel *starLbl;
// 描述
@property (nonatomic, weak) UILabel *descLbl;

@property (nonatomic,weak) UIImageView *buyOneSongOne;
@property (nonatomic,weak) UILabel *porformLabel;

@end

@implementation YYLFoodCell

- (void)addGoods:(NSInteger)buyCount WithSender:(UIButton *)btn
{
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    
    NSDictionary *userInfo = @{
                               modelName:self.foodModel.name,
                               modelimgURL:self.foodModel.img,
                               modelPrice:self.foodModel.market_price,
                               };
    
    [noti postNotificationName:modelNoti object:self userInfo:userInfo];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // 0.统一间距
    CGFloat margin = 10;
    
    UIImageView *kongBaiImg = [[UIImageView alloc]init];
    [self.contentView addSubview:kongBaiImg];
    kongBaiImg.image = [UIImage imageNamed:@"边框"];
    [kongBaiImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(margin);
        make.size.mas_equalTo(CGSizeMake(72, 86));
    }];
    
    // MARK: - 1.添加子控件
    // 1.头像
    UIImageView *iconV = [[UIImageView alloc] init];
    //设置显示模式
//    iconV.contentMode = UIViewContentModeScaleAspectFill;
    iconV.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:iconV];
    
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(kongBaiImg);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        
    }];
    
    UIImageView *jingXuanImg = [[UIImageView alloc]init];
    jingXuanImg.image = [UIImage imageNamed:@"jx"];
    [self.contentView addSubview:jingXuanImg];
    
    [jingXuanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconV.mas_right).offset(margin);
        make.top.equalTo(iconV).offset(2);
        make.width.equalTo(@25);
        make.height.equalTo(@13);
    }];
    
    // 2.名称
    UILabel *nameL = [UILabel cz_labelWithText:@"天堂饭" fontSize:13 color:[UIColor cz_colorWithHex:0x000000]];
    [self.contentView addSubview:nameL];
    
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(jingXuanImg.mas_right).offset(3);
        make.top.equalTo(iconV);
        make.right.equalTo(self).offset(-4);
    }];
    
    UIImageView *buyOneSongOne = [[UIImageView alloc]init];
    [self.contentView addSubview:buyOneSongOne];
    
    [buyOneSongOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconV.mas_right).offset(margin);
        make.top.equalTo(nameL.mas_bottom).offset(3);
        make.width.equalTo(@40);
        make.height.equalTo(@14);
    }];
    
   
    // 6.描述
    UILabel *descL = [UILabel cz_labelWithText:@"精选东北大米" fontSize:11 color:[UIColor cz_colorWithHex:0x848484]];
    
    [self.contentView addSubview:descL];
    
    [descL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(iconV.mas_right).offset(margin);
        make.top.equalTo(buyOneSongOne.mas_bottom).offset(4);
        
    }];
    
    // 7.价格
    UILabel *priceL = [UILabel cz_labelWithText:@"1000" fontSize:14 color:[UIColor cz_colorWithHex:0xfa2a09]];
    [self.contentView addSubview:priceL];
    
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(descL);
        make.top.equalTo(descL.mas_bottom).offset(4);
        
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(kongBaiImg.mas_bottom).offset(margin);
    }];
    
    //8.之前的价格
    UILabel *porformLabel = [UILabel cz_labelWithText:@"￥3" fontSize:12 color:[UIColor grayColor]];
    [self.contentView addSubview:porformLabel];
    
    [porformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(priceL.mas_right).offset(2);
        make.centerY.equalTo(priceL);
    }];
    
//     添加一个 + 号按钮
    BuyView *btn = [[BuyView alloc] init];
    btn.delegate = self;
    [self.contentView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(priceL.mas_centerY);
        make.right.equalTo(self.contentView).offset(-10);
//        make.height.equalTo(@14);
//        make.width.equalTo(@25);
    }];
    
    // MARK: - 2.记录成员变量
    _iconView = iconV;
    _nameLbl = nameL;
    _priceLbl = priceL;
    _descLbl = descL;
    _buyOneSongOne = buyOneSongOne;
    _porformLabel = porformLabel;
}


#pragma mark - 重写set方法,分发数据
- (void)setFoodModel:(KTSuperMarketRightModel *)foodModel {
    
    _foodModel = foodModel;
    
    // 分发数据!
    // 1.设置图片

    // 1.url
    NSURL *url = [NSURL URLWithString:foodModel.img];
    
    // 2.设置图片
    [_iconView sd_setImageWithURL:url];
    
    //2.设置其他内容
    _nameLbl.text = foodModel.name;
    
    _descLbl.text = foodModel.specifics;
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",foodModel.market_price];
  
    if (![foodModel.pm_desc isEqualToString:@""]) {
        _buyOneSongOne.image = [UIImage imageNamed:@"买一赠一"];
    } else {
        _buyOneSongOne.image = [UIImage imageNamed:@""];
    }
    
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",foodModel.partner_price];
    
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.porformLabel setAttributedText:attri];

}
@end
