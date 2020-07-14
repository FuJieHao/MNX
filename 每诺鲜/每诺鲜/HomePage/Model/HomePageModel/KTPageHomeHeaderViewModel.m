//
//  KTPageHomeHeaderViewModel.m
//  KTAiXianFeng
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import "KTPageHomeHeaderViewModel.h"

@implementation KTPageHomeHeaderViewModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@",self.img,self.name,self.customURL];
    
}

@end
