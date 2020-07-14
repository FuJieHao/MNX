//
//  KTclassifyCell.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTclassifyCell.h"
#import "NSAttributedString+CZAdditon.h"
#import "KTclassifyModel.h"
#import "UIImage+MultiFormat.h"

@interface KTclassifyCell ()
@property (nonatomic,weak) UIButton *scan;
@property (nonatomic,weak) UIButton *pay;
@property (nonatomic,weak) UIButton *card;
@property (nonatomic,weak) UIButton *xiu;
@property (nonatomic,weak) UILabel *scanLabel;
@property (nonatomic,weak) UILabel *payLabel;
@property (nonatomic,weak) UILabel *cardLabel;
@property (nonatomic,weak) UILabel *xiuLabel;
@property (nonatomic,strong) NSArray *btnArray;

@end

@implementation KTclassifyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        }

    return self;
}

- (void)setupUI{

    
    UIButton *scan = [[UIButton alloc]init];
    [scan setImage:[UIImage imageNamed:@"B1"] forState:UIControlStateNormal];
    self.scan = scan;
    [self.contentView addSubview:scan];
    
    UIButton *pay = [[UIButton alloc]init];
    self.pay = pay;
     [pay setImage:[UIImage imageNamed:@"B2"] forState:UIControlStateNormal];
    [self.contentView addSubview:pay];
    
    UIButton *card = [[UIButton alloc]init];
    self.card = card;
     [card setImage:[UIImage imageNamed:@"B3"] forState:UIControlStateNormal];
    [self.contentView addSubview:card];
    
    UIButton *xiu = [[UIButton alloc]init];
    self.xiu = xiu;
     [xiu setImage:[UIImage imageNamed:@"B4"] forState:UIControlStateNormal];
    [self.contentView addSubview:xiu];
    
    self.btnArray = @[scan,pay,card,xiu];
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [obj addTarget:self action:@selector(jumpToVc:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    CGFloat scW = [UIScreen mainScreen].bounds.size.width*0.25;
    // 给四个子按钮都设置一个上下约束
    [scan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(scW);
        make.bottom.offset(-20);
    }];
    
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scan.mas_top).offset(0);
        make.left.equalTo(scan.mas_right).offset(0);
        make.width.offset(scW);
        make.bottom.offset(-20);
    }];
    
    [card mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pay.mas_top);
        make.left.equalTo(pay.mas_right);
        make.width.offset(scW);
        make.bottom.offset(-20);
    }];
    
    [xiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(card.mas_top);
        make.left.equalTo(card.mas_right);
        make.width.offset(scW);
        make.bottom.offset(-20);
    }];

    
    UILabel *scanLabel = [[UILabel alloc]init];
    self.scanLabel = scanLabel;
    [self.contentView addSubview:scanLabel];
    [scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scan.mas_bottom).offset(5);
        make.centerX.equalTo(scan.mas_centerX);
    }];
    
    
    UILabel *payLabel = [[UILabel alloc]init];
    self.payLabel = payLabel;
    [self.contentView addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pay.mas_bottom).offset(5);
        make.centerX.equalTo(pay.mas_centerX);

    }];
    
    UILabel *cardLabel = [[UILabel alloc]init];
    self.cardLabel = cardLabel;
    [self.contentView addSubview:cardLabel];
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(card.mas_bottom).offset(5);
        make.centerX.equalTo(card.mas_centerX);
        
    }];

    
    UILabel *xiuLabel = [[UILabel alloc]init];
    self.xiuLabel = xiuLabel;
    [self.contentView addSubview:xiuLabel];
    [xiuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xiu.mas_bottom).offset(5);
        make.centerX.equalTo(xiu.mas_centerX);
        
    }];

    


}


- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    KTclassifyModel *model = modelArray[0];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img]];
//    UIImage *todyImage = [UIImage sd_imageWithData:data];
//    [self.scan setImage:todyImage forState:UIControlStateNormal];
#warning mark 主线程执行的！
    KTclassifyModel *model1 = modelArray[1];
//    NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:model1.img]];
//    UIImage *todyImage1 = [UIImage sd_imageWithData:data1];
//    [self.pay setImage:todyImage1 forState:UIControlStateNormal];
    //self.pay.contentMode = UIViewContentModeScaleAspectFit;
    
    KTclassifyModel *model2 = modelArray[2];
//    NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:model2.img]];
//    UIImage *todyImage2 = [UIImage sd_imageWithData:data2];
//    [self.card setImage:todyImage2 forState:UIControlStateNormal];
    
    KTclassifyModel *model3 = modelArray[3];
//    NSData *data3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:model3.img]];
//    UIImage *todyImage3 = [UIImage sd_imageWithData:data3];
   // [self.xiu setImage:todyImage3 forState:UIControlStateNormal];
    
    self.scanLabel.text = model.name;
    self.scanLabel.font = [UIFont systemFontOfSize:12];
    
    self.payLabel.text = model1.name;
    self.payLabel.font = [UIFont systemFontOfSize:12];
    
    self.cardLabel.text = model2.name;
    self.cardLabel.font = [UIFont systemFontOfSize:12];
    
    self.xiuLabel.text = model3.name;
    self.xiuLabel.font = [UIFont systemFontOfSize:12];
}

#warning mark - 跳转方法
- (void)jumpToVc:(UIButton*)sender{
    if (self.btnBlock) {
        self.btnBlock(sender);
    }


}
@end
