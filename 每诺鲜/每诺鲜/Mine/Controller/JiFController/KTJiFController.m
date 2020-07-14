//
//  KTJiFController.m
//  KTAiXianFeng
//
//  Created by apple on 16/10/15.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTJiFController.h"

@interface KTJiFController ()

@end

@implementation KTJiFController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *jiFTopView = [[UIImageView alloc]init];
//    jiFTopView.image = [UIImage imageNamed:@"Snip20161015_2"];
//    [self.view addSubview:jiFTopView];
//    [jiFTopView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.offset(0);
//        make.height.offset(230);
//    }];
//    
//    UIImageView *jiFBottomView = [[UIImageView alloc]init];
//    jiFBottomView.image = [UIImage imageNamed:@"Snip20161015_3"];
//    [self.view addSubview:jiFBottomView];
//    [jiFBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(jiFTopView.mas_bottom);
//        make.bottom.left.right.offset(0);
//        
//    }];
    UIScrollView *sv = [[UIScrollView alloc ]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:sv];
    sv.backgroundColor = [UIColor whiteColor];
    sv.contentSize = CGSizeMake( [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height+50) ;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageV.image = [UIImage imageNamed:@"TNLS`HZP]B_(51`S~NM6DD1"];
    [sv addSubview:imageV];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
