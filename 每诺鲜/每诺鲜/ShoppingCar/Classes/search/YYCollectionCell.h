//
//  YYCollectionCell.h
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchHotModel;

@interface YYCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *firstLabel;

-(void)cellModel:(SearchHotModel *)Model;

@end
