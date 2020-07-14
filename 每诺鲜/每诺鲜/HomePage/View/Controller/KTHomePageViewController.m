//
//  KTHomePageViewController.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageViewController.h"
#import "KTNetworking.h"
#import "KTPageHomeHeaderViewModel.h"
#import "KTHomePageHeaderView.h"
#import "KTHomePageFirstModel.h"
#import "KTHomePageFirstTableViewCell.h"

#import "KTHomePageFreshCell.h"
#import "KTHomePageConvenientCell.h"
#import "KTHomePageOtherCell.h"

#import "KTHPConvenientModel.h"
#import "KTHPFreshModel.h"
#import "KTHPOtherModel.h"
#import "KTHPOtherGoodsModel.h"

#import "KTHPWebViewController.h"
#import "KTSaoYiSaoViewController.h"
#import "KTHuoXingViewController.h"

#import "UIView+Convenient.h"
#import "KYPullToCurveVeiw.h"
#import "KYPullToCurveVeiw_footer.h"

#import "YYSearchViewController.h"

#define initialOffset 50.0
#define targetHeight 500.0

@interface KTHomePageViewController () <UITableViewDelegate,UITableViewDataSource,KTHomePageOtherCellDelegate,HomePageFirstTableViewCellDelegate,HuoXingViewControllerDelegate>

@property (nonatomic,weak) KTHomePageHeaderView *headerView;
@property (nonatomic,weak) KTHomePageFirstTableViewCell *scrollView;

@property (nonatomic,weak) CAEmitterLayer *snowEmitter;

@property (nonatomic,weak) UIButton *addressBtn;

@property (nonatomic,assign) NSInteger index;

@end

@implementation KTHomePageViewController
{
    NSInteger _index;

    //存四张大图的模型数组
    NSMutableArray *_arr_activeM;
    //存图片轮播的模型数组
    NSMutableArray *_arr_focusM;
    //存四张小图的模型数组
    NSMutableArray *_arr_iconsM;
    
    //存其他模型
    NSMutableArray *_arr_otherM;
    
    NSString *_address;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.index == 0) {
        KYPullToCurveVeiw *headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
        
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
        
        KYPullToCurveVeiw_footer *footerView = [[KYPullToCurveVeiw_footer alloc]initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
        
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
    

    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"扫一扫"]];
//    image.layer.cornerRadius = 34 * 0.5;
//    image.layer.masksToBounds = YES;
    
    image.userInteractionEnabled = YES;
    
//    image.frame = CGRectMake(0, 0, 34, 34);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openSaoYiSao)];
    [image addGestureRecognizer:tap];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:image];
}

- (void)openSaoYiSao
{
    KTSaoYiSaoViewController *vc = [[KTSaoYiSaoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
    snowEmitter.emitterSize  = CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode  = kCAEmitterLayerOutline;
    self.snowEmitter = snowEmitter;
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    snowflake.birthRate	= 1.0;
    snowflake.lifetime	= 120.0;
    snowflake.velocity	= -10;
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents  = (id) [[UIImage imageNamed:@"snow"] CGImage];
    snowflake.color	= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius  = 0.0;
    snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.tableView.layer insertSublayer:snowEmitter atIndex:999];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.snowEmitter removeFromSuperlayer];
}

- (void)homePageFirstTableViewCell:(KTHomePageFirstTableViewCell *)vc andURLString:(NSString *)URL
{
    KTHPWebViewController *vc1 = [[KTHPWebViewController alloc]initWithURL:[NSURL URLWithString:URL]];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (void)homePageOtherCell:(KTHomePageOtherCell *)vc andTopString:(NSString *)topString
{
    KTHPWebViewController *vc1 = [[KTHPWebViewController alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.navigationController pushViewController:vc1 animated:YES];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arr_activeM.count + 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _arr_activeM.count + 2) {
        return 0.1;
    } else {
        return 7;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.headerView.pic_dataSource = _arr_activeM;
    self.scrollView.scrollViewDataSource = _arr_focusM;
    self.scrollView.smallImageDataSource = _arr_iconsM;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ConvenientCell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        KTHPConvenientModel *model = [KTHPConvenientModel convenientModel];
        ((KTHomePageConvenientCell *)cell).model = model;
        
    } else if (indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FreshCell" forIndexPath:indexPath];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        KTHPFreshModel *model = [KTHPFreshModel freshModel];
        ((KTHomePageFreshCell *)cell).model = model;
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"OtherCell" forIndexPath:indexPath];
        ((KTHomePageOtherCell *)cell).delegate = self;

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (_arr_otherM.count != 0) {
        
            ((KTHomePageOtherCell *)cell).model = _arr_otherM[indexPath.section - 2];
        }
        
    }
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableVie
    self.tableView.backgroundColor = [UIColor clearColor];
    
    _arr_activeM = [NSMutableArray array];
    _arr_focusM = [NSMutableArray array];
    _arr_iconsM = [NSMutableArray array];
    _arr_otherM = [NSMutableArray array];
    _address = [NSString stringWithFormat:@"中腾建华大厦"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"KTHomePageOtherCell" bundle:nil] forCellReuseIdentifier:@"OtherCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KTHomePageFreshCell" bundle:nil] forCellReuseIdentifier:@"FreshCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KTHomePageConvenientCell" bundle:nil] forCellReuseIdentifier:@"ConvenientCell"];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self loadJson];
    [self loadNewJson];
    
    [self setupUI];
    [self setupUIWithLocation];
    
    [self addRightBtn];
}

