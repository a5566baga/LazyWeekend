//
//  SettingDetailTableViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SettingDetailTableViewCell.h"

@interface SettingDetailTableViewCell ()

@property(nonatomic, strong)UIImageView * icnoImg;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * lineLabel;

@end

@implementation SettingDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initForCell];
    }
    return self;
}

#pragma mark
#pragma mark ======= 设计页面
-(void)initForCell{
    _icnoImg = [[UIImageView alloc] init];
    _icnoImg.userInteractionEnabled = YES;
    [self addSubview:_icnoImg];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithRed:0.502 green:0.502 blue:0.502 alpha:1.0];
    _titleLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:20];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _lineLabel = [[UILabel alloc] init];
    _lineLabel.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    [self addSubview:_lineLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    float leftMargin = 15;
    float topMargin = 10;
    _icnoImg.frame = CGRectMake(leftMargin, topMargin, 30, 30);
    _titleLabel.frame = CGRectMake(2*leftMargin + 30, 0, self.width/2, self.height);
    _lineLabel.frame = CGRectMake(2*leftMargin+30, self.height-1, self.width-2*leftMargin-30, 1);
}

-(void)setCellTitle:(NSString *)title img:(NSString *)imgStr{
    self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    _titleLabel.text = title;
    _icnoImg.image = [UIImage imageNamed:imgStr];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.backgroundColor = selected ? [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:0.70] : [UIColor whiteColor];
}

@end
