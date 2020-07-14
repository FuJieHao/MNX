//
//  KTHomePageFirstTableViewCell.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageFirstTableViewCell.h"
#import "ZFBSlideView.h"
#import "KTHomePageFirstModel.h"
#import "KTPageHomeHeaderViewModel.h"
#import "KTHPWebViewController.h"

@interface KTHomePageFirstTableViewCell ()

@property (nonatomic,weak) IBOutlet ZFBSlideView *slideView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imagesArr;

@end

@implementation KTHomePageFirstTableViewCell

+ (instancetype)homePageFirstTableView
{
    UINib *nib = [UINib nibWithNibName:@"KTHomePageFirstTableViewCell" bundle:nil];
    KTHomePageFirstTableViewCell *topView = [[nib instantiateWithOwner:nil options:nil] firstObject];
    
    [topView addGesture];
    
    return topView;
}

- (void)addGesture
{
    for (UIImageView *image in self.imagesArr) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToWeb:)];
        [image addGestureRecognizer:tap];
    }
}

- (void)goToWeb:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(homePageFirstTableViewCell:andURLString:)]) {
        
        [self.delegate homePageFirstTableViewCell:self andURLString:@"http://taobao.com"];
    }
}

/**
 *  从数据源加载小图
 *
 *  @param smallImageDataSource 小图的数据源
 */
- (void)setSmallImageDataSource:(NSArray *)smallImageDataSource
{
    _smallImageDataSource = smallImageDataSource;
    if (smallImageDataSource.count != 0) {
                for (NSInteger i = 0; i < 4; i++) {
                    ((UIImageView *)self.imagesArr[i]).image = [UIImage imageNamed:((KTPageHomeHeaderViewModel *)(smallImageDataSource[i])).img];
                }
    }
}

/**
 *  轮播的数据源方法
 */
- (void)setScrollViewDataSource:(NSArray *)scrollViewDataSource
{
    _scrollViewDataSource = scrollViewDataSource;
    
    if (scrollViewDataSource.count != 0) {
        
        NSMutableArray *imgNameArr = [NSMutableArray array];
        for (KTHomePageFirstModel *model in scrollViewDataSource) {
            NSString *imgName = model.img;
            [imgNameArr addObject:imgName];
        }
        self.slideView.imageNames = imgNameArr;
    }

}

@end
