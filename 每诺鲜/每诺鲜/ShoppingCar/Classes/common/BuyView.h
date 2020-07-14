//
//  BuyView.h
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol buyViewDelegate <NSObject>

- (void)addGoods:(NSInteger )buyCount WithSender:(UIButton *) btn;

@end

@interface BuyView : UIView

/** 是否显示0 */
@property (nonatomic) BOOL zearIsShow;
/** 与之关联的商品  */

/** 不显示减号 */
@property (nonatomic) BOOL zearNeverShow;

@property (nonatomic, assign) BOOL isDelete;

@property (nonatomic, weak) id <buyViewDelegate> delegate;
@property (nonatomic,assign) NSInteger btnTag;
@end
