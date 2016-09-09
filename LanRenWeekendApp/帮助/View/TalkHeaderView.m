//
//  TalkHeaderView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TalkHeaderView.h"

@interface TalkHeaderView ()

@property(nonatomic, strong)UIImageView * iconView;
@property(nonatomic, strong)UIImageView * talkView;
@property(nonatomic, strong)UILabel * mainLabel;
@property(nonatomic, strong)UIImageView * lineImg;
@property(nonatomic, strong)UIImageView * dotImg;
@property(nonatomic, strong)UIImageView * rightLineImg;

@end

@implementation TalkHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

-(void)initForView{
    _iconView = [[UIImageView alloc] init];
    _iconView.image = [UIImage imageNamed:@"cat_me"];
    _iconView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_iconView];
    
    _talkView = [[UIImageView alloc] init];
    _talkView.image = [[UIImage imageNamed:@"rc_left_chat_wind.9"] stretchableImageWithLeftCapWidth:30 topCapHeight:60];
    [self addSubview:_talkView];
    
    _mainLabel = [[UILabel alloc] init];
    _mainLabel.text = @"是不是很难找到适合自己或团队的活动呢？在下方发布一条你想要的周末需求，懒喵助理会为您定制只属于你或团队的美好周末！";
    _mainLabel.numberOfLines = 0;
    _mainLabel.font = [UIFont fontWithName:@"Gotham-Light" size:18];
    _mainLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    [self.talkView addSubview:_mainLabel];
    
    _lineImg = [[UIImageView alloc] init];
    _lineImg.image = [UIImage imageNamed:@"left_line"];
    [self addSubview:_lineImg];
    
    _dotImg = [[UIImageView alloc] init];
    _dotImg.image = [UIImage imageNamed:@"dot"];
    [self addSubview:_dotImg];
    
    _rightLineImg = [[UIImageView alloc] init];
    _rightLineImg.image = [UIImage imageNamed:@"right_line"];
    [self addSubview:_rightLineImg];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _iconView.frame = CGRectMake(20, 20, 50, 50);
    
    CGSize size = CGSizeMake(self.width-70-50-30, MAXFLOAT);
    CGFloat height = [_mainLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size.height;
    _talkView.frame = CGRectMake(75, 20, self.width-70-50, height+10);
    _mainLabel.frame = CGRectMake(20, 5, _talkView.width-30, height);
    
    float lineWidth = (self.width-3)/4;
    _lineImg.frame = CGRectMake(lineWidth, CGRectGetMaxY(_talkView.frame)+20, lineWidth, 1);
    _dotImg.frame = CGRectMake(2*lineWidth, CGRectGetMaxY(_talkView.frame)+20, 3, 3);
    _rightLineImg.frame = CGRectMake(2*lineWidth+3, CGRectGetMaxY(_talkView.frame)+20, lineWidth, 1);
    
}
@end
