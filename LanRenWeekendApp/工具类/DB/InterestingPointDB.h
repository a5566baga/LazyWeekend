//
//  InterestingPointDB.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interest.h"
@interface InterestingPointDB : NSObject

/**
 *  插入数据
 */
+(void)insertNewData:(NSDictionary *)dataDic;
/**
*   更新数据
*/
+(void)updateData:(NSDictionary *)dataDic;
/**
 *  查询数据
 */
+(NSArray<Interest *> *)queryAllData;
/**
 *  删除数据
 */
+(void)deleteAllData;

@end
