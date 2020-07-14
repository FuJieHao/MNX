//
//  ShopCartCell.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "ShopCartCell.h"
#import "BuyView.h"

#import "KTdetailModel.h"

@interface ShopCartCell()<buyViewDelegate>

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *priceLabel;

///商品图片
@property (nonatomic, strong) UIImageView *picImgView;

///选中按钮
@property (nonatomic, strong) UIButton *selectBtn;

///精选
@property (nonatomic, strong) UIImageView *jingxuanView;

///添加按钮
@property (nonatomic, strong) BuyView *buyView;

@end

@implementation ShopCartCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)addGoods:(NSInteger)buyCount WithSender:(UIButton *)btn{
    
    NSLog(@"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_titleLabel sizeToFit];
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        [_priceLabel sizeToFit];
        _priceLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_priceLabel];
        
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn setImage:[UIImage imageNamed:@"selectPng"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"vip"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectBtn];
        
        _picImgView = [[UIImageView alloc]init];
        [_picImgView setImage:[UIImage imageNamed:@"youxuan"]];
        [self.contentView addSubview:_picImgView];
        
        //精选
        _jingxuanView = [[UIImageView alloc]init];
        [_jingxuanView setImage:[UIImage imageNamed:@"jx"]];
        [self.contentView addSubview:_jingxuanView];
        
        //****添加按钮View
        _buyView = [[BuyView alloc]init];
        [self addSubview:_buyView];
        _buyView.delegate = self;
        //布局
        //点击按钮
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];

        //商品图片
        [_picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(_selectBtn.mas_right).offset(25);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        [_jingxuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_picImgView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(20, 15));
        }];
        
        ///商品名称
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_jingxuanView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        ///价格
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_jingxuanView);
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        }];
        
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(_priceLabel);
        }];
       
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)setGoods:(KTModel *)goods {
    
        self.titleLabel.text = goods.goodsName;
        [self.picImgView sd_setImageWithURL:[NSURL URLWithString:goods.imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@", goods.goodsPrice.description] ;
    self.priceLabel.textColor = [UIColor redColor];
}

@end
