//
//  YYLFoodHeaderView.m
//  KTAiXianFeng
//
//  Created by wangddj on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "YYLFoodHeaderView.h"

@interface YYLFoodHeaderView ()

/**
 设置组标题的控件
 */
@property (nonatomic, weak) UILabel *lbl;


@end

@implementation YYLFoodHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
    
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // 1.设置背景色
    // -注意设置给内容视图!
    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    
    UILabel *lbl = [UILabel cz_labelWithText:@"标题" fontSize:12 color:[UIColor cz_colorWithHex:0x404040]];
    
    [self.contentView addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(20);
        make.top.bottom.right.equalTo(self.contentView);
        
    }];
    
    _lbl = lbl;
}


#pragma mark - 重写set方法,设置标题
- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    _lbl.text = title;
    
}






@end
