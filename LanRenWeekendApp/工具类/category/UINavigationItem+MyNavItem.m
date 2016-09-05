//
//  UINavigationItem+MyNavItem.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UINavigationItem+MyNavItem.h"

@implementation UINavigationItem (MyNavItem)

+(UIView *)setTitleViewWithTitle:(NSString *)title font:(UIFont *)font{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //    中间标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.font = font;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    return titleLabel;
}

@end
