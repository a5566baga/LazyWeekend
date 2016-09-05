//
//  CustomTabBar.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar

-(void)layoutSubviews{
    [super layoutSubviews];
    float width = (self.width-4)/5;
    float hight = 48;
    int i = 0;
    for (UIView * view in [self subviews]) {
        if ([view isKindOfClass:[UIControl class]]) {
            if (i < 3) {
                view.frame = CGRectMake(2+width*i, 5, width, hight);
            }else{
                i++;
                view.frame = CGRectMake(2+width*i, 5, width, hight);
            }
            i++;
        }
    }
}
@end
