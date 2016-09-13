//
//  InterestingPointDB.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "InterestingPointDB.h"
#import <FMDB.h>

static FMDatabaseQueue * queue = nil;
@implementation InterestingPointDB

+(void)initialize{
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"t_interest.sqlite"];
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    [queue inDatabase:^(FMDatabase *db) {
        NSString * createSql = @"CREATE TABLE if not exists t_interest (mantain integer, bar integer, music integer, stage integer, pic integer, eat integer, bag integer, movie integer, person integer, baskball integer, leaf integer, shirt integer)";
        BOOL result = [db executeUpdate:createSql];
        if (result) {
            NSLog(@"创建兴趣表成功");
        }else{
            NSLog(@"创建兴趣表失败");
        }
    }];
}

+(void)insertNewData:(NSDictionary *)dataDic{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * insertSql = @"INSERT INTO t_interest(mantain, bar, music, stage, pic, eat, bag, movie, person, baskball, leaf, shirt) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        BOOL result = [db executeUpdate:insertSql, dataDic[@"周边游"], dataDic[@"酒吧"], dataDic[@"音乐"], dataDic[@"戏剧"], dataDic[@"展览"], dataDic[@"美食"], dataDic[@"购物"], dataDic[@"电影"], dataDic[@"聚会"], dataDic[@"运动"], dataDic[@"公益"], dataDic[@"商业"]];
        if (result) {
            NSLog(@"插入兴趣点内容成功");
        }else{
            NSLog(@"插入兴趣点内容失败");
        }
    }];
}

+(void)updateData:(NSDictionary *)dataDic{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * updateSql = @"UPDATE t_interest SET mantain=?, bar=?, music=?, stage=?, pic=?, eat=?, bag=?, movie=?, person=?, basketball=?, leaf=?, shirt=?";
        BOOL result = [db executeUpdate:updateSql, dataDic[@"周边游"], dataDic[@"酒吧"], dataDic[@"音乐"], dataDic[@"戏剧"], dataDic[@"展览"], dataDic[@"美食"], dataDic[@"购物"], dataDic[@"电影"], dataDic[@"聚会"], dataDic[@"运动"], dataDic[@"公益"], dataDic[@"商业"]];
        if (result) {
            NSLog(@"更新兴趣点成功");
        }else{
            NSLog(@"更新兴趣点失败");
        }
    }];
}

+(NSArray<Interest *> *)queryAllData{
    __block NSMutableArray * array = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
       NSString * querySql = @"SELECT * FROM t_interest";
        FMResultSet * set = [db executeQuery:querySql];
        while (set.next) {
            Interest * inter = [[Interest alloc] init];
            inter.mantain =  [set intForColumn:@"mantain"];
            inter.bar = [set intForColumn:@"bar"];
            inter.music = [set intForColumn:@"music"];
            inter.stage = [set intForColumn:@"stage"];
            inter.pic = [set intForColumn:@"pic"];
            inter.eat = [set intForColumn:@"eat"];
            inter.bag = [set intForColumn:@"bag"];
            inter.movie = [set intForColumn:@"movie"];
            inter.person = [set intForColumn:@"person"];
            inter.baskball = [set intForColumn:@"baskball"];
            inter.leaf = [set intForColumn:@"leaf"];
            inter.shirt = [set intForColumn:@"shirt"];
            [array addObject:inter];
        }
        [set close];
    }];
    return array;
}

+(void)deleteAllData{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * deleteSql = @"DELETE FROM t_interest";
        BOOL result = [db executeUpdate:deleteSql];
        if (result) {
            NSLog(@"兴趣表删除成功");
        }else{
            NSLog(@"兴趣表删除失败");
        }
    }];
}

@end
