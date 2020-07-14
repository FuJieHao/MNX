//
//  KTHomePageHeaderView.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTHomePageHeaderView : UIView

/**
 *  四张大图的数据源
 */
@property (nonatomic,strong) NSArray *pic_dataSource;

+ (instancetype)homePageHeaderView;

@end
