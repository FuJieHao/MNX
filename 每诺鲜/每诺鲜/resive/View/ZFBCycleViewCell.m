//
//  ZFBCycleViewCell.m
//  004-图片轮播器
//
//  Created by HM on 16/8/21.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ZFBCycleViewCell.h"
#import "Masonry.h"


@interface ZFBCycleViewCell ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *indexLabel;


@end
@implementation ZFBCycleViewCell
// 如果homeTopView是通过xib或sb创建此就会调用此方法

// 如果homeTopView是通过代码来创建就会调用此方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


// 设置界面
- (void)setupUI {
    // 添加cell中的广告图片
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
//    UILabel *indexLabel = [[UILabel alloc] init];
//    indexLabel.font = [UIFont systemFontOfSize:30];
//    indexLabel.textAlignment = NSTextAlignmentCenter;
//    indexLabel.backgroundColor = [UIColor purpleColor];
//    [self.contentView addSubview:indexLabel];
//    
//    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.offset(0);
//    }];
    
    
    self.iconView = iconView;
    if (self.imageBlock) {
        self.imageBlock(iconView);
    }
    //self.indexLabel = indexLabel;
}
- (void)setModelArray:(NSArray<KTCycleViewModel *> *)modelArray{

    _modelArray = modelArray;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    self.modelArray;
    
   
    _indexPath = indexPath;
    switch (indexPath.row) {
        case 0:
        {
            KTCycleViewModel *vModel = self.modelArray[0];
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com//upload/activity/2016100517175041.jpg@90Q.jpg"]
                             placeholderImage:[UIImage imageNamed:@"user_default"]];
        }
            break;
        case 1:
        {
            KTCycleViewModel *vModel = self.modelArray[1];
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com//upload/activity/2016091311181253.jpg@90Q.jpg"]
                             placeholderImage:[UIImage imageNamed:@"user_default"]];
        }

            break;
        case 2:
        {
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com//upload/activity/201609281114470.jpg@90Q.jpg"]
                             placeholderImage:[UIImage imageNamed:@"user_default"]];
        }

            break;
        case 3:
        {
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:@"http://img01.bqstatic.com//upload/activity/2016092315103252.jpg@90Q.jpg"]
                             placeholderImage:[UIImage imageNamed:@"user_default"]];
        }

            break;
            
        default:
            break;
    }
    

//    NSRange range=[stringLocation rangeOfString:@"@"];
    //NSLog(@"-------%zd",range);
    //NSLog(@"%ld",(long)range.location);
    // 设置图片
    //http://img01.bqstatic.com//upload/activity/cms_113589_1473842395.jpg@90Q.jpg
    //NSLog(@".........%@",vModel.img);
    
    // 显示出来cell的索引
    //self.indexLabel.text = [NSString stringWithFormat:@"第%zd组的第%zd个", indexPath.section, indexPath.item];
}
@end
