//
//  YYHeaderView.h
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *YYTitle;
-(void)titleHeader:(NSString *)indexPath;

@end
