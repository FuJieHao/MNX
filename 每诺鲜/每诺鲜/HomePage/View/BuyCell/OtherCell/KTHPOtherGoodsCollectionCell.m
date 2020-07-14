//
//  KTHPOtherGoodsCollectionCell.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHPOtherGoodsCollectionCell.h"
#import "BuyView.h"

@interface KTHPOtherGoodsCollectionCell () <buyViewDelegate>

@property (nonatomic,weak) IBOutlet UIImageView *goodsImg;
@property (nonatomic,weak) IBOutlet UILabel *goodsName;
@property (nonatomic,weak) IBOutlet UIImageView *goodsSImg;
@property (nonatomic,weak) IBOutlet UILabel *goodsAttribute;
@property (nonatomic,weak) IBOutlet UILabel *goodsGrice;
@property (nonatomic,weak) IBOutlet UIImageView *goodsAddImg;
@property (nonatomic,weak) IBOutlet UILabel *oldPrice;

@end

@implementation KTHPOtherGoodsCollectionCell

- (void)addGoods:(NSInteger)buyCount WithSender:(UIButton *)btn
{
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    
    NSDictionary *userInfo = @{
                               modelName:self.model.name,
                               modelimgURL:self.model.img,
                               modelPrice:self.model.market_price,
                               };
    
    [noti postNotificationName:modelNoti object:self userInfo:userInfo];
}

- (void)awakeFromNib
{
    self.goodsSImg.image = [UIImage imageNamed:@"jx"];
  
    BuyView *buyView = [[BuyView alloc] init];
    buyView.isDelete = YES;
    buyView.delegate = self;
    [self addSubview:buyView];

    [buyView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self.contentView).offset(-6);
        make.bottom.equalTo(self.contentView).offset(-1);

    }];
    
}

- (void)setModel:(KTHPOtherGoodsModel *)model
{
    
    _model = model;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    self.goodsName.text = model.name;
    self.goodsAttribute.text = model.specifics;
    self.goodsAttribute.textColor = [UIColor grayColor];
    self.goodsGrice.text = [NSString stringWithFormat:@"￥%@",model.market_price];
    self.goodsGrice.textColor = [UIColor redColor];
    self.oldPrice.textColor = [UIColor grayColor];
    
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",model.partner_price];
    
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, length)];
    [self.oldPrice setAttributedText:attri];
}

@end
