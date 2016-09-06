//
//  AllActiviteModel.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Time;
@interface AllActiviteModel : NSObject


@property (nonatomic, copy) NSString *poi_name;

@property (nonatomic, assign) NSInteger collected_num;

@property (nonatomic, copy) NSString *time_desc;

@property (nonatomic, strong) Time *time;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL show_free;

@property (nonatomic, assign) NSInteger want_status;

@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, copy) NSString *consult_phone;

@property (nonatomic, assign) NSInteger sell_status;

@property (nonatomic, strong) NSArray<NSString *> *front_cover_image_list;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *time_info;

@property (nonatomic, copy) NSString *poi;

@property (nonatomic, copy) NSString *jump_type;

@property (nonatomic, copy) NSString *price_info;

@property (nonatomic, assign) NSInteger distance;

@property (nonatomic, assign) NSInteger viewed_num;

@property (nonatomic, copy) NSString *biz_phone;

@property (nonatomic, copy) NSString *item_type;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger leo_id;

@property (nonatomic, copy) NSString *jump_data;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger category_id;


@end
@interface Time : NSObject

@property (nonatomic, copy) NSString *start;

@property (nonatomic, copy) NSString *end;

@end

