//
//  KTTabBarController.m
//  KTAiXianFeng
//
//  Created by WangBiao on 2016/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTTabBarController.h"

#import "KTNavigationViewController.h"

@interface KTTabBarController ()


@end

@implementation KTTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;

    //loadChildViewControllerWithClassName:对应的VC
    UIViewController *first = [self loadChildViewControllerWithClassName:@"KTHomePageViewController" andTitle:@"首页" andImageName:@"tab_recent_nor_none"];
    
    UIViewController *second = [self loadChildViewControllerWithClassName:@"YYLShopViewController" andTitle:@"闪送超市" andImageName:@"tab_buddy_nor_none"];
    
    UIViewController *third = [self loadChildViewControllerWithClassName:@"KTResiveVC" andTitle:@"新鲜预定" andImageName:@"tab_qworld_nor_none"];
    
    UIViewController *four = [self loadChildViewControllerWithClassName:@"KTShoppingViewController" andTitle:@"购物车" andImageName:@"tab_qworld_nor_none"];
    
    UIViewController *five = [self loadChildViewControllerWithClassName:@"KTMineViewController" andTitle:@"我的" andImageName:@"tab_qworld_nor_none"];
    
    
    self.viewControllers = @[first,second,third, four, five];
    
}

- (UIViewController *)loadChildViewControllerWithClassName:(NSString *)className andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    Class class = NSClassFromString(className);
    
    UIViewController *vc = [[class alloc] init];
    
    return [self setupTabBarItemAndNavigationControllerWithRootViewController:vc andTitle:title andImageName:imageName];
}

- (UIViewController *)loadChildViewControllerWithStoryboardName:(NSString *)sbName andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    
    return [self setupTabBarItemAndNavigationControllerWithRootViewController:vc andTitle:title andImageName:imageName];
}


- (UIViewController *)setupTabBarItemAndNavigationControllerWithRootViewController:(UIViewController *)viewController andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_1", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    KTNavigationViewController *nav = [[KTNavigationViewController alloc] initWithRootViewController:viewController];
    return nav;
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
