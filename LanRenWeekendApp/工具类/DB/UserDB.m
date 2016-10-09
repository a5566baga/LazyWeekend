//
//  UserDB.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.

#import "UserDB.h"


@implementation UserDB
static FMDatabaseQueue * queue = nil;

+(void)initialize{
    //确定一个路径
    NSString * filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"t_user.sqlite"];
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * createSql = @"CREATE TABLE if not exists t_user (username TEXT, icon text, sex TEXT,nowstarus TEXT)";
        BOOL result = [db executeUpdate:createSql];
        if (result) {
            ZZQLog(@"创建用户表成功");
        }else{
            ZZQLog(@"创建用户表失败");
        }
    }];
}

+(void)addNewUser:(NSString *)username icon:(NSString *)icon sex:(NSString *)sex nowStatus:(NSString *)nowStaus{
    [queue inDatabase:^(FMDatabase *db) {
        NSString * addSql = @"INSERT INTO t_user(username, icon, sex, nowstarus) VALUES(?, ?, ?, ?) ";
        BOOL result = [db executeUpdate:addSql, username, icon, sex, nowStaus];
        if (result) {
            ZZQLog(@"用户表插入成功");
        }else{
            ZZQLog(@"用户表插入失败");
        }
    }];
}

+(BOOL)queryIsExistUser{
    __block int flag = 0;
    [queue inDatabase:^(FMDatabase *db) {
       NSString * querrySql = @"SELECT * FROM t_user";
        FMResultSet * set = [db executeQuery:querrySql];
        while (set.next) {
            flag++;
        }
        [set close];
    }];
    if (flag != 0) {
        return YES;
    }else
        return NO;
}

+(NSString *)queryUserName{
    __block NSString * userName;
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querrySql = @"SELECT * FROM t_user";
        FMResultSet * set = [db executeQuery:querrySql];
        while (set.next) {
            User * user = [[User alloc] init];
            user.username = [set stringForColumn:@"username"];
            userName = user.username;
        }
        [set close];
    }];
    return  userName;
}

+(NSArray<User *> *)queryUser{
    __block NSMutableArray<User *> * array = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * querrySql = @"SELECT * FROM t_user";
        FMResultSet * set = [db executeQuery:querrySql];
        while(set.next) {
            User * user = [[User alloc] init];
            user.username = [set stringForColumn:@"username"];
            user.sex = [set stringForColumn:@"sex"];
            user.icon = [set stringForColumn:@"icon"];
            user.nowStatus = [set stringForColumn:@"nowstarus"];
            [array addObject:user];
        }
        [set close];
    }];
    return array;
}

+(void)deleteAllUser{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * deleSql = @"DELETE FROM t_user";
        BOOL result = [db executeUpdate:deleSql];
        if (result) {
            ZZQLog(@"删除成功");
        }else{
            ZZQLog(@"删除失败");
        }
    }];
}

@end
