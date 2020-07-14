
//  KTMineViewController.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTMineViewController.h"
#import "KTHeaderView.h"
#import "KTMineModuleCell.h"
#import "KTMineMoneyCell.h"
#import "KTMineOrderCell.h"
#import "KTAddressController.h"
#import "KTJiFController.h"
#import "KTSetViewController.h"
#import "KTOrderController.h"
#import "ViewController.h"
#import "KTServeViewController.h"
#import "KTChatViewContoller.h"

static NSString *moduleIdf = @"module";
static NSString *moneyIdf = @"money";
static NSString *OrderIdf = @"order";


@interface KTMineViewController () <UITableViewDataSource,UITableViewDelegate>


@end

@implementation KTMineViewController
- (void)viewDidLoad{
    [self setupUI];
}

-(void)setupUI{
    
    
    UITableView *mineTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
    [self.view addSubview:mineTableView];
    mineTableView.contentInset = UIEdgeInsetsMake(210, 0, 100, 0);
    [mineTableView registerClass:[KTMineModuleCell class] forCellReuseIdentifier:moduleIdf];
    [mineTableView registerClass:[KTMineMoneyCell class] forCellReuseIdentifier:moneyIdf];
    [mineTableView registerClass:[KTMineOrderCell class] forCellReuseIdentifier:OrderIdf];
    
    KTHeaderView *headerView = [[KTHeaderView alloc]init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(200);
    }];
    [headerView setSetControllerBlock:^(UIButton *sender) {
        
        KTSetViewController *setController = [[KTSetViewController alloc]init];
        setController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setController animated:YES];
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       KTMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderIdf forIndexPath:indexPath];
        [cell setOderBlock:^{
            KTOrderController *orderController = [[KTOrderController alloc]init];
            orderController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:orderController animated:YES];
        }];
        return cell;
    }else if (indexPath.section == 1){
        KTMineMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:moneyIdf forIndexPath:indexPath];
        
        return cell;
    }else{
        KTMineModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:moduleIdf forIndexPath:indexPath];
        [cell setAdddressBlock:^(UIButton *sender) {
            KTAddressController *addVC = [[KTAddressController alloc]init];
            addVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addVC animated:YES];
            
        }];
        [cell setJiFControllerBlock:^(UIButton *sender) {
            KTJiFController *jiFController = [[KTJiFController alloc]init];
            jiFController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:jiFController animated:YES];
        }];
        [cell setViewControllerBlock:^(UIButton *sender) {
            KTServeViewController *vc = [[KTServeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setChatBlock:^(UIButton *btn) {
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"KTChatViewControllerStory" bundle:nil];
            KTChatViewContoller *chat = [storyboard instantiateInitialViewController];

            chat.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chat animated:YES];
        }];
        return cell;
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section <= 1) {
        return 100;
    }else{
        return 200;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
