//
//  KTclassifyModel.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTclassifyModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *img;
+ (instancetype)classifyModelWithDict:(NSDictionary *)dict;
@end
