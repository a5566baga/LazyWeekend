//
//  BodyCollectionViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/6.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BodyCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface BodyCollectionViewCell ()

@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)UILabel * titleLabel;

@end

@implementation BodyCollectionViewCell

-(void)initForCell{
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(25, 25, 30, 30);
    _titleLabel.frame = CGRectMake(65, 20, self.width-65, 40);
}

-(void)cellSetStyle:(NSString *)title image:(NSString *)imageStr{
    [self initForCell];
    _titleLabel.text = title;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}

@end
