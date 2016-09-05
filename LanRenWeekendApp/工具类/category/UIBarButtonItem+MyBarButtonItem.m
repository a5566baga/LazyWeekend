//
//  UIBarButtonItem+MyBarButtonItem.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/1.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UIBarButtonItem+MyBarButtonItem.h"

@implementation UIBarButtonItem (MyBarButtonItem)

+(instancetype)itemWithImage:(NSString *)img HightImage:(NSString *)hightImg target:(id)target action:(SEL)action{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn  setBackgroundImage:[UIImage imageNamed:img ] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hightImg] forState:UIControlStateHighlighted];
    btn.size = [btn currentBackgroundImage].size;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[self alloc]initWithCustomView:btn];
}

@end
