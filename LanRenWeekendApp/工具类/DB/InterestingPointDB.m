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
            ZZQLog(@"创建兴趣表成功");
        }else{
            ZZQLog(@"创建兴趣表失败");
        }
    }];
}

+(void)insertNewData:(NSDictionary *)dataDic{
    [queue inDatabase:^(FMDatabase *db) {
       NSString * insertSql = @"INSERT INTO t_interest(mantain, bar, music, stage, pic, eat, bag, movie, person, baskball, leaf, shirt) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        BOOL result = [db executeUpdate:insertSql, dataDic[@"周边游"], dataDic[@"酒吧"], dataDic[@"音乐"], dataDic[@"戏剧"], dataDic[@"展览"], dataDic[@"美食"], dataDic[@"购物"], dataDic[@"电影"], dataDic[@"聚会"], dataDic[@"运动"], dataDic[@"公益"], dataDic[@"商业"]];
        if (result) {
            ZZQLog(@"插入兴趣点内容成功");
        }else{
            ZZQLog(@"插入兴趣点内容失败");
        }
    }];
}

+(void)updateData:(NSDictionary *)dataDic{
    [queue inDatabase:^(FMDatabase *db) {
        NSString * updateSQL1 = @"UPDATE t_interest SET mantain=?";
        [db executeUpdate:updateSQL1, dataDic[@"周边游"]];
        
        NSString * updateSQL2 = @"UPDATE t_interest SET bar=?";
       BOOL result = [db executeUpdate:updateSQL2, dataDic[@"酒吧"]];
        
        NSString * updateSQL3 = @"UPDATE t_interest SET music=?";
        [db executeUpdate:updateSQL3, dataDic[@"音乐"]];
        
        NSString * updateSQL4 = @"UPDATE t_interest SET stage=?";
        [db executeUpdate:updateSQL4, dataDic[@"戏剧"]];
        
        NSString * updateSQL5 = @"UPDATE t_interest SET pic=?";
        [db executeUpdate:updateSQL5, dataDic[@"展览"]];
        
        NSString * updateSQL6 = @"UPDATE t_interest SET eat=?";
        [db executeUpdate:updateSQL6, dataDic[@"美食"]];
        
        NSString * updateSQL7 = @"UPDATE t_interest SET bag=?";
        [db executeUpdate:updateSQL7, dataDic[@"购物"]];
        
        NSString * updateSQL8 = @"UPDATE t_interest SET movie=?";
        [db executeUpdate:updateSQL8, dataDic[@"电影"]];
        
        NSString * updateSQL9 = @"UPDATE t_interest SET person=?";
        [db executeUpdate:updateSQL9, dataDic[@"聚会"]];
        
        NSString * updateSQL10 = @"UPDATE t_interest SET baskball=?";
        [db executeUpdate:updateSQL10, dataDic[@"运动"]];
        
        NSString * updateSQL11 = @"UPDATE t_interest SET leaf=?";
        [db executeUpdate:updateSQL11, dataDic[@"公益"]];
        
        NSString * updateSQL12 = @"UPDATE t_interest SET shirt=?";
        [db executeUpdate:updateSQL12, dataDic[@"商业"]];
        
        if (result) {
            ZZQLog(@"更新兴趣点成功");
        }else{
            ZZQLog(@"更新兴趣点失败");
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
            ZZQLog(@"兴趣表删除成功");
        }else{
            ZZQLog(@"兴趣表删除失败");
        }
    }];
}

@end
