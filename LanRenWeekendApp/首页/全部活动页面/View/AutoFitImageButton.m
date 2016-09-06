//
//  AutoFitImageButton.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/6.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AutoFitImageButton.h"

@implementation AutoFitImageButton

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = CGSizeMake(15, 15);
    self.imageView.size = size;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
