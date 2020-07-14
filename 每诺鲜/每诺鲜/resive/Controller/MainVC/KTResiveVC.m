//
//  KTResiveVC.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTResiveVC.h"
#import "KTShufflingDevice.h"
#import "KTclassifyCell.h"
#import "KTHorizontalScrollCell.h"
#import "KTDetailsCell.h"
#import "NetworkTool.h"
#import "KTCycleViewModel.h"
#import "UIImageView+WebCache.h"
#import "KTclassifyModel.h"
#import "KTscrollModel.h"
#import "KTdetailModel.h"
#import "UIImage+MultiFormat.h"
#import "KTTodyVC.h"
#import "KTBoxViewController.h"
#import "KTPlanViewController.h"
#import "KTClassilyViewController.h"
#import "KTScrollViewController.h"
#import "KTDetailViewController.h"
#import "UIView+Convenient.h"
#import "KYPullToCurveVeiw.h"
#import "KYPullToCurveVeiw_footer.h"
#import "YYSearchViewController.h"

#define initialOffset 50.0
#define targetHeight 500.0


static NSString *class = @"class";
static NSString *scrollC = @"scrollC";
static NSString *detail = @"detail";
@interface KTResiveVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *cycleModelArray;

@property (nonatomic,weak) UITableView *resiveTV;

@property (nonatomic,weak) ZFBCycleView *cycleView;

@property (nonatomic,strong) NSArray *classifyArray;

@property (nonatomic,strong) NSArray *scrollArray;

@property (nonatomic,strong) NSArray *detailArray;

@property (nonatomic,assign) NSInteger index;

@end

@implementation KTResiveVC
//控制器加载
- (void)viewDidLoad{
    [self loadCycleModelArray];
    [self loadClassifyArray];
    [self loadScrollArray];
    [self loadDetailArray];
    [self setupUI];
    [self addRightBtn];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.index == 0) {
        KYPullToCurveVeiw *headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.resiveTV withNavigationBar:YES];
        
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
        
        KYPullToCurveVeiw_footer *footerView = [[KYPullToCurveVeiw_footer alloc]initWithAssociatedScrollView:self.resiveTV withNavigationBar:YES];
        
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

