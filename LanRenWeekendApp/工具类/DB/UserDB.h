//
//  UserDB.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "User.h"

@interface UserDB : NSObject

/**
 * 查询是否存在用户
 */
+(BOOL)queryIsExistUser;

+(NSString *)queryUserName;

/**  
 * 添加用户
 */
+(void)addNewUser:(NSString *)username icon:(NSString *)icon sex:(NSString *)sex nowStatus:(NSString *)nowStaus;

/**
 *  读取用户信息
 */
+(NSArray<User *> *)queryUser;

/**
 *  删除表内容
 */
+(void)deleteAllUser;


@end
