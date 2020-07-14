//
//  KTCycleViewModel.h
//  KTAiXianFeng
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 lsrain. All rights reserved.
//
//"activity": {
//    "id": "21752",
//    "name": "新鲜预订－封虾榜",
//    "img": "http://img01.bqstatic.com//upload/activity/2016100517175041.jpg@90Q.jpg",
//    "topimg": "http://img01.bqstatic.com//upload/activity/2016100517175041.jpg@90Q.jpg",
//    "jptype": 11,
//    "sort": "999",
//    "ext_params": {
//        "cityid": "2",
//        "bigids": "2,0",
//        "activitygroup": "xinxianyudingaichixia",
//        "trackid": "focus1|21752"
//    },
//    "show_reload": "1",
//    "hide_cart": "0",
//    "trackid": "focus1|21752"

#import <Foundation/Foundation.h>

@interface KTCycleViewModel : NSObject

@property(nonatomic,copy) NSString *img;

+ (instancetype)cycleViewModelWithDict:(NSDictionary*)dict;

@end
