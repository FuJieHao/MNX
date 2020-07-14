//
//  KTHPConvenientCollectionViewCell.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/13.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTHPConvenientCollectionViewCell.h"
#import "UIButton+WebCache.h"

@interface KTHPConvenientCollectionViewCell ()

@property (nonatomic,weak) IBOutlet UIButton *btn;

@end

@implementation KTHPConvenientCollectionViewCell

- (void)setImgURL:(NSString *)imgURL
{
    _imgURL = imgURL;
    
    [self.btn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.imgURL] forState:UIControlStateNormal];
}

@end
