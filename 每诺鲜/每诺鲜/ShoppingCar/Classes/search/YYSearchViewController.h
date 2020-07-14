//
//  YYSearchViewController.h
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSearchViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


+(YYSearchViewController *)SearchViewController;

@property (weak, nonatomic) IBOutlet UICollectionView *YYCollectionView;

@end
