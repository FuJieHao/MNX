//
//  KTAddressDetailVC.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTAddressDetailVC.h"
#import "KTAddressDetailCell.h"
#import "KTAddressModel.h"

static NSString *detailIdf = @"detail";
@interface KTAddressDetailVC ()
@property (nonatomic,weak) KTAddressDetailCell *cell;

@end

@implementation KTAddressDetailVC
- (void)viewDidLoad{
    [self.tableView registerClass:[KTAddressDetailCell class] forCellReuseIdentifier:detailIdf];
    self.tableView.rowHeight = 190;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KTAddressDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdf forIndexPath:indexPath];
    [cell setPopBlock:^(KTAddressModel *addModel) {
        if (self.addressBlock) {
            self.addressBlock(addModel);
        }
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
     [cell setModel1:self.addressModel];

    return cell;
}




@end
