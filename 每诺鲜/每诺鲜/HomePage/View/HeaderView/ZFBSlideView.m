//
//  ZFBSlideView.m
//  01-功能列表
//
//  Created by chao on 16/8/16.
//  Copyright © 2016年 chao. All rights reserved.
//

#import "ZFBSlideView.h"
#import "ZFBSlideCell.h"
#import "Masonry.h"
@interface ZFBSlideView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentIndex;
@end

static NSString *slideID = @"slideCell";
@implementation ZFBSlideView

-(void)awakeFromNib {
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    _collectionView = collectionView;
    
    flowLayout.itemSize = collectionView.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    [_collectionView registerClass:[ZFBSlideCell class] forCellWithReuseIdentifier:slideID];
    
    [self.collectionView reloadData];
    
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.offset(0);
//    }];
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;

    [self.collectionView reloadData];
    [self timer];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    // 分页控件
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:.9 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:.6 alpha:1];
    pageControl.numberOfPages = imageNames.count;
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(self);
        make.bottom.offset(8);
    }];
    
    self.pageControl = pageControl;
}

#pragma mark - collectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFBSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:slideID forIndexPath:indexPath];
    cell.imageName = _imageNames[indexPath.item];
    
    return cell;
}

#pragma mark - scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSInteger pageNo = page + 0.4999;
    
    self.pageControl.currentPage = pageNo % self.imageNames.count;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //NSLog(@"---停止滚动的时候--");
    int currentPage = (int)scrollView.contentOffset.x / scrollView.bounds.size.width ;
    
    currentPage = currentPage % self.imageNames.count;
    self.currentIndex = currentPage;
    
    //滚动完毕之后,马上回到我们最中间的那组,就可以完美解决了
    NSIndexPath *centerIndexPath = [NSIndexPath indexPathForItem:currentPage inSection:1];
    
    [self.collectionView scrollToItemAtIndexPath:centerIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

/**
 *  scrollView停止滚动的代理
 *
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //NSLog(@"---停止滚动的时候--");
    int currentPage = (int)scrollView.contentOffset.x / scrollView.bounds.size.width ;
    
    currentPage = currentPage % self.imageNames.count;
    self.currentIndex = currentPage;
    
    //滚动完毕之后,马上回到我们最中间的那组,就可以完美解决了
    NSIndexPath *centerIndexPath = [NSIndexPath indexPathForItem:currentPage inSection:1];
    
    [self.collectionView scrollToItemAtIndexPath:centerIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

// 默认计collectionView滚动到第一个cell
- (void)scrollToFirstItem {
    NSIndexPath *indexPath  = [NSIndexPath indexPathForItem:0 inSection:1];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self timer];
}

/**
 *  下一个图片
 */
- (void)nextPage {
    NSIndexPath *indexPath = nil;
    if (self.currentIndex == self.imageNames.count - 1) {
        self.currentIndex = 0;
        indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:2];
    } else {
        self.currentIndex ++;
        indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:1];
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

/**
 *  计时器
 */

- (NSTimer *)timer {
    if (_timer == nil){
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
