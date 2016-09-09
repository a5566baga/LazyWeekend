//
//  TalkMessageModel.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TalkMessageModel.h"

@implementation TalkMessageModel

-(float)cellHeight{
    CGSize size = CGSizeMake(([UIScreen mainScreen].bounds.size.width-20)/2, MAXFLOAT);
    CGFloat height = [self.requirement_text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height;
    return height + 60;
}

@end
