//
//  FavouriteDB.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/12.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "FavouriteDB.h"
#import <FMDB.h>

static FMDatabaseQueue * queue = nil;
@implementation FavouriteDB

+(void)initialize{
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"t_fav.sqlite"];
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * createSql = @"CREATE TABLE if not exists t_fav (leo_id TEXT PRIMARY KEY, pic TEXT, title TEXT, poi_name TEXT)";
        BOOL result = [db executeUpdate:createSql];
        if (result) {
            NSLog(@"创建喜欢的表成功");
        }else{
            NSLog(@"创建喜欢的表失败");
        }
    }];
}

+(void)addFavourite:(NSInteger)leo_id pic:(NSString *)pic title:(NSString *)title poi_name:(NSString *)poi_name{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * insertSql = @"INSERT INTO t_fav(leo_id, pic, title, poi_name) VALUES(?, ?, ?, ?)";
        BOOL result = [db executeUpdate:insertSql, @(leo_id).stringValue, pic, title, poi_name];
        if (result) {
            NSLog(@"最爱内容添加成功");
        }else{
            NSLog(@"最爱内容添加失败");
        }
    }];
}

+(BOOL)isFavourit:(NSInteger)leo_id{
    __block int flag = 0;
    [queue inDatabase:^(FMDatabase *db) {
       NSString * querySql = @"SELECT * FROM t_fav WHERE leo_id = ?";
        FMResultSet * set = [db executeQuery:querySql, leo_id];
        while (set.next) {
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

+(void)deleteFavouriteItem:(NSInteger)leo_id{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * deleteSql = @"DELETE FROM t_fav WHERE leo_id = ?";
        BOOL result = [db executeUpdate:deleteSql, @(leo_id).stringValue];
        if (result) {
            NSLog(@"最爱项目%ld删除成功", leo_id);
        }else{
            NSLog(@"最爱项目%ld删除失败", leo_id);
        }
    }];
}

+(NSArray<Favourtie *> *)queryAllFavourite{
    __block NSMutableArray<Favourtie *> * array = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querySql = @"SELECT * FROM t_fav";
        FMResultSet * set = [db executeQuery:querySql];
        while (set.next) {
            Favourtie * fav = [[Favourtie alloc] init];
            fav.leo_id = [set intForColumn:@"leo_id"];
            fav.poi_name = [set stringForColumn:@"poi_name"];
            fav.pic = [set stringForColumn:@"pic"];
            fav.title = [set stringForColumn:@"title"];
            [array addObject:fav];
        }
        [set close];
    }];
    return array;
}


@end
