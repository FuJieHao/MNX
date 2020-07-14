//
//  BuyView.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "BuyView.h"
//#import "UserShopCarTool.h"
#import "AppConst.h"

@interface BuyView()

/** 加号按钮 */
@property (nonatomic,strong) UIButton *addGoodsButton;
/** 减号按钮 */
@property (nonatomic,strong) UIButton *reduceGoodsButton;
/** 数量label */
@property (nonatomic,strong) UILabel *countLabel;
/** 库存没货label */
@property (nonatomic,strong) UILabel *supplementLabel;
/** 购买商品的数量  */
@property (nonatomic,assign) NSInteger buyNumber;

@end

@implementation BuyView

- (void)setIsDelete:(BOOL)isDelete{

    _isDelete = isDelete;
    self.reduceGoodsButton.hidden = YES;
    self.countLabel.hidden = YES;
    
}

- (void)awakeFromNib{

    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
   
    [self setupUI];
    return self;
}

- (void)addGoods{

    if ([self.delegate respondsToSelector:@selector(addGoods:WithSender:)]) {
        
        [self.delegate addGoods:_buyNumber WithSender:_addGoodsButton];
        self.countLabel.text = [NSString stringWithFormat:@"%zd", ++_buyNumber];
    }
    
}

#pragma make - 搭建界面
- (void)setupUI{

    _addGoodsButton = [[UIButton alloc]init];
    [_addGoodsButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    
    [_addGoodsButton addTarget:self action:@selector(addGoods) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addGoodsButton];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.text = @"0";
    _countLabel.font = [UIFont systemFontOfSize:14];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLabel];
    
    _reduceGoodsButton = [[UIButton alloc]init];
    [_reduceGoodsButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [_reduceGoodsButton addTarget:self action:@selector(reduceGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_reduceGoodsButton];
    
    _supplementLabel = [UILabel new];
    _supplementLabel.textColor = [UIColor redColor];
    _supplementLabel.text = @"补货中";
    _supplementLabel.hidden = YES;
    _supplementLabel.textAlignment = NSTextAlignmentCenter;
    _supplementLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_supplementLabel];
    
    [_reduceGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_reduceGoodsButton.mas_trailing).offset(3);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.trailing.equalTo(_addGoodsButton.mas_leading).offset(-2);
    }];
    [_addGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    [_supplementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)reduceGoodsButtonClick{

    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    
    NSDictionary *userInfo = @{
                               modelName:@"-",
                               modelimgURL:@"-",
                               modelPrice:@"-",
    };
    
    [noti postNotificationName:modelNoti object:self userInfo:userInfo];
    
    if (_buyNumber > 0) {
        
        self.countLabel.text = [NSString stringWithFormat:@"%zd", --_buyNumber];
    }

}

- (void)setBuyNumber:(NSInteger)buyNumber {
    _buyNumber = buyNumber;
    if (self.zearNeverShow) {
        self.reduceGoodsButton.hidden = YES;
        self.countLabel.hidden = YES;
    }else {
        if (buyNumber == 0) {
            self.reduceGoodsButton.hidden = YES && !self.zearIsShow;
            self.countLabel.hidden = YES && !self.zearIsShow;
        }else {
            self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)buyNumber];
            self.reduceGoodsButton.hidden = NO;
            self.countLabel.hidden = NO;
        }
    }
}


- (void)supplementLabelShow:(BOOL)show{
    if (show) {
        self.supplementLabel.hidden = NO;
        self.countLabel.hidden= YES;
        self.addGoodsButton.hidden = YES;
        self.reduceGoodsButton.hidden = YES;
    }else{
        self.supplementLabel.hidden = YES;
        self.countLabel.hidden= NO;
        self.addGoodsButton.hidden = NO;
        self.reduceGoodsButton.hidden = NO;
    }
}

-(void)setBtnTag:(NSInteger)btnTag{
    _btnTag = btnTag;
    _addGoodsButton.tag = btnTag;
}

@end
