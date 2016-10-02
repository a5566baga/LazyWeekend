//
//  LocationButton.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/11.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "LocationButton.h"

@implementation LocationButton

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize mySize = CGSizeMake(self.width-30, CGFLOAT_MAX);
    CGSize size = [self.titleLabel.text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.height = size.height;
    self.titleLabel.font = [UIFont fontWithName:@"Gotham-Light" size:18];
    self.titleLabel.x = 0;
    self.titleLabel.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.width = self.width-30;
    self.titleLabel.numberOfLines = 0;
    
    self.imageView.x = self.width-20;
}

@end
