//
//  ZFBCycleFlowLayout.m
//  004-图片轮播器
//
//  Created by HM on 16/8/21.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ZFBCycleFlowLayout.h"

@implementation ZFBCycleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    NSLog(@"%@", NSStringFromCGRect(self.collectionView.bounds));
    self.itemSize = self.collectionView.bounds.size;
    // 设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    

}
@end
