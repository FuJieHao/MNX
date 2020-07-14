//
//  KTKTHomePageFreshGoodsView1.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageFreshGoodsView1.h"
#import "BuyView.h"

@interface KTHomePageFreshGoodsView1 () <buyViewDelegate>

@property (nonatomic,weak) IBOutlet UIImageView *goodsImg;
@property (nonatomic,weak) IBOutlet UILabel *goodsName;
@property (nonatomic,weak) IBOutlet UIImageView *goodsSImg;
@property (nonatomic,weak) IBOutlet UILabel *goodsAttribute;
@property (nonatomic,weak) IBOutlet UILabel *goodsGrice;
@property (nonatomic,weak) IBOutlet BuyView *goodsAdd;

@end

@implementation KTHomePageFreshGoodsView1

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
    self.goodsAdd.delegate = self;
    self.goodsSImg.image = [UIImage imageNamed:@"jx"];
}

- (void)setModel:(KTHPFreshGoods1Model *)model
{
    _model = model;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    self.goodsName.text = model.name;
    self.goodsAttribute.text = model.specifics;
    self.goodsAttribute.textColor = [UIColor grayColor];
    self.goodsGrice.text = [NSString stringWithFormat:@"￥%@",model.market_price];
    self.goodsGrice.textColor = [UIColor redColor];
}

@end
