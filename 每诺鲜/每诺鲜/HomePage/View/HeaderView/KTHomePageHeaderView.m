//
//  KTHomePageHeaderView.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHomePageHeaderView.h"
#import <UIImageView+WebCache.h>
#import "KTPageHomeHeaderViewModel.h"

@interface KTHomePageHeaderView ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imagesArr;

@end

@implementation KTHomePageHeaderView

+ (instancetype)homePageHeaderView
{
    UINib *nib = [UINib nibWithNibName:@"KTHomePageHeaderView" bundle:nil];
    KTHomePageHeaderView *headerView = [[nib instantiateWithOwner:nil options:nil] firstObject];
    
    return headerView;
}

- (void)setPic_dataSource:(NSArray *)pic_dataSource
{
    _pic_dataSource = pic_dataSource;
    
    if (pic_dataSource.count != 0) {
        for (NSInteger i = 0; i < 4; i++) {
            [((UIImageView *)self.imagesArr[i]) sd_setImageWithURL:(NSURL *)((KTPageHomeHeaderViewModel *)(pic_dataSource[i])).img placeholderImage:[UIImage imageNamed:@"33984118F2AD8EFF3F38AFC074F738E4"]];
        }
    } 
}

@end
