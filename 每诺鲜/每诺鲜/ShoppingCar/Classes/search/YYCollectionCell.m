//
//  YYCollectionCell.m
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "YYCollectionCell.h"
#import "SearchHotModel.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
@implementation YYCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.font = [UIFont systemFontOfSize:14.0f];
        _firstLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        _firstLabel.layer.borderWidth = 1.0f;
        _firstLabel.layer.borderColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0].CGColor;
        _firstLabel.layer.cornerRadius = 5.0f;
        _firstLabel.clipsToBounds = YES;
        [self.contentView addSubview:_firstLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sizeForFirstLabel = [self.firstLabel.text boundingRectWithSize:CGSizeMake(ScreenWidth, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:20.0f]} context:nil].size;
    self.firstLabel.frame = CGRectMake(0, 0, sizeForFirstLabel.width, sizeForFirstLabel.height + 10);
    
    CGRect frame = self.contentView.frame;
    frame.size = CGSizeMake(sizeForFirstLabel.width, sizeForFirstLabel.height + 18.0);
    self.contentView.frame = frame;
    CGRect cellFrame = self.frame;
    cellFrame.size = self.contentView.frame.size;
    self.frame = cellFrame;
}

-(void)cellModel:(SearchHotModel *)Model
{
    self.firstLabel.text = Model.title;
}


@end
