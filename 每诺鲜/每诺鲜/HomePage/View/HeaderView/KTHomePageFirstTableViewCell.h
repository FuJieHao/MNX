//
//  KTHomePageFirstTableViewCell.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTHomePageFirstTableViewCell;
@protocol HomePageFirstTableViewCellDelegate <NSObject>

- (void)homePageFirstTableViewCell:(KTHomePageFirstTableViewCell *)vc andURLString:(NSString *)URL;

@end

@interface KTHomePageFirstTableViewCell : UIView

/**
 *  图片轮播的数据源
 */
@property (nonatomic,strong) NSArray *scrollViewDataSource;

/**
 *  四张小图的数据源
 */
@property (nonatomic,strong) NSArray *smallImageDataSource;

@property (nonatomic,weak) id <HomePageFirstTableViewCellDelegate> delegate;

+ (instancetype)homePageFirstTableView;

@end
