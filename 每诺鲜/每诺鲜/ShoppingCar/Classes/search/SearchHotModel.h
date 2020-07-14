//
//  SearchHotModel.h
//  
//
//  Created by mac on 16/3/22.
//
//

#import <Foundation/Foundation.h>

@interface SearchHotModel : NSObject

/** 热搜名词 */
@property (nonatomic, copy) NSString * title;

/** 热搜id */
@property (nonatomic, assign) int id;

+(instancetype)cellModel:(NSDictionary *)Model;

@end
