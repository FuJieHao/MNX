//
//  ZFBCycleViewCell.h
//  004-图片轮播器
//
//  Created by HM on 16/8/21.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTCycleViewModel.h"

@interface ZFBCycleViewCell : UICollectionViewCell
// 传入cell的索引
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic,copy) void (^imageBlock)(UIImageView *);
@property (nonatomic,strong) NSArray <KTCycleViewModel*>*modelArray;
@end
