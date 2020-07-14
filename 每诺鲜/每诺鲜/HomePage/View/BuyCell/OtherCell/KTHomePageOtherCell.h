//
//  KTHomePageOtherCell.h
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTHPOtherModel.h"

@class KTHomePageOtherCell;
@protocol KTHomePageOtherCellDelegate <NSObject>

- (void)homePageOtherCell:(KTHomePageOtherCell *)vc andTopString:(NSString *)topString;

@end

@interface KTHomePageOtherCell : UITableViewCell

@property (nonatomic,strong) KTHPOtherModel *model;

@property (nonatomic,weak) id <KTHomePageOtherCellDelegate> delegate;

@end
