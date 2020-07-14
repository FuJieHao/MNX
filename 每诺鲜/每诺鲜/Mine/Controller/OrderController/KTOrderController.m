//
//  KTOrderController.m
//  KTAiXianFeng
//
//  Created by 周东川 on 2016/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTOrderController.h"
#import "CZAdditions.h"
#import "KTWaitToPayController.h"
#import "KTWaitReceiveController.h"
#import "KTWaitToEvaluateController.h"
#import "KTAllOrderController.h"

@interface KTOrderController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

// 黄线视图
@property (nonatomic, weak) UIView *yellowLine;
// 记录被选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;
//头部订单分类
@property (nonatomic ,weak) UIControl *orderHeadV;
// 接收需要偏移的量
@property (nonatomic, assign) CGFloat offset_X;

// 滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation KTOrderController{
    
    // 数组,存放4个按钮的数组
    NSArray<UIButton *> *_btnsArr;
}

#pragma mark - 设置UI
- (void)setupUI{
    
    //设置头部订单View
    [self setupOderHead];
    
    //订单详情
    [self setupOrderDetails];
    
}

///设置头部订单View
-(void)setupOderHead {
    
    //MARK: -创建头部view
    UIControl *orderHeadV = [[UIControl alloc]init];
    
    //监听头部订单分类值改变事件
    [orderHeadV addTarget:self action:@selector(orderHeadViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:orderHeadV];
    
    [orderHeadV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.offset(0);
        make.height.offset(44);
    }];
    
    
    //MARK: -添加4个按钮
    NSArray<NSString *> *orderArr = @[@"全部订单", @"待付款", @"待收货", @"待评价"];
    
    [orderArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = [UIButton cz_textButton:obj fontSize:14 normalColor:[UIColor cz_colorWithHex:0x555555] selectedColor:[UIColor cz_colorWithHex:0x000000]];
        
        //添加按钮监听事件
        [btn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //如果是第0个按钮,设置个初始选中状态,记得赋值!
        if (idx == 0) {
            btn.selected = YES;
            _selectedBtn = btn;
        }
        
        
        //标识
        btn.tag = idx;
        
        [orderHeadV addSubview:btn];
    }];
    
    
    //按钮布局约束
    [orderHeadV.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [orderHeadV.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.offset(0);
    }];
    
    //赋值 全局变量
    _btnsArr = orderHeadV.subviews;
    self.orderHeadV = orderHeadV;
    
    // MARK: - 添加黄色的线条
    // 1.创建视图 黄色线
    UIView *yellowL = [[UIView alloc] init];
    yellowL.backgroundColor = [UIColor cz_colorWithHex:0xffd900];
    
    [self.orderHeadV addSubview:yellowL];
    
    [yellowL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.bottom.equalTo(_btnsArr[0]);
        make.height.mas_equalTo(4);
        make.centerX.equalTo(_btnsArr[0]);
        
    }];
    
    // 2.记录成员变量
    _yellowLine = yellowL;
    
    
}

///设置订单详情View
-(void)setupOrderDetails {
    
    // 3.滚动视图 scrollView
    UIScrollView *scrollV = [self setupContentView];
    
    [self.view addSubview:scrollV];
    
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.orderHeadV);
        make.top.equalTo(self.orderHeadV.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    // MARK: - 记录成员变量
    
    _scrollView = scrollV;
    
}

#pragma mark - 滚动联动方法
/// 负责创建底部滚动视图的方法
- (UIScrollView *)setupContentView {
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.pagingEnabled = YES;
    
    // 设置代理
    scrollV.delegate = self;
    
    // MARK: - 添加4个控制器的视图!
    // 1.确定要添加子控制器的名称
    NSArray<NSString *> *vcNamesArr = @[@"KTAllOrderController", @"KTWaitToPayController", @"KTWaitReceiveController", @"KTWaitToEvaluateController"];
    
//    NSArray<NSString *> *vcNamesArr = @[@"KTAllOrderController", @"KTAllOrderController", @"KTAllOrderController", @"KTAllOrderController"];
    
    // 2.遍历创建vc对象,并建立父子关系
    NSMutableArray<UIView *> *vcViewsArrM = [NSMutableArray array];
    
    [vcNamesArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 2.1 创建vc对象
        Class cls = NSClassFromString(obj);
        UIViewController *vc = [[cls alloc] init];
        
        // 2.2 建立控制器的父子关系
        [self cz_addChildController:vc intoView:scrollV];
        
        // 2.3添加控制器的视图到view中
        [vcViewsArrM addObject:vc.view];
        
    }];
    
    [vcViewsArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [vcViewsArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.equalTo(scrollV);
        // 确定内容的高度
        make.bottom.top.equalTo(scrollV);
        
    }];
    
    return scrollV;
}

// scrollView在滚动时的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 0.如果不是人为的滚动scrollView,不执行设置偏移量操作!
    // 用户在拖拽 || 用户拖拽结束,松手后开始减速 || 用户的手指在scrollView上!
    if (!(scrollView.isDragging || scrollView.isDecelerating || scrollView.isTracking)) {
        return;
    }
    
    // 1.获取滚动视图的内容的偏移量 x
    CGFloat offsetX = scrollView.contentOffset.x;
    //    NSLog(@"%f", offsetX);
    // 2.需要将偏移量交给分类视图!
    self.offset_X = offsetX / 4;
    
}

//订单分类改变后调用的方法
- (void)orderHeadViewValueChanged:(UIControl *)sender {
    
    // 让scrollView滚动
    CGRect rect = CGRectMake(_scrollView.bounds.size.width * self.pageNumber, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
}


#pragma mark - 点击订单的各个按钮
- (void)orderBtnClick:(UIButton *)sender {
    
    // 1.获取按钮所在集合中的索引
    _pageNumber = [_btnsArr indexOfObject:sender];
    
    // 2.发送事件,让scrollView滚动!
    [self.orderHeadV sendActionsForControlEvents:UIControlEventValueChanged];
    
    // 3.让黄线动起来!
    self.offset_X = sender.bounds.size.width * _pageNumber;
    
    // 4.修改按钮状态!
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    
}


#pragma mark - 重写偏移量的set方法,让黄线偏移
- (void)setOffset_X:(CGFloat)offset_X {
    
    _offset_X = offset_X;
    
    // MARK: - 1.更新黄线约束
    
    // 1.更新黄线的约束,中心的x值
    [_yellowLine mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_btnsArr[0]).offset(offset_X);
        
    }];
    
    // 2.强制布局子控件
    [UIView animateWithDuration:.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
    // MARK: - 2.修改按钮的状态!
    // 1.计算通过偏移量得出对应的索引值
    NSInteger idx = offset_X / _btnsArr[0].bounds.size.width + 0.5;
//    NSLog(@"%zd", idx); // 1 ~ 1.9   + 0.5  1.5
    
    // 2.修改按钮的状态
    // - 取消之前的
    _selectedBtn.selected = NO;
    // - 设置当前的
    _btnsArr[idx].selected = YES;
    // - 记录当前的
    _selectedBtn = _btnsArr[idx];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
