//
//  UIView+MyPositionSize.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UIView+MyPositionSize.h"

@implementation UIView (MyPositionSize)

-(CGSize)size{
    return self.frame.size;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    CGSize size = frame.size;
    size.width = width;
    frame.size = size;
    self.frame = frame;
}

-(CGFloat)height{
    
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    CGSize size = frame.size;
    size.height = height;
    frame.size = size;
    self.frame = frame;
}


-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    CGPoint origin = frame.origin;
    origin.x = x;
    frame.origin = origin;
    self.frame = frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    CGPoint origin = frame.origin;
    origin.y = y;
    frame.origin = origin;
    self.frame = frame;
}

@end
