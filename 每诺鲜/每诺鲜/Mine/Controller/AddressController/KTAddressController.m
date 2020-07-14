//
//  KTAddressController.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAddressController.h"
#import "KTAddressCell.h"
#import "KTAddressDetailVC.h"

static NSString *addressIdf = @"address";
@interface KTAddressController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,assign) NSInteger clickNum;

@end

@implementation KTAddressController
- (void)viewDidLoad{
    
    [self setupUI];
}

- (void)setupUI{

    UITableView *addressTB = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    addressTB.rowHeight = 75;
    [self.view addSubview:addressTB];
    addressTB.delegate = self;
    addressTB.dataSource = self;
    // 注册
    [addressTB registerClass:[KTAddressCell class] forCellReuseIdentifier:addressIdf];
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning mark - 实现跳转方法
   KTAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressIdf forIndexPath:indexPath];
    cell.addressModel = self.modelArray[indexPath.section];
    [cell setAddressCellBlock:^(UIButton *sender,KTAddressModel *model) {
       
        KTAddressDetailVC *detailVC = [[KTAddressDetailVC alloc]initWithStyle:UITableViewStyleGrouped];
        detailVC.addressModel = model;
        
        [detailVC setAddressBlock:^(KTAddressModel *addModel) {
            self.modelArray[indexPath.section] = addModel;
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 2;
}
- (NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
        NSArray *pathArray = [NSArray  arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource:@"KTAddressModel.plist" ofType:nil]];
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:_modelArray.count];
        [pathArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KTAddressModel *model = [KTAddressModel addressModelWith:obj];
            [array addObject:model];
        }];
        _modelArray = array;
    }
    return _modelArray;
}


@end
