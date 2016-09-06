//
//  UIImage+LoadImg.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/6.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UIImage+LoadImg.h"

@implementation UIImage (LoadImg)

-(UIImage *)TransformtoSize:(CGSize)Newsize

{
    
    // 创建一个bitmap的context
    
    UIGraphicsBeginImageContext(Newsize);
    
    // 绘制改变大小的图片
    
    [self drawInRect:CGRectMake(0, 0, Newsize.width, Newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage *TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    
    return TransformedImg;
    
}

@end
