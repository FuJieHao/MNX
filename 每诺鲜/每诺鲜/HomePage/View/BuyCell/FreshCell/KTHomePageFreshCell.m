//
//  KTHomePageConvenientCell.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageFreshCell.h"
#import "KTHomePageFreshGoodsView1.h"
#import "KTHomePageFreshGoodsView2.h"

@interface KTHomePageFreshCell ()

@property (nonatomic,weak) IBOutlet UIImageView *freshView;
@property (nonatomic,weak) IBOutlet UIImageView *recommendView;
@property (nonatomic,weak) IBOutlet UIImageView *buyView;

@property (nonatomic,weak) IBOutlet KTHomePageFreshGoodsView1 *goodsView1;
@property (nonatomic,weak) IBOutlet KTHomePageFreshGoodsView2 *goodsView2;

@property (nonatomic,weak) IBOutlet UIImageView *moreGoods;

@end

@implementation KTHomePageFreshCell

- (void)setModel:(KTHPFreshModel *)model
{
    _model = model;
    
    [self.freshView sd_setImageWithURL:[NSURL URLWithString:model.freshImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    [self.recommendView sd_setImageWithURL:[NSURL URLWithString:model.recommendImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    [self.buyView sd_setImageWithURL:[NSURL URLWithString:model.buyImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    [self.moreGoods sd_setImageWithURL:[NSURL URLWithString:model.moreGoodImg] placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
    self.goodsView1.model = model.model_1;
    self.goodsView2.model = model.model_2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
