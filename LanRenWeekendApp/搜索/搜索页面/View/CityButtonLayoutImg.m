//
//  CityButtonLayoutImg.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/6.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "CityButtonLayoutImg.h"

@implementation CityButtonLayoutImg

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = CGRectMake(self.width-20, 15, 15, 20);
    self.imageView.frame = rect;
    
    self.titleLabel.frame = CGRectMake(0, 0, 40, 49);
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
