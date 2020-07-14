//
//  KTSetViewController.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTSetViewController.h"
#import "KTAboutViewController.h"

static NSString *setNSString = @"set";

@interface KTSetViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation KTSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *setTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [setTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:setNSString];
    setTableView.delegate = self;
    setTableView.dataSource = self;
    [self.view addSubview:setTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else {
        return 1;
    }

}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setNSString forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"分享给朋友";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"关于我们";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.textLabel.text = @"清除缓存";
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
    }else{
    
        cell.textLabel.text = @"退出";
        cell.textAlignment = NSTextAlignmentCenter ;
    }
    return cell;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            
        }else if(indexPath.row == 1){
            KTAboutViewController *aboutController = [[KTAboutViewController alloc]init];
            aboutController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutController animated:YES];
        }else{
            
        }
    }else{
        
    }

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
