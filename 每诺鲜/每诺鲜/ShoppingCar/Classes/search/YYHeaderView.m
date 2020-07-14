//
//  YYHeaderView.m
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "YYHeaderView.h"

@implementation YYHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)titleHeader:(NSString *)indexPath
{
    self.YYTitle.text = indexPath;
}

@end