- (void)setupUI
{
    //创建顶部xib
    KTHomePageFirstTableViewCell *topView = [KTHomePageFirstTableViewCell homePageFirstTableView];
    topView.delegate = self;
    self.scrollView = topView;
    
    //创建大图xib
    KTHomePageHeaderView *pictureView = [KTHomePageHeaderView homePageHeaderView];
    pictureView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.headerView = pictureView;
    
    
    
    CGFloat tableViewW = self.tableView.bounds.size.width;
    
    topView.frame = CGRectMake(0, 0, tableViewW, 193);
    
    CGFloat realH = tableViewW / pictureView.bounds.size.width * pictureView.bounds.size.height;
    pictureView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame), tableViewW, realH);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableViewW, CGRectGetMaxY(pictureView.frame))];
    
    //
    [headerView addSubview:topView];
    [headerView addSubview:pictureView];
    
    //设置headerView
    self.tableView.tableHeaderView = headerView;
}

/**
 *  统一加载json数据
 */
- (void)loadJson
{
    NSString *URLString = @"focus.json.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"1" forKey:@"call"];
    
    [KTNetworking postUrlString:URLString withParam:parameters withSuccessBlock:^(id responseObject) {
        
        //解析四张大图
        for (NSDictionary *dict_active in responseObject[@"data"][@"activities"]) {
        
            KTPageHomeHeaderViewModel *headerModel = [[KTPageHomeHeaderViewModel alloc]init];
            
            headerModel.img = dict_active[@"img"];
            headerModel.name = dict_active[@"name"];
            headerModel.customURL = dict_active[@"customURL"];
            
            [_arr_activeM addObject:headerModel];
        }
        
        //解析图片轮播
        for (NSDictionary *dict_focus in responseObject[@"data"][@"focus"]) {
            
            KTHomePageFirstModel *scrollModel = [[KTHomePageFirstModel alloc]init];
            scrollModel.img = dict_focus[@"img"];
            scrollModel.name = dict_focus[@"name"];
            scrollModel.toURL = dict_focus[@"toURL"];
            
            [_arr_focusM addObject:scrollModel];
        }
        
        //解析四张小图(网络状态）
        
//        for (NSDictionary *dict_icons in responseObject[@"data"][@"icons"]) {
//            
//            KTPageHomeHeaderViewModel *headerModel = [[KTPageHomeHeaderViewModel alloc]init];
//            headerModel.img = dict_icons[@"img"];
//            
//            headerModel.name = dict_icons[@"name"];
//            headerModel.customURL = dict_icons[@"customURL"];
//            
//            [_arr_iconsM addObject:headerModel];
//        }
        
        for (NSInteger i = 0; i < ((NSArray *)responseObject[@"data"][@"icons"]).count; i++) {
            KTPageHomeHeaderViewModel *headerModel = [[KTPageHomeHeaderViewModel alloc]init];
            NSDictionary *dict_icons = ((NSArray *)responseObject[@"data"][@"icons"])[i];
            headerModel.img = [NSString stringWithFormat:@"首页%ld",i+1];

            headerModel.name = dict_icons[@"name"];
            headerModel.customURL = dict_icons[@"customURL"];

            [_arr_iconsM addObject:headerModel];
        }
        //刷新tableview
        [self.tableView reloadData];
        
    } withErrorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)loadNewJson
{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aixianfeng.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict_Json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *arr = dict_Json[@"data"][@"act_info"][6][@"act_rows"];
    
    for (NSDictionary *dict in arr) {
        
        KTHPOtherModel *model = [[KTHPOtherModel alloc]init];
        model.topImg = dict[@"activity"][@"topimg"];
        model.name = dict[@"activity"][@"name"];
        model.category_color = (uint32_t)dict[@"category_detail"][@"category_color"];
        NSArray *arr_goods = dict[@"category_detail"][@"goods"];
        NSMutableArray *arrM_goods = [NSMutableArray array];
        for (NSDictionary *dict_good in arr_goods) {
            KTHPOtherGoodsModel *model = [[KTHPOtherGoodsModel alloc] init];
            model.name = dict_good[@"name"];
            model.specifics = dict_good[@"specifics"];
            model.market_price = dict_good[@"market_price"];
            model.partner_price = dict_good[@"partner_price"];
            model.img = dict_good[@"img"];
            
            [arrM_goods addObject:model];
        }
        model.arrModel = arrM_goods.copy;
        [_arr_otherM addObject:model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 354;
        
    } else if (indexPath.section == 1) {
        return 340;
    } else {
        return 340;
    }
}

- (void)setupUIWithLocation
{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"中腾建华大厦" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(goToLocation) forControlEvents:UIControlEventTouchUpInside];
    self.addressBtn = btn;
    self.navigationItem.titleView = btn;
}

- (void)goToLocation
{
    KTHuoXingViewController *vc = [[KTHuoXingViewController alloc] init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)huoXingViewController:(KTHuoXingViewController *)vc andAdress:(NSString *)adress
{
    if (adress != nil) {
        _address = adress;
        [self.addressBtn setTitle:adress forState:UIControlStateNormal];
    } else {
        [self.addressBtn setTitle:_address forState:UIControlStateNormal];
    }
}

- (void)addRightBtn {
    
    UIBarButtonItem *rightBarItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_aa"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    
    [self.navigationController pushViewController:[[YYSearchViewController alloc]init] animated:YES];
}

@end












