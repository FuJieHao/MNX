//
//  FJTabbarController.m
//  15-8项目网易彩票
//
//  Created by 郝 on 16/2/2.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJTabbarController.h"
#import "FJTabbar.h"
#import "KTNavigationViewController.h"

@interface FJTabbarController () <FJTabbarDelegate>

@end

@implementation FJTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.translucent = NO;
    
    //loadChildViewControllerWithClassName:对应的VC
    UIViewController *first = [self loadChildViewControllerWithClassName:@"KTHomePageViewController" andTitle:@"首页" andImageName:@"tab_recent_nor_none"];
    
    UIViewController *second = [self loadChildViewControllerWithClassName:@"YYLShopViewController" andTitle:@"闪送超市" andImageName:@"tab_buddy_nor_none"];
    
    UIViewController *third = [self loadChildViewControllerWithClassName:@"KTResiveVC" andTitle:@"新鲜预定" andImageName:@"tab_qworld_nor_none"];
    
    UIViewController *four = [self loadChildViewControllerWithClassName:@"KTShoppingViewController" andTitle:@"购物车" andImageName:@"tab_qworld_nor_none"];
    
    UIViewController *five = [self loadChildViewControllerWithClassName:@"KTMineViewController" andTitle:@"我的" andImageName:@"tab_qworld_nor_none"];
    
    
    self.viewControllers = @[first,second,third, four, five];
    
    //自己写一个tabbar替换系统tabbar
    //自定义一个tabbar
    
    FJTabbar *mTabbar = [[FJTabbar alloc]initWithFrame:self.tabBar.bounds];
    mTabbar.backgroundColor = [UIColor whiteColor];
    
    //添加按钮
    //自定义的tabbar添加五个按钮
        for (NSInteger i = 0; i < 5; i++) {
    //获取普通状态的图片名称
    NSString *normalImg = [NSString stringWithFormat:@"tabBar0%ld",i+1];
            
    //获取选中的图片
    NSString *selImg = [NSString stringWithFormat:@"tabBar%ld",i+1];
    [mTabbar addTabbarBtnWithNormalImg:normalImg selImg:selImg];
    
    }
    
    //设置代理
    mTabbar.delegate = self;
    
    //把自定义的tabbar添加 到系统的tabbar上
    [self.tabBar addSubview:mTabbar];
    
   }

#pragma mark 自定义tabbar的代理
- (void)tabbar:(FJTabbar *)tabbar didSelectedFrom:(NSInteger)form to:(NSInteger)to
{
    //切换tabbar控制器的子控制器
    self.selectedIndex = to;
}

- (UIViewController *)setupTabBarItemAndNavigationControllerWithRootViewController:(UIViewController *)viewController andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
//    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_1", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    KTNavigationViewController *nav = [[KTNavigationViewController alloc] initWithRootViewController:viewController];
    return nav;
}

- (UIViewController *)loadChildViewControllerWithStoryboardName:(NSString *)sbName andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    
    return [self setupTabBarItemAndNavigationControllerWithRootViewController:vc andTitle:title andImageName:imageName];
}

- (UIViewController *)loadChildViewControllerWithClassName:(NSString *)className andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    Class class = NSClassFromString(className);
    
    UIViewController *vc = [[class alloc] init];
    
    return [self setupTabBarItemAndNavigationControllerWithRootViewController:vc andTitle:title andImageName:imageName];
}


@end
