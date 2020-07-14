//
//  KTShufflingDevice.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTShufflingDevice.h"
#import "ZFBCycleViewCell.h"
#import "ZFBCycleFlowLayout.h"


#define KSectionCount 100

// cell的重用标识
static NSString *cycleID = @"cycleCellID";
@interface ZFBCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,weak) ZFBCycleViewCell *cell;
@end
@implementation ZFBCycleView

// 如果homeTopView是通过xib或sb创建此就会调用此方法
- (void)awakeFromNib {
    [self setupUI];
}

// 如果homeTopView是通过代码来创建就会调用此方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


// 设置界面
- (void)setupUI {
    [self setupCollectionView];
    
    [self setupPageControl];
    
    // 一启动就添加定时器
    [self addTimer];
}


#pragma mark - 设置UICollectionView相关
- (void)setupPageControl {
    // 创建分页指示器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 设置当前页点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    // 设置其它页点的颜色
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    
    [self addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
    
    self.pageControl = pageControl;
}
#pragma mark - 设置UICollectionView相关
- (void)setupCollectionView {
    // 创建自定义布局对象
    ZFBCycleFlowLayout *layout = [[ZFBCycleFlowLayout alloc] init];
    // 创建collecitonView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor yellowColor];
    [self addSubview:collectionView];
    
    
    // 设置collectionVeiw的四周距离父控件为0
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.left.right.offset(0);
        make.edges.offset(0);
        
    }];
    
    
    
    // 设置数据源
    collectionView.dataSource = self;
    // 设置代理监听事件
    collectionView.delegate = self;
    // 注册collectionView中的cell
    [collectionView registerClass:[ZFBCycleViewCell class] forCellWithReuseIdentifier:cycleID];
    
    // 分页
    collectionView.pagingEnabled = YES;
    // 关闭弹簧效果
    collectionView.bounces = NO;
    // 隐藏水平和垂直的滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    
    
    self.collectionView = collectionView;
    
    
    
    
}


// 添加定时器方法
- (void)addTimer {
    
#warning mark - 如果在用定时器是忽略它的运行模式时就用下面这个方法
    // 给控制器添加一个定时器 让它每3秒调用一次nextPage方法
    //   self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    
    
#warning mark - 如果在用定时器时要考虑运行模式问题,建议用下面这两行代码
    // 下面这两句话和上面一行代码是等价
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    //    [self.timer fire];
    // 把定时器添加到运行循环 改变它的执行模式为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 定时器调用的方法
- (void)nextPage {
    // 获取当前滚动到第几页了
    NSInteger page = self.pageControl.currentPage;
    // 要滚动到那个索引上
    NSIndexPath *scrollToPath = nil;
    // 如果是最后一张图片
    if (page == _imageArray.count - 1) {
        scrollToPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2 + 1];
    } else {
        scrollToPath = [NSIndexPath indexPathForItem:page + 1 inSection:KSectionCount / 2];
    }
    
    // 如果不是最后一张图片继续向下一张滚动
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}


// 手动调用之后让定时器执行时间在很遥远未来
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 让它在未来4001年后再开始定时器
    self.timer.fireDate = [NSDate distantFuture];
    //    NSLog(@"%@", [NSDate distantPast]);
}

// 当用户停止拖拽之后2秒之后再开始执行定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 让定时器两秒之后再开始执行
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}

// 用代码动画方式滚动,滚动一页动画停下来后会调用此方法"主要判断如果走到非中间组就让它无动画效果的回到中间这一组"
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __func__);
    [self scrollViewDidEndDecelerating:scrollView];
}



// 此方法只有在手动拖拽时当滚动完全停下来才会调用一次的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __func__);
    
    // 计算出在collectionView中它是第几个格子"当前不要考虑组的情况"
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //    NSLog(@"%zd ---%zd ---%zd", page, page / 2 , page% 2);
    
    // 计算它是第几组的格子
    NSInteger sectionNum = page / _imageArray.count;
    // 计算它是第几个格子
    NSInteger itemNum = page % _imageArray.count;
    if (sectionNum == KSectionCount / 2) {
        //        NSLog(@"我还在中间呢,不用做其它操作");
        return;
    }
    
    
    // 不在中间这一组
    //    NSLog(@"我不在中间这一组了,你快让我回到中间这一组吧,停下来时是在第几个cell上面,就回到中间这一组的第几个cell上面");
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:itemNum inSection:KSectionCount / 2];
#warning mark - 千万不要开启动画,不然就露馅了
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}


// 监听它的滚动来设置pageControl的页数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算滚动的页数
    NSInteger page = (scrollView.contentOffset.x / scrollView.bounds.size.width) + 0.499;
    // 安全处理,不要越界
    NSInteger pageNO = page % _imageArray.count;
    //    NSLog(@"%zd", pageNO);
    // 设置当前页数据
    self.pageControl.currentPage = pageNO;
}










#pragma mark - 数据源方法
// 返回有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return KSectionCount;
}

// 返回cell的个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"我有几个图片了%zd", _imageArray.count);
    return _imageArray.count;
}


// 返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    ZFBCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cycleID forIndexPath:indexPath];
    // 2.传数据
    
    cell.indexPath = indexPath;
    self.cell = cell;
    [cell setImageBlock:^(UIImageView *cellImageView) {
        if (self.mediationBlock) {
            self.mediationBlock(cellImageView);
        }
    }];
    
    //    NSLog(@"%p", cell);
    
    // 3.返回cell
    return cell;
    
}



- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    
//    NSLog(@"有数据了");
    // 只要调用reloadData 它会把collecitonView的所有数据源方法重新执行一次
    [self.collectionView reloadData];
    
    // 设置点的总个数
    self.pageControl.numberOfPages = _imageArray.count;
    
#warning mark - 因为collectionVeiw的的frame是用约束限制的所以一开始还没有尺寸所以直接滚动就会有问题所以让它提前计算出frame,调整好大小之后再去实现滚动,不然一开始直接滚动就无法滚动
    //    [collectionView reloadData];
    // 让view中的所有子控件根据自己的约束立即调整frame
    [self layoutIfNeeded];
    
    // 一启动就滚动到中间这一组的第0个cell上面
    //    collectionView setContentOffset:<#(CGPoint)#>
    
    // 创建中间这一组第0个cell的索引
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:0 inSection:KSectionCount / 2];
    // 让collecitonView中的cell滚动到中间这一组的第0个cell
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}


#warning mark - removeFormSuperview不代表就是销毁了
- (void)removeFromSuperview {
    [super removeFromSuperview];
    // 停止定时器
    [self.timer invalidate];
//    NSLog(@"-----");
    
    
}

- (void)dealloc {
//    NSLog(@"我要走了");
}

- (void)setModelArray:(NSArray<KTCycleViewModel *> *)modelArray{
    _modelArray = modelArray;

    self.cell.modelArray = modelArray;
}

@end
