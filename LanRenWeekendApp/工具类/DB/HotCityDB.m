//
//  HotCity.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/1.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "HotCityDB.h"
#import <FMDB.h>

static FMDatabaseQueue * queue = nil;
@implementation HotCityDB : NSObject 

+ (void)initialize
{
    NSString * filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"t_hotCity.sqlite"];
    ZZQLog(@"%@", filePath);
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * createSql = @"CREATE TABLE if not exists t_hotCity (cityID INTEGER PRIMARY KEY AUTOINCREMENT, cityName TEXT UNIQUE, city_id TEXT)";
        BOOL result = [db executeUpdate:createSql];
        if (result) {
            ZZQLog(@"热门城市创建成功");
        }else{
            ZZQLog(@"热门城市创建失败");
        }
    }];
}
+(void)addLocation:(NSString *)cityName city_id:(NSInteger)city_id{
    [queue inDatabase:^(FMDatabase *db) {
        NSString * insertSql = @"INSERT INTO t_hotCity(cityName, city_id) VALUES(?, ?)";
        BOOL result = [db executeUpdate:insertSql, cityName, @(city_id).stringValue];
        if (result) {
            ZZQLog(@"插入热门城市成功");
        }else{
            ZZQLog(@"插入热门城市失败");
        }
    }];
}
+(void)deleteLocation{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * deleSQL = @"DELETE FROM t_hotCity WHERE cityID = (select min(cityID) from t_hotCity)";
        BOOL result = [db executeUpdate:deleSQL];
        if (result) {
            ZZQLog(@"热门城市删除成功");
        }else{
            ZZQLog(@"热门城市删除失败");
        }
    }];
}
+(void)deleteAllLocation{
    [queue inDatabase:^(FMDatabase *db) {
        NSString * deleSQL = @"DELETE FROM t_hotCity";
        BOOL result = [db executeUpdate:deleSQL];
        if (result) {
            ZZQLog(@"热门城市删除成功");
        }else{
            ZZQLog(@"热门城市删除失败");
        }
    }];
}

+(BOOL)isExistsCity:(NSString *)cityName{
    __block int flag = 0;
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querySql = @"SELECT * FROM t_hotCity WHERE cityName=?";
        FMResultSet * set = [db executeQuery:querySql, cityName];
        while(set.next) {
            flag++;
        }
        [set close];
    }];
    if (flag > 0) {
        return YES;
    }else{
        return NO;
    }
}

+(NSArray<HotCity *> *)queryLocation{
    NSMutableArray<HotCity *> * array = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querySql = @"SELECT * FROM t_hotCity";
        FMResultSet * set = [db executeQuery:querySql];
        while(set.next) {
            HotCity * cityLocation = [[HotCity alloc] init];
            cityLocation.hotCityName = [set stringForColumn:@"cityName"];
            cityLocation.city_id = [set stringForColumn:@"city_id"];
            [array addObject:cityLocation];
        }
        [set close];
    }];
    return array;
}

+(NSString *)queryLocationByCityName:(NSString *)cityName{
    __block NSString * cityId;
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querySql = @"SELECT * FROM t_hotCity WHERE cityName=?";
        FMResultSet * set = [db executeQuery:querySql, cityName];
        while(set.next) {
            HotCity * cityLocation = [[HotCity alloc] init];
            cityLocation.city_id = [set stringForColumn:@"city_id"];
            cityId = cityLocation.city_id;
        }
        [set close];
    }];
    return cityId;
}

@end
