//
//  YYLShopViewController.m
//  KTAiXianFeng
//
//  Created by wangddj on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "YYLShopViewController.h"
#import "YYLCategroyCell.h"
#import "KTSuperMarketLeftModel.h"

#import "UIView+Convenient.h"
#import "KYPullToCurveVeiw.h"
#import "KYPullToCurveVeiw_footer.h"

#define initialOffset 50.0
#define targetHeight 500.0

static NSString *cellID = @"cellID";
static NSString *headerID =  @"headerID";
@interface YYLShopViewController () <UITableViewDataSource, UITableViewDelegate>
// 分类列表
@property (nonatomic, weak) UITableView *tvCategory;


// 菜品列表
@property (nonatomic, weak) UITableView *tvFood;

@property (nonatomic,assign) NSInteger index;

@end

@implementation YYLShopViewController {
    // 存放所有的分类模型!
    NSArray<KTSuperMarketLeftModel *> *_categoryList;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.index == 0) {
        KYPullToCurveVeiw *headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.tvFood withNavigationBar:YES];
        
        __weak KYPullToCurveVeiw *weakHeaderView = headerView;
        
        [headerView triggerPulling];
        [headerView addRefreshingBlock:^{
            //具体的操作
            double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weakHeaderView stopRefreshing];
            });
            
        }];
        
        KYPullToCurveVeiw_footer *footerView = [[KYPullToCurveVeiw_footer alloc]initWithAssociatedScrollView:self.tvFood withNavigationBar:YES];
        
        __weak KYPullToCurveVeiw_footer *weakFooterView= footerView;
        
        [footerView addRefreshingBlock:^{
            //具体的操作
            double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [weakFooterView stopRefreshing];
                
            });
        }];
        
        self.index ++;
    }

}

- (void)setupUI {
    //滚动视图
    
    // MARK: - 1.两个列表视图
    // 分类列表
    UITableView *tvCategory = [[UITableView alloc] init];
    
    [self.view addSubview:tvCategory];
    
    [tvCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(86);
        make.left.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];
    
    // 菜品列表
    UITableView *tvFood = [[UITableView alloc] init];
    
    [self.view addSubview:tvFood];
    
    [tvFood mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(tvCategory);
        make.left.equalTo(tvCategory.mas_right);
        make.right.equalTo(self.view);
        
    }];
    
    
    
    
    // MARK: - 1.2 统一设置列表对应的属性!
    tvCategory.dataSource = self;
    tvCategory.delegate = self;
    
    tvFood.dataSource = self;
    tvFood.delegate = self;
    
    // 注册cell cmd + L 跳到某一行!
    [tvCategory registerClass:[YYLCategroyCell class] forCellReuseIdentifier:cellID];
    [tvFood registerClass:[YYLFoodCell class] forCellReuseIdentifier:cellID];
    // 注册头部视图
    [tvFood registerClass:[YYLFoodHeaderView class] forHeaderFooterViewReuseIdentifier:headerID];
    tvFood.sectionHeaderHeight = 23;
    
    // 设置高度
    tvCategory.rowHeight = 55;
    tvFood.rowHeight = 150;
    // - 设置菜品列表的行高为预估行高!
    tvFood.rowHeight = UITableViewAutomaticDimension;
    tvFood.estimatedRowHeight = 120;
    // 设置分割线样式
    tvCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 记录成员变量
    _tvCategory = tvCategory;
    _tvFood = tvFood;
    
    
}

#pragma mark - 代理方法
// 方法调用:当用户滚动列表的时候,在将要显示新的cell的时候调用!
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    NSLog(@"xincell 出来了");
    if (tableView == _tvCategory) {
        return;
    }
    
    // 如果不是用户拖动的,直接忽略!
    if (!(tableView.dragging || tableView.decelerating || tableView.tracking)) {
        return;
    }
    
    // 菜品
    NSIndexPath *newPath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    
    // 让分类选中另外的行
    [_tvCategory selectRowAtIndexPath:newPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    
}

// 选中行的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 分类的选中
    if (tableView == _tvCategory) {
        
        // 1.让菜品滚动!
        // 1.1 创建索引
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        
     //让列表视图进行滚动的方法
        /**
         参数1 要滚动到的行的索引信息!
         参数2 停留的位置
         */
        [_tvFood scrollToRowAtIndexPath:newPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        // 2.返回,防止往下走!
    }
    
    // 菜品的选中!
    
}


// 组头部视图!
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // 分类,直接忽略
    if (tableView == _tvCategory) {
        return nil;
    }
    
    // 菜品!
    // 1.创建视图
    YYLFoodHeaderView *headerV = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    
    // 2.设置数据!
    headerV.title = _categoryList[section].signName;
    
    
    // 3.返回
    return headerV;
    
    
}



//数据源方法
// 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // 分类列表
    if (tableView == _tvCategory) {
        
        return 1;
    }
    
    // 菜品列表
    return _categoryList.count;
    
}

// 行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 分类
    if (tableView == _tvCategory) {
        
        return _categoryList.count;
    }
    
    // 菜品
    // 1.获取第 section 组的分类数据
    KTSuperMarketLeftModel *categoryModel = _categoryList[section];
    // 2.返回行数 -> 分类里面菜品的数量!
    return categoryModel.arrModel.count;
    
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell 多态!
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // 2.设置数据
    if (tableView == _tvCategory) {
        
        (( YYLCategroyCell *)cell).categoryModel = _categoryList[indexPath.row];
        
        return cell;
    }
    
    // 菜品的位置!
        ((YYLFoodCell *)cell).foodModel = _categoryList[indexPath.section].arrModel[indexPath.row];
        [(YYLFoodCell *)cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // 3.返回cell!
    return cell;
}

#pragma mark - 加载数据
- (void)loadData {
    

    NSArray *arr = [KTSuperMarketLeftModel superMarketLeftArrModel];
    // 6.赋值
    _categoryList = arr;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [_categoryList enumerateObjectsUsingBlock:^(KTSuperMarketLeftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        NSLog(@"%@", obj.spus);
        
    }];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
