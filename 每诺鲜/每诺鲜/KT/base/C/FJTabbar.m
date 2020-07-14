//
//  FJTabbar.m
//  15-8项目网易彩票
//
//  Created by 郝 on 16/2/2.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJTabbar.h"

@interface FJTabbar ()

@property (nonatomic,weak)UIButton *selectedBtn; //当前选中的按钮

@end

@implementation FJTabbar
{
    CGFloat _btnW;
    CGFloat _btnH;
}


/*
 *自定控件
 *1.初始化的方法，添加子控件
 *2.layoutSubviews 布局子控件frame
 */

/*
 //调用控件init方法【[UIView alloc]init]】的时候被调用 接着还会调用initwithFrame
//- (instancetype)init

//- (instancetype)initWithFrame:(CGRect)frame

 //调用控件的创建从xib/storyboard 的时候被调用
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化按钮
        //[self setupBtns];
    }
    return self;
}

- (void)addTabbarBtnWithNormalImg:(NSString *)normalImg selImg:(NSString *)selImg
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selImg] forState:UIControlStateSelected];
    
//    UIButton *btn = [self loadHomeTopBtnWithTitle:@"abc" andImageName:normalImg andBtnType:0];
    
    //监听事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    //绑定tag
#warning tag的绑定要在addSubviews前面
    btn.tag = self.subviews.count;
//    NSLog(@"%d",btn.tag);
    [self addSubview:btn];
    
    //设置默认选中
    if (btn.tag == 0) {
        //btn.selected = YES;
        [self btnClick:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    //布局子控件
        //按钮的宽度与高度
        CGFloat btnW = self.bounds.size.width / count;
        CGFloat btnH = self.bounds.size.height;
    
    
    _btnW = btnW;
    _btnH = btnH;
    //自定义的tabbar添加五个按钮
//    for (NSInteger i = 0; i < count; i++) {
//        
//        UIButton *btn = self.subviews[i];
//        
//        //设置按钮的frame
//        btn.frame = CGRectMake(btnW*i, 0, btnW, btnH);
    for (UIButton *btn in self.subviews) {
        btn.frame = CGRectMake((btnW)*(btn.tag), 0, btnW, btnH);
    }
    
}

#pragma mark 自定义tabbar按钮的监听
- (void)btnClick:(UIButton *)btn
{
    
    //一点击的时候通知代理
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedFrom:to:)]) {
        [self.delegate tabbar:self didSelectedFrom:self.selectedBtn.tag to:btn.tag];
    }
    
    //开发过程中首先针对64位开发，苹果开发应用上架，必须是支持64位的
    NSLog(@"%ld",(long)btn.tag);
    
    //取消之前选中的按钮，设置当前选中的
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _btnW *= 1.4;
        _btnH *= 1.4;
        
        CGSizeMake(_btnW, _btnH);
        CGRect rect = btn.frame;
        CGPoint point = btn.center;
        rect.size = CGSizeMake(_btnW, _btnH);
        
        btn.frame = rect;
        btn.center = point;
        
//        self.selectedBtn.bounds.size =
        
    } completion:^(BOOL finished) {
        
        _btnW /= 1.4;
        _btnH /= 1.4;
        CGSizeMake(_btnW, _btnH);
        CGRect rect = btn.frame;
        rect.size = CGSizeMake(_btnW, _btnH);
        
        btn.frame = rect;
    }];
    
}

@end

//实现自定义Button
@implementation FJTabbarButton

- (void)setHighlighted:(BOOL)highlighted
{
    //图片高亮时候会调用该方法
    //只要不调用父类的方法，按钮就不会有高亮的效果
    //[super setHighlighted:highlighted];
}

@end
