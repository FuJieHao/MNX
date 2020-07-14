//
//  KTHPConvenientListView.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHPConvenientListView.h"
#import "UIButton+WebCache.h"
#import "ZFBHomeTopButton.h"

@interface KTHPConvenientListView ()

@property (nonatomic,strong) NSArray<UIButton *> *btnsArr;

@end

@implementation KTHPConvenientListView

- (void)awakeFromNib
{
    [self setupUI];
}

- (void)setupUI
{
    NSArray <NSString *> *titlesArr = @[@"优选水果",@"牛奶面包",@"饮料酒水",@"更多商品"];
    
    [titlesArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZFBHomeTopButton *btn = [[ZFBHomeTopButton alloc]init];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
    
//     3.布局按钮的约束
    [self.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(4);
        make.bottom.offset(2);
    }];
//
    self.btnsArr = self.subviews;
}

- (void)btnClick:(UIButton *)sender
{
    
}

- (void)setListViewDataSource:(NSArray *)listViewDataSource
{
    _listViewDataSource = listViewDataSource;
    
    for (NSInteger i = 0; i < listViewDataSource.count; i++) {
        [self.btnsArr[i] sd_setImageWithURL:[NSURL URLWithString:listViewDataSource[i]] forState:UIControlStateNormal];
    }
}

@end
