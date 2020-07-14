//
//  YYSearchView.m
//  YYSearchView
//
//  Created by mac on 16/7/12.
//  Copyright © 2016年 Jack YY. All rights reserved.
//

#import "YYSearchView.h"

@implementation YYSearchView

-(void)awakeFromNib
{
    self.YYBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi"]];
    self.YYSearch.leftView = [self leftView];
    self.YYSearch.leftViewMode = UITextFieldViewModeAlways;
}

+(instancetype)creatView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"YYSearchView" owner:nil options:nil]lastObject];
}

-(UIView *)leftView
{
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(18, 8, 24, 24)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(8, 4, 16, 16);
    [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchTile) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:button];
    return leftView;
}
-(void)searchTile
{
    [self.YYSearch resignFirstResponder];
    self.YYGetTitle(self.YYSearch.text);
}

- (IBAction)YYCancel:(UIButton *)sender
{
    [self.YYSearch resignFirstResponder];
    self.YYGetCancel();
}

@end
