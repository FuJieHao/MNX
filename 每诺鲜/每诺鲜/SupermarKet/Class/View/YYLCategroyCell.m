//
//  YYLCategroyCell.m
//  KTAiXianFeng
//
//  Created by wangddj on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "YYLCategroyCell.h"
#import "KTSuperMarketLeftModel.h"
@implementation YYLCategroyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
    
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // 1.标题文字
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.textLabel.textColor = [UIColor cz_colorWithHex:0x464646];
    self.textLabel.numberOfLines = 2;
    
    // 2.设置普通的被背景颜色
    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    
    // 3.设置选中的背景颜色
    UIView *selectBg = [[UIView alloc] init];
    selectBg.backgroundColor = [UIColor cz_colorWithHex:0xffffff];
    
    self.selectedBackgroundView = selectBg;

    // 4.竖线
    UIView *verLine = [[UIView alloc] init];
    verLine.backgroundColor = [UIColor cz_colorWithHex:0xffd900];
    
    [selectBg addSubview:verLine];
    
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(4, 28));
        
    //参考自己的父控件!
        make.left.centerY.equalTo(selectBg);
        
    }];
    
    UIView *greenBottomLine = [[UIView alloc]init];
    greenBottomLine.backgroundColor = [UIColor colorWithRed:157.0/255.0 green:194.0/255.0 blue:95.0/255.0 alpha:1.0];
    [selectBg addSubview:greenBottomLine];
    
    [greenBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(selectBg);
        make.height.equalTo(@1);
        //参考自己的父控件!
        make.left.centerX.equalTo(selectBg);
    }];
    
    // 5.分割线!
    UIView *bottomL = [[UIView alloc] init];
    bottomL.backgroundColor = [UIColor cz_colorWithHex:0xf3f3f3];
    
    [self.contentView addSubview:bottomL];
    
    [bottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        
    }];
    
    UIView *greenLine = [[UIView alloc]init];
    [self.contentView addSubview:greenLine];
    greenLine.backgroundColor = [UIColor colorWithRed:157.0/255.0 green:194.0/255.0 blue:95.0/255.0 alpha:1.0];
    [greenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.height.equalTo(self);
        make.width.equalTo(@1);
    }];
    
}

   //重写set方法,显示分类内容
- (void)setCategoryModel:(KTSuperMarketLeftModel *)categoryModel {
    
    _categoryModel = categoryModel;
    
    self.textLabel.text = categoryModel.signName;
    
}



@end
