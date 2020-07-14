//
//  KTHorizontalScrollCell.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTscrollModel.h"

@interface KTHorizontalScrollCell : UITableViewCell
@property (nonatomic,strong) NSArray <KTscrollModel*>*modelScrollArray;
@property (nonatomic,assign) NSInteger cellTag;
@property (nonatomic,copy) void (^scrollBlock) (UITapGestureRecognizer*);
@end
