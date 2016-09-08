//
//  SettingButton.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SettingButton.h"

@implementation SettingButton

-(void)layoutSubviews{
    [super layoutSubviews];
    
    float centX = self.width/2;
    float centY = 20;
    float width = self.width/4;
    self.imageView.frame = CGRectMake(centX-width/2, centY, width, width);
    
    self.titleLabel.frame = CGRectMake(0, 30, self.width, self.height-30);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
