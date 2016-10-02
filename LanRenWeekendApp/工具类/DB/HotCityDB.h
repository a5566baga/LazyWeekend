//
//  HotCity.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/1.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotCity.h"

@interface HotCityDB : NSObject

/**
 *  存储本地地理信息
 *
 *  @param cityName 地理名字
 *  @param lon      经度
 *  @param lat      维度
 */
+(void)addLocation:(NSString * )cityName city_id:(NSInteger)city_id;

/**
 *  删除位置
 */
+(void)deleteLocation;
+(void)deleteAllLocation;

/**
 数据库中是否存在城市
 */
+(BOOL)isExistsCity:(NSString *)cityName;

/**
 *  查询地理位置
 */
+(NSArray<HotCity *> *)queryLocation;
+(NSString*)queryLocationByCityName:(NSString *)cityName;

@end