//设置ui
- (void)setupUI{

    UITableView *resiveTV = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    resiveTV.delegate = self;
    resiveTV.dataSource = self;
    self.resiveTV = resiveTV;
    NSInteger headVH = 120;
    
    //设置headview
//    KTShufflingDevice *shufflingDevice =[[KTShufflingDevice alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, headVH)];
//    shufflingDevice.backgroundColor = [UIColor redColor];
//    resiveTV.tableHeaderView = shufflingDevice;
    ZFBCycleView *cycleView = [[ZFBCycleView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, headVH)];
    //cycleView.model = self.cycleModelArray;
        cycleView.imageArray = [self loadImagesData];
        //设置resiveTV底部偏移
        resiveTV.contentInset = UIEdgeInsetsMake(0, 0,200, 0);
        resiveTV.tableHeaderView = cycleView;
        self.cycleView = cycleView;
//
    
    

    //注册cell
    [resiveTV registerClass:[KTclassifyCell class] forCellReuseIdentifier:class];
    [resiveTV registerClass:[KTHorizontalScrollCell class] forCellReuseIdentifier:scrollC];
    [resiveTV registerClass:[KTDetailsCell class] forCellReuseIdentifier:detail];
    [self.view addSubview:resiveTV];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        KTclassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:class forIndexPath:indexPath];
        cell.modelArray = self.classifyArray;
        [cell setBtnBlock:^(UIButton *sender) {
            switch (sender.tag) {
                case 0:
                {
                    KTTodyVC *tody = [[KTTodyVC alloc]init];
                    [self.navigationController pushViewController:tody animated:NO];
                }
                    break;
                case 1:
                {
                    KTBoxViewController *box = [[KTBoxViewController alloc]init];
                    [self.navigationController pushViewController:box animated:NO];
                }
                    break;
                case 2:
                {
                    KTPlanViewController *plan = [[KTPlanViewController alloc]init];
                    [self.navigationController pushViewController:plan animated:NO];
                }
                    break;
                case 3:
                {
                    KTClassilyViewController *classily = [[KTClassilyViewController alloc]init];
                    [self.navigationController pushViewController:classily animated:NO];
                }
                    break;
                    
                default:
                    break;
            }
        }];
        
        return cell;
    }else if (indexPath.section <= 3){

        KTHorizontalScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollC forIndexPath:indexPath];
        cell.cellTag = indexPath.section;
        cell.modelScrollArray = self.scrollArray;
        [cell setScrollBlock:^(UITapGestureRecognizer *gesture) {
            KTScrollViewController *sVC = [[KTScrollViewController alloc]init];
            sVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sVC animated:YES];
        }];
        
        return cell;
    }else{
    
        KTDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:detail forIndexPath:indexPath];
        NSLog(@"嘻嘻%ld",indexPath.section);
        cell.detailCellTag = indexPath.section;
        cell.detailModelArray = self.detailArray;
        
        [cell setDetailBlock:^(UITapGestureRecognizer *sender) {
            KTDetailViewController *detailVC = [[KTDetailViewController alloc]init];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }];
        [cell setReloadBlock:^(NSInteger relodSection) {
//            [self.resiveTV reloadSections:[NSIndexSet indexSetWithIndex:relodSection] withRowAnimation:NO];
//            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    }
   
    

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;//设置尾视图高度为0.01
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else if(indexPath.section < 4){
    
        return 240;
    }else{
    
        return 440;
    }


}

- (NSArray *)loadImagesData {
    NSMutableArray *arrM = [NSMutableArray array];
    //[NSThread sleepForTimeInterval:3];
    for (NSInteger i = 0; i < 4; i++) {
      
        //        [self.cycleView setMediationBlock:^(UIImageView *cellImageView) {
//            [cellImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"user_default"]];
//        }];
        //NSLog(@"%@",[NSThread currentThread]);
       // NSString *imageName = @"user_default";
        [arrM addObject:@(i)];
    }
    return arrM;
}
//懒加载读取数据
-(void)loadCycleModelArray{

    if (_cycleModelArray == nil) {
        [[NetworkTool  sharedNetworkTool]GETWithURLString:@"yuding.json" success:^(id responseObject) {
            NSArray <NSDictionary*>*dataArray = responseObject[@"data"][@"act_info"];
            NSMutableArray *temporary = [NSMutableArray array];
            NSDictionary *cycleDict = dataArray[0];
                NSArray <NSDictionary*>*rowsArray = cycleDict[@"act_rows"];
                [rowsArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dict = obj[@"activity"];
                    KTCycleViewModel *model = [KTCycleViewModel cycleViewModelWithDict:dict];
                    [temporary addObject:model];
                    //NSLog(@"%@====%@",[NSThread currentThread],temporary);
                }];
            
            
            self.cycleModelArray = temporary;
            self.cycleView.modelArray = temporary;
            //[self.resiveTV reloadData];
        } faile:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }


   
}

- (void)loadClassifyArray{
    if (_classifyArray == nil) {
        [[NetworkTool  sharedNetworkTool]GETWithURLString:@"yuding.json" success:^(id responseObject) {
            NSArray <NSDictionary*>*dataArray = responseObject[@"data"][@"act_info"];
            NSMutableArray *temporary = [NSMutableArray array];
            NSDictionary *cycleDict = dataArray[1];
            NSArray <NSDictionary*>*rowsArray = cycleDict[@"act_rows"];
            [rowsArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dict = obj[@"activity"];
                KTclassifyModel *model = [KTclassifyModel classifyModelWithDict:dict];
                [temporary addObject:model];
//                NSLog(@"%@====%@",[NSThread currentThread],temporary);
            }];
            
            _classifyArray = temporary;
            //[self.resiveTV reloadData];
        } faile:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }



    
}

- (void)loadScrollArray{
    if (_scrollArray == nil) {
        [[NetworkTool  sharedNetworkTool]GETWithURLString:@"yuding.json" success:^(id responseObject) {
            NSArray <NSDictionary*>*dataArray = responseObject[@"data"][@"act_info"];
            NSMutableArray *temporary = [NSMutableArray array];
            NSDictionary *cycleDict = dataArray[2];
            NSArray <NSDictionary*>*rowsArray = cycleDict[@"act_rows"];
            [rowsArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                KTscrollModel *model = [KTscrollModel scrollModelWithDict:obj];
                [temporary addObject:model];
//                NSLog(@"%@====%@",[NSThread currentThread],temporary);
            }];
            
            _scrollArray = temporary;
            //[self.resiveTV reloadData];
        } faile:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
    
    
    
}


- (void)loadDetailArray{
    if (_detailArray == nil) {
            [[NetworkTool  sharedNetworkTool]GETWithURLString:@"yuding.json" success:^(id responseObject) {
            NSArray <NSDictionary*>*dataArray = responseObject[@"data"][@"act_info"];
            NSMutableArray *temporary = [NSMutableArray array];
            NSDictionary *cycleDict = dataArray[3];
            NSArray <NSDictionary*>*rowsArray = cycleDict[@"act_rows"];
            [rowsArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                KTdetailModel *model = [KTdetailModel detailModelWithDict:obj];
                [temporary addObject:model];
//                NSLog(@"%@====%@",[NSThread currentThread],temporary);
            }];
            
            _detailArray = temporary;
            [self.resiveTV reloadData];
        } faile:^(NSError *error) {
            NSLog(@"%@",error);
        }];

    }



    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
}

- (void)addRightBtn {
    
    UIBarButtonItem *rightBarItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_aa"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    
    [self.navigationController pushViewController:[[YYSearchViewController alloc]init] animated:YES];
}



@end
