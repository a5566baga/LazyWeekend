//
//  ChangeCityTableViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ChangeCityTableViewCell.h"

@implementation ChangeCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForCell];
    }
    return self;
}
#pragma mark
#pragma mark ======== 创建cell的视图
-(void)initForCell{
    
}
-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = 10;
    frame.size.width = frame.size.width - 40;
    
    [super setFrame:frame];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
