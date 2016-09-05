//
//  UIView+MyPositionSize.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MyPositionSize)

//在分类中声明@property，只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量
@property(nonatomic, assign)CGSize size;
@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;
@property(nonatomic, assign)CGFloat x;
@property(nonatomic, assign)CGFloat y;

@end
