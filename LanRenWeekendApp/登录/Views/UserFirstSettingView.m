//
//  UserFirstSettingView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/4.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UserFirstSettingView.h"

#define SEX_KEY @"性别"
#define STATUS_KEY @"当前状态"

@interface UserFirstSettingView ()

@property(nonatomic, strong)UIImageView * userImage;
@property(nonatomic, strong)UILabel * usernameLabel;

@property(nonatomic, strong)UILabel * sexLabel;

@property(nonatomic, strong)UIButton * maleButton;
@property(nonatomic, strong)UIButton * femaleButton;

@property(nonatomic, strong)UILabel * nowstatusLabel;

@property(nonatomic, strong)UIButton * parentButton;
@property(nonatomic, strong)UIButton * marryButton;
@property(nonatomic, strong)UIButton * singleButton;

//把选中的信息存入字典
@property(nonatomic, strong)NSMutableDictionary * mySettingDic;

@end

@implementation UserFirstSettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

#pragma mark
#pragma mark ========== 设置视图控件
-(void)initForView{
    _mySettingDic = [[NSMutableDictionary alloc] init];
    [_mySettingDic setObject:@"未知" forKey:SEX_KEY];
    [_mySettingDic setObject:@"未知" forKey:STATUS_KEY];
    
    _userImage = [[UIImageView alloc] init];
    _userImage.image = [UIImage imageNamed:@"default_avatar"];
    [self addSubview:_userImage];
    
    _usernameLabel = [[UILabel alloc] init];
    _usernameLabel.text = @"匿名用户";
    _usernameLabel.textAlignment = NSTextAlignmentCenter;
    _usernameLabel.textColor = [UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0];
    _usernameLabel.font = [UIFont fontWithName:@"Gotham-Light" size:20];
    [self addSubview:_usernameLabel];
    
    _sexLabel = [[UILabel alloc] init];
    _sexLabel.text = @"性别";
    _sexLabel.font = [UIFont fontWithName:@"Gotham-Light" size:16];
    _sexLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    _sexLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_sexLabel];
    
    _maleButton = [[UIButton alloc] init];
    _maleButton.selected = NO;
    [_maleButton setImage:[UIImage imageNamed:@"male_unchecked"] forState:UIControlStateNormal];
    [_maleButton setAttributedTitle:[self setAttributedString:_maleButton title:@"男"] forState:UIControlStateNormal];
    _maleButton.titleLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
    _maleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [_maleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_maleButton addTarget:self action:@selector(maleOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maleButton];
    
    _femaleButton = [[UIButton alloc] init];
    _femaleButton.selected = NO;
    [_femaleButton setImage:[UIImage imageNamed:@"female_unchecked"] forState:UIControlStateNormal];
    [_femaleButton setAttributedTitle:[self setAttributedString:_femaleButton title:@"女"] forState:UIControlStateNormal];
    _femaleButton.titleLabel.textAlignment = UIControlContentHorizontalAlignmentRight;
    _femaleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [_femaleButton addTarget:self action:@selector(femaleOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_femaleButton];
    
    _nowstatusLabel = [[UILabel alloc] init];
    _nowstatusLabel.text = @"当前状态";
    _nowstatusLabel.font = [UIFont fontWithName:@"Gotham-Light" size:16];
    _nowstatusLabel.textAlignment = NSTextAlignmentCenter;
    _nowstatusLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    [self addSubview:_nowstatusLabel];
    
    _parentButton = [[UIButton alloc] init];
    _parentButton.selected = NO;
    [_parentButton setImage:[UIImage imageNamed:@"ic_check_uncheck"] forState:UIControlStateNormal];
    [_parentButton setAttributedTitle:[self setAttributedString:_parentButton title:@"为人父母"] forState:UIControlStateNormal];
    _parentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _parentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_parentButton addTarget:self action:@selector(parentedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_parentButton];
    
    _marryButton = [[UIButton alloc] init];
    _marryButton.selected = NO;
    [_marryButton setImage:[UIImage imageNamed:@"ic_check_uncheck"] forState:UIControlStateNormal];
    [_marryButton setAttributedTitle:[self setAttributedString:_marryButton title:@"恋爱中/已婚"] forState:UIControlStateNormal];
    _marryButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _marryButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_marryButton addTarget:self action:@selector(marryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_marryButton];
    
    _singleButton = [[UIButton alloc] init];
    _singleButton.selected = NO;
    [_singleButton setImage:[UIImage imageNamed:@"ic_check_uncheck"] forState:UIControlStateNormal];
    [_singleButton setAttributedTitle:[self setAttributedString:_singleButton title:@"单身生活"] forState:UIControlStateNormal];
    _singleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _singleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_singleButton addTarget:self action:@selector(singleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_singleButton];
    
}
#pragma mark
#pragma mark =============== Button按钮事件
-(void)maleOnclick:(UIButton *)button{
    button.selected = !button.selected;
    [self buttonSelected:button imageStr:@"male_checked"];
    [self buttonChangSelect:button otherButton:_femaleButton imageStr:@"female_unchecked"];
    [_mySettingDic setObject:button.titleLabel.text forKey:SEX_KEY];
    self.postDic(_mySettingDic);
}
-(void)femaleOnclick:(UIButton *)button{
    button.selected = !button.selected;
    [self buttonSelected:button imageStr:@"female_checked"];
    [self buttonChangSelect:button otherButton:_maleButton imageStr:@"male_unchecked"];
    [_mySettingDic setObject:button.titleLabel.text forKey:SEX_KEY];
    self.postDic(_mySettingDic);
}
-(void)parentedAction:(UIButton *)button{
    button.selected = !button.selected;
    [self buttonSelected:button imageStr:@"ic_check_checked"];
    [self buttonChangSelect:button otherButton:_marryButton imageStr:@"ic_check_uncheck"];
    [self buttonChangSelect:button otherButton:_singleButton imageStr:@"ic_check_uncheck"];
    [_mySettingDic setObject:button.titleLabel.text forKey:STATUS_KEY];
    self.postDic(_mySettingDic);
}
-(void)marryAction:(UIButton *)button{
    button.selected = !button.selected;
    [self buttonSelected:button imageStr:@"ic_check_checked"];
    [self buttonChangSelect:button otherButton:_parentButton imageStr:@"ic_check_uncheck"];
    [self buttonChangSelect:button otherButton:_singleButton imageStr:@"ic_check_uncheck"];
    [_mySettingDic setObject:button.titleLabel.text forKey:STATUS_KEY];
    self.postDic(_mySettingDic);
}
-(void)singleAction:(UIButton *)button{
    button.selected = !button.selected;
    [self buttonSelected:button imageStr:@"ic_check_checked"];
    [self buttonChangSelect:button otherButton:_parentButton imageStr:@"ic_check_uncheck"];
    [self buttonChangSelect:button otherButton:_marryButton imageStr:@"ic_check_uncheck"];
    [_mySettingDic setObject:button.titleLabel.text forKey:STATUS_KEY];
    self.postDic(_mySettingDic);
}
//选中当前button
-(void)buttonSelected:(UIButton *)button imageStr:(NSString *)imageStr{
    if (button.selected) {
        [self setButtonAnimate:button];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateSelected];
    }
    button.selected = YES;
    button.userInteractionEnabled = NO;
}
//button选中状态变化
-(void)buttonChangSelect:(UIButton *)nowButton otherButton:(UIButton *)otherButton imageStr:(NSString *)imageStr{
    otherButton.userInteractionEnabled = YES;
    otherButton.selected = NO;
    [otherButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
}
//选中button的变化动画
-(void)setButtonAnimate:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        button.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        button.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
//设置字体
-(NSAttributedString *)setAttributedString:(UIButton *)button title:(NSString *)title{
    NSAttributedString * string = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light" size:18]}];
    return string;
}
#pragma mark
#pragma mark ========== 设置控件的大小位置
-(void)layoutSubviews{
    [super layoutSubviews];
    self.postDic(_mySettingDic);
    float margin = 10;
    float leftMargin = self.width/3;
    float topMagin = self.height/13;
    float iconWidth = leftMargin-2*margin;
    _userImage.frame = CGRectMake(leftMargin+margin, topMagin, iconWidth, iconWidth);
    
    _usernameLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_userImage.frame)+1.5*margin, leftMargin, 30);
    _sexLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_usernameLabel.frame)+1.5*margin, leftMargin, 15);
    
    _maleButton.frame = CGRectMake(leftMargin, CGRectGetMaxY(_sexLabel.frame)+1.5*margin, leftMargin/2, 25);
    
    _femaleButton.frame = CGRectMake(1.5*leftMargin, CGRectGetMaxY(_sexLabel.frame)+1.5*margin, leftMargin/2, 25);
    
    _nowstatusLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(_femaleButton.frame)+2*margin, leftMargin, 15);
    
    _parentButton.frame = CGRectMake(leftMargin+margin, CGRectGetMaxY(_nowstatusLabel.frame)+1.5*margin, leftMargin, 25);
    
    _marryButton.frame = CGRectMake(leftMargin+margin, CGRectGetMaxY(_parentButton.frame)+1.5*margin, leftMargin+2*margin, 25);
    
    _singleButton.frame = CGRectMake(leftMargin+margin, CGRectGetMaxY(_marryButton.frame)+1.5*margin, leftMargin, 25);
}

@end
