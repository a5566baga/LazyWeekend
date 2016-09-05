//
//  UIBarButtonItem+MyBarButtonItem.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/1.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MyBarButtonItem)

+(instancetype)itemWithImage:(NSString*)img HightImage:(NSString*)hightImg target:(id)target  action:(SEL)action;

@end
