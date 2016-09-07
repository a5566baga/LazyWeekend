//
//  SearchTypeModel.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTypeModel : NSObject

@property (nonatomic, strong) NSArray *children;

//@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *cn_name;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon_view;

@property (nonatomic, copy) NSString *icon_pressed;

@end
