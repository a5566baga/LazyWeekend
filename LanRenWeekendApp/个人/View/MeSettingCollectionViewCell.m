//
//  MeSettingCollectionViewCell.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MeSettingCollectionViewCell.h"

@interface MeSettingCollectionViewCell ()

@property(nonatomic, strong)UIImageView * picView;
@property(nonatomic, strong)UILabel * titleLable;
@property(nonatomic, strong)UILabel * nameLabel;

@end

@implementation MeSettingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

#pragma mark
#pragma mark =========== 部署cell界面
-(void)initForView{
    _picView = [[UIImageView alloc] init];
    _picView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_picView];
    
    _titleLable = [[UILabel alloc] init];
    _titleLable.font = [UIFont systemFontOfSize:15];
    _titleLable.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    _titleLable.numberOfLines = 2;
    [self addSubview:_titleLable];
    _titleLable.text = @"不知道的不知道的不知道的不知道的不知道的不知道的不知道的不知道的不知道的";
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    _nameLabel.numberOfLines = 1;
    [self addSubview:_nameLabel];
    _nameLabel.text = @"不知道的不知道的";
}

-(void)layoutSubviews{
    _picView.frame = CGRectMake(0, 0, self.width, self.width);
    
    float height = (self.height-self.width)/3;
    _titleLable.frame = CGRectMake(0, CGRectGetMaxY(_picView.frame), self.width, height*2);
    
    _nameLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLable.frame), self.width, height);
    
}

-(void)setCellStyle:(NSString *)title name:(NSString *)name pic:(NSString *)pic{
    _titleLable.text = title;
    _nameLabel.text = name;
    _picView.image = [UIImage imageNamed:pic];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    NSLog(@"个人页的cell");
}

@end
