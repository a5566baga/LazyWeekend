//
//  LocationDB.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "LocationDB.h"
#import <FMDB.h>


static FMDatabaseQueue * queue = nil;
@implementation LocationDB

+ (void)initialize
{
    NSString * filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"t_cityLocation.sqlite"];
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * createSql = @"CREATE TABLE if not exists t_cityLocation (cityName TEXT, lon real, lat real)";
        BOOL result = [db executeUpdate:createSql];
        if (result) {
            NSLog(@"地理位置表创建成功");
        }else{
            NSLog(@"地理位置表创建失败");
        }
    }];
}

+(void)addLocation:(NSString *)cityName lon:(float)lon lat:(float)lat{
    [queue inDatabase:^(FMDatabase *db) {
        NSString * insertSql = @"INSERT INTO t_cityLocation(cityName, lon, lat) VALUES(?, ?, ?)";
        BOOL result = [db executeUpdate:insertSql, cityName, lon, lat];
        if (result) {
            NSLog(@"插入城市地理位置成功");
        }else{
            NSLog(@"插入城市地理位置失败");
        }
    }];
}

+(void)deleteLocation{
    [queue inDatabase:^(FMDatabase *db) {
        NSString * deleteSql = @"DELETE FROM t_cityLocation";
        BOOL result = [db executeUpdate:deleteSql];
        if (result) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }];
}

+(NSArray<CityLocation *> *)queryLocation{
    NSMutableArray<CityLocation *> * array = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querySql = @"SELETE * FROM t_cityLocation";
        FMResultSet * set = [db executeQuery:querySql];
        if (set.next) {
            CityLocation * cityLocation = [[CityLocation alloc] init];
            cityLocation.cityName = [set stringForColumn:@"cityName"];
            cityLocation.lon = [set doubleForColumn:@"lon"];
            cityLocation.lat = [set doubleForColumn:@"lat"];
            [array addObject:cityLocation];
        }
    }];
    return array;
}

@end
