//
//  SearchHotModel.m
//  
//
//  Created by mac on 16/3/22.
//
//

#import "SearchHotModel.h"

@implementation SearchHotModel

+(instancetype)cellModel:(NSDictionary *)Model
{
    SearchHotModel * hot = [self new];
    hot.title = Model[@"title"];
    hot.id = [Model[@"id"]intValue];
    return hot;
}

@end
