//
//  FJTabbar.h
//  15-8项目网易彩票
//
//  Created by 郝 on 16/2/2.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJTabbar;
@protocol FJTabbarDelegate <NSObject>

- (void)tabbar:(FJTabbar *)tabbar didSelectedFrom:(NSInteger)form to:(NSInteger)to;

@end

@interface FJTabbar : UIView

@property (nonatomic,weak) id<FJTabbarDelegate> delegate;

//传普通状态和选中状态的图片，内部就会添加按钮
- (void)addTabbarBtnWithNormalImg:(NSString *)normalImg selImg:(NSString *)selImg;

@end

//自定义按钮
@interface FJTabbarButton : UIButton

@end
