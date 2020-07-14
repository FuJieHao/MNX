//
//  ZFBSlideCell.m
//  01-功能列表
//
//  Created by chao on 16/8/16.
//  Copyright © 2016年 chao. All rights reserved.
//

#import "ZFBSlideCell.h"


@interface ZFBSlideCell ()
@property (nonatomic, weak) UIImageView *iconView;

@end
@implementation ZFBSlideCell

-(void)awakeFromNib {
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:self.bounds];
    iconView.backgroundColor = [UIColor redColor];
//    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:iconView];
    _iconView = iconView;
}

/**
 *  图片轮播器赋值
 *
 *  @param imageName 轮播器的URL
 */

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    [_iconView sd_setImageWithURL:(NSURL *)imageName placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
}
@end
