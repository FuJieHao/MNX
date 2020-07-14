//
//  KTShoppingViewController.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTShoppingViewController.h"

#import "EmptyShopCarView.h"
#import "ReceiptAddressView.h"
#import "ShopCartMarkerView.h"
#import "ShopCartSignTimeView.h"
#import "ShopCartCommentsView.h"
#import "ShopCartCell.h"
#import "ShopCarTableFootView.h"
#import "OrderPayWayViewController.h"
#import "KTRemarkViewController.h"
#import "UserFeedBackViewController.h"

#import "KTHPOtherGoodsModel.h"
#import "KTHuoXingViewController.h"
#import "YYSearchViewController.h"

//***模型
#import "KTdetailModel.h"
#import "KTModel.h"

#import "EmptyShopCarView.h"
#import "KTHomePageViewController.h"


@interface KTShoppingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *tableHeadView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) EmptyShopCarView *emptyUI;
@property (nonatomic,strong) NSMutableArray *shopCar;
@property (nonatomic,strong) ShopCarTableFootView *tableFootView;
@property (nonatomic, strong) EmptyShopCarView *emptyShopCarView;

@property (nonatomic, assign) NSInteger countNumber;

@end

@implementation KTShoppingViewController


- (void)getNoti:(NSNotification *)noti{
    
    //接收到减号通知
    if (![noti.userInfo[modelName] isEqualToString:@"-"]) {
        KTModel *model = [[KTModel alloc]init];
        
        model.goodsName = noti.userInfo[modelName];
        model.goodsPrice = noti.userInfo[modelPrice];
        model.imgURL = noti.userInfo[modelimgURL];
        
        [self.shopCar addObject:model];
    }else{
        
        NSInteger integer = self.shopCar.count - 1;
        if (integer < 0) {
            
        } else {
            [self.shopCar removeObjectAtIndex:integer];
        }
}
    
    if (self.shopCar.count == 0) {
        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
        
    } else{
        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%zd", self.shopCar.count]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (!(_shopCar.count > 0)) {
        self.emptyUI.hidden = NO;
        self.tableView.hidden = YES;
    }else {
        self.emptyUI.hidden = YES;
 
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:194/255.0 green:95/255.0 blue:95/255.0 alpha:1]];
        [SVProgressHUD showWithStatus:@"购物车正在加载中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            self.tableView.hidden = NO;
        });
    }
}


- (void)viewDidLoad {
    
    self.title = @"购物车";
    [super viewDidLoad];
    [self buildTableView];
    [self buildEmptyUI];
    
    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti addObserver:self selector:@selector(getNoti:) name:modelNoti object:nil];
    
    self.shopCar = [NSMutableArray array];
    [self addRightBtn];
}


- (void)dealloc{

    NSNotificationCenter *noti = [NSNotificationCenter defaultCenter];
    [noti removeObserver:self];
}

- (void)addRightBtn {
    
    UIBarButtonItem *rightBarItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_aa"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    
    [self.navigationController pushViewController:[[YYSearchViewController alloc]init] animated:YES];
}


- (void)buildTableView {
    
    self.tableView = ({
        UITableView *view =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.delegate = self;
        view.dataSource = self;
        view.showsVerticalScrollIndicator = NO;
        view.hidden = YES;
        view.backgroundColor = [UIColor clearColor];
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view;
    });
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self buildTableHeadView];
    
    [self buildTableFootView];
}

- (void)buildEmptyUI{
    self.emptyUI = [[EmptyShopCarView alloc]init];
    self.emptyUI.hidden = YES;
    [self.view addSubview:self.emptyUI];
    [self.emptyUI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(170);
    }];
    
    self.emptyShopCarView.gotoHomeBlock = ^{
    
    [self.navigationController pushViewController:[[KTHomePageViewController alloc]init] animated:YES];
    };
}

- (void)buildTableHeadView {
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 160)];
    self.tableHeadView.backgroundColor = self.view.backgroundColor;
    
    ReceiptAddressView *addressView = [[ReceiptAddressView alloc]initWithFrame:CGRectMake(0, 0, Width, 66) modify:^{
    
        [self.navigationController pushViewController:[[KTHuoXingViewController alloc] init] animated:YES];
    }];
    
    ShopCartMarkerView *marketView = [[ShopCartMarkerView alloc]initWithFrame:CGRectMake(0, 66, Width, 30)];
    ShopCartSignTimeView *signTimeView = [[ShopCartSignTimeView alloc]initWithFrame:CGRectMake(0, 96, Width, 60)];

    [self addToHeadViewWithBorder:addressView];
    [self addToHeadViewWithBorder:marketView];
    [self addToHeadViewWithBorder:signTimeView];
    self.tableView.tableHeaderView = self.tableHeadView;
    ;
}

- (void)buildTableFootView {
    self.tableFootView = [[ShopCarTableFootView alloc]initWithFrame:CGRectMake(0, 0, Width, 100)];

    __weak typeof(self) wSelf = self;
    self.tableFootView.sureButtonCliked = ^{
        [wSelf.navigationController pushViewController:[OrderPayWayViewController new] animated:YES];
    };
    
    //block回调跳转
    self.tableFootView.carcommentView.SuccessClickBlock = ^{
    
        [wSelf.navigationController pushViewController:[[UserFeedBackViewController alloc]init] animated:YES];
    };
    self.tableView.tableFooterView = self.tableFootView;
    
}

- (void)addToHeadViewWithBorder:(UIView *)view {
    
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
    [self.tableHeadView addSubview:view];
}


- (void)didRemoveProduct {
    
    if (self.shopCar.count == 0) {
        self.emptyUI.hidden = NO;
        self.tableView.hidden = YES;
        return;
    }
    [self.tableView reloadData];
}

#pragma datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.shopCar.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCartCell *cell = [ShopCartCell cellWithTableView:tableView];
    cell.goods = self.shopCar[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}
@end
