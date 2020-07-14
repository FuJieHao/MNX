//
//  KTDetailsCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTdetailModel.h"
#import "KTdetailModel2.h"

@interface KTDetailsCell : UITableViewCell
@property (nonatomic,strong) NSArray <KTdetailModel*>* detailModelArray;
@property (nonatomic,assign) NSInteger detailCellTag;
@property (nonatomic,copy) void (^detailBlock) (UITapGestureRecognizer*);
@property (nonatomic,copy) void (^reloadBlock) (NSInteger);
@end
