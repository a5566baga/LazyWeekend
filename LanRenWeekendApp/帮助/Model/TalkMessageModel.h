//
//  TalkMessageModel.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkMessageModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, copy) NSString *requirement_text;

@property (nonatomic, assign) NSInteger rid;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, strong) NSArray *result_list;

@property(nonatomic, assign) float cellHeight;

@end
