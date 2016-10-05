//
//  FavouriteDB.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/12.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Favourtie.h"

@interface FavouriteDB : NSObject

/**
 *  添加最爱信息
 */
+(void)addFavourite:(NSInteger)leo_id pic:(NSString *)pic title:(NSString *)title poi_name:(NSString *)poi_name;

/**
*  删除最爱信息(取消操作)
*/
+(void)deleteFavouriteItem:(NSInteger)leo_id;
+(void)deleteAllFavouriteItem;
/**
*   查询产品是否为最爱的
*/
+(BOOL)isFavourit:(NSInteger)leo_id;
/**
*  查询最爱产品
*/
+(NSArray<Favourtie *> *)queryAllFavourite;

@end
