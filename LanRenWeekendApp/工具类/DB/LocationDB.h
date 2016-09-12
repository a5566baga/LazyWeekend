//
//  LocationDB.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityLocation.h"

@interface LocationDB : NSObject

/**
 *  存储本地地理信息
 *
 *  @param cityName 地理名字
 *  @param lon      经度
 *  @param lat      维度
 */
+(void)addLocation:(NSString * )cityName lon:(float)lon lat:(float)lat;

/**
 *  删除位置
 */
+(void)deleteLocation;

/**
 *  查询地理位置
 */
+(NSArray<CityLocation *> *)queryLocation;

@end
