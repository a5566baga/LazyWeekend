//
//  MeSettingHeaderView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MeSettingHeaderView.h"
#import "SettingButton.h"

@interface MeSettingHeaderView ()

@property(nonatomic, strong)UIImageView * bgImageView;
@property(nonatomic, strong)UIImageView * bgMaskView;
@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UIButton * iconButton;
@property(nonatomic, strong)SettingButton * preButton;
@property(nonatomic, strong)SettingButton * interestButton;
@property(nonatomic, strong)SettingButton * settingButton;
@property(nonatomic, strong)UIImageView * oneLineImg;
@property(nonatomic, strong)UIImageView * twoLineImg;

@property(nonatomic, strong)UIImageView * leftImg;
@property(nonatomic, strong)UILabel * myActivityLabel;
@property(nonatomic, strong)UILabel * downLineLabel;

@property(nonatomic, strong)SettingViewController * settingVC;
@property(nonatomic, strong)InterestPointViewController * interestVC;
@property(nonatomic, strong)ReserveViewController * reserveVC;

@end

@implementation MeSettingHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForView];
    }
    return self;
}

#pragma mark
#pragma mark ========== 初始化页面
-(void)initForView{
    _bgMaskView = [[UIImageView alloc] init];
    _bgMaskView.image = [UIImage imageNamed:@"mask"];
    _bgMaskView.userInteractionEnabled = YES;
    [self addSubview:_bgMaskView];

    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.image = [UIImage imageNamed:@"person_bg_login"];
    _bgImageView.userInteractionEnabled = YES;
    [self.bgMaskView addSubview:_bgImageView];
    
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    _titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgImageView addSubview:_titleLabel];
    
    _iconButton = [[UIButton alloc] init];
    [_iconButton setBackgroundImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    [_iconButton setBackgroundImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateHighlighted];
    _iconButton.layer.borderColor = [UIColor blackColor].CGColor;
    _iconButton.layer.borderWidth = 1;
    [_iconButton setBackgroundColor:[UIColor whiteColor]];
    _iconButton.clipsToBounds = YES;
    [self addSubview:_iconButton];
    [_iconButton addTarget:self action:@selector(userLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _preButton = [[SettingButton alloc] init];
    NSAttributedString * stringPre = [[NSAttributedString alloc] initWithString:@"我预定的" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light" size:20], NSForegroundColorAttributeName:[UIColor grayColor]}];
    [_preButton setAttributedTitle:stringPre forState:UIControlStateNormal];
    [_preButton setImage:[UIImage imageNamed:@"ic_person_order"] forState:UIControlStateNormal];
    _preButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_preButton];
    [_preButton addTarget:self action:@selector(reserveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _interestButton = [[SettingButton alloc] init];
    NSAttributedString * stringInter = [[NSAttributedString alloc] initWithString:@"兴趣标签" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light" size:20], NSForegroundColorAttributeName:[UIColor grayColor]}];
    [_interestButton setAttributedTitle:stringInter forState:UIControlStateNormal];
    [_interestButton setImage:[UIImage imageNamed:@"ic_person_interest"] forState:UIControlStateNormal];
    _interestButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_interestButton];
    [_interestButton addTarget:self action:@selector(interestAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _settingButton = [[SettingButton alloc] init];
    [_settingButton setTitle:@"设置" forState:UIControlStateNormal];
    NSAttributedString * stringSetting = [[NSAttributedString alloc] initWithString:@"设置" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light" size:20], NSForegroundColorAttributeName:[UIColor grayColor]}];
    [_settingButton setAttributedTitle:stringSetting forState:UIControlStateNormal];
    [_settingButton setImage:[UIImage imageNamed:@"ic_person_setting"] forState:UIControlStateNormal];
    _settingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_settingButton];
    [_settingButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _oneLineImg = [[UIImageView alloc] init];
    _oneLineImg.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    [self addSubview:_oneLineImg];
    
    _twoLineImg = [[UIImageView alloc] init];
    _twoLineImg.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    [self addSubview:_twoLineImg];
    
    _leftImg = [[UIImageView alloc] init];
    _leftImg.backgroundColor = [UIColor blackColor];
    [self addSubview:_leftImg];
    
    _myActivityLabel = [[UILabel alloc] init];
    _myActivityLabel.textAlignment = NSTextAlignmentLeft;
    _myActivityLabel.text = @"我收藏的活动";
    _myActivityLabel.font = [UIFont systemFontOfSize:24];
    _myActivityLabel.textColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    [self addSubview:_myActivityLabel];
    
    _downLineLabel = [[UILabel alloc] init];
    _downLineLabel.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    [self addSubview:_downLineLabel];
}

-(void)userLoginAction:(UIButton *)button{
    NSLog(@"loginAction");
    if (true) {
//        登录成功，不操作
    }else{
//        未登录出现登录界面
        
    }
}
//预定
-(void)reserveAction:(UIButton *)button{
    NSLog(@"reserve");
    _reserveVC = [[ReserveViewController alloc] init];
    _reserveVC.view.backgroundColor = [UIColor whiteColor];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(jumpToReserveViewController:)]) {
        [self.delegate jumpToReserveViewController:_reserveVC];
    }
}
//兴趣
-(void)interestAction:(UIButton *)button{
    NSLog(@"interest");
    _interestVC = [[InterestPointViewController alloc] init];
    _interestVC.view.backgroundColor = [UIColor whiteColor];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(jumoToInterestViewController:)]){
        [self.delegate jumoToInterestViewController:_interestVC];
    }
}
//设置
-(void)settingAction:(UIButton *)button{
    NSLog(@"setting");
    _settingVC = [[SettingViewController alloc] init];
    _settingVC.view.backgroundColor = [UIColor whiteColor];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(jumpToSettingViewController:)]) {
        [self.delegate jumpToSettingViewController:_settingVC];
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _bgMaskView.frame = CGRectMake(0, 0, self.width, 150);
    
    _bgImageView.frame = CGRectMake(0, 0, self.width, 230);
    
    _titleLabel.frame= CGRectMake(0, 20, self.width, 40);
    
    float centerX = self.width/2;
    float centerY = CGRectGetMaxY(_bgImageView.frame);
    _iconButton.frame = CGRectMake(centerX, centerY, 80, 80);
    _iconButton.center = CGPointMake(centerX, centerY);
    _iconButton.layer.cornerRadius = 40;
    
    float margin = 10;
    float btnWith = (self.width-2*margin-2*2)/3;
    _preButton.frame = CGRectMake(margin, CGRectGetMaxY(_iconButton.frame)+20, btnWith, btnWith);
    _interestButton.frame = CGRectMake(margin+2+btnWith, CGRectGetMaxY(_iconButton.frame)+20, btnWith, btnWith);
    _settingButton.frame = CGRectMake(margin+4+2*btnWith, CGRectGetMaxY(_iconButton.frame)+20, btnWith, btnWith);
    
    _oneLineImg.frame = CGRectMake(margin+btnWith, CGRectGetMaxY(_iconButton.frame)+45, 2, 50);
    
    _twoLineImg.frame = CGRectMake(margin+2*btnWith+2, CGRectGetMaxY(_iconButton.frame)+45, 2, 50);
    
    _leftImg.frame = CGRectMake(margin, CGRectGetMaxY(_preButton.frame), 3, 20);
    
    _myActivityLabel.frame = CGRectMake(2*margin, CGRectGetMaxY(_preButton.frame), 200, 20);
    
    _downLineLabel.frame = CGRectMake(margin, self.height-1, self.width-2*margin, 1);
}

#pragma mark
#pragma mark =========== 从数据库中拿值出来传参
-(void)setMeheaderValue:(NSString *)name icon:(NSData *)iconImg{
    _titleLabel.text = name;
    [_iconButton setBackgroundImage:[UIImage imageWithData:iconImg] forState:UIControlStateNormal];
    [_iconButton setBackgroundImage:[UIImage imageWithData:iconImg] forState:UIControlStateHighlighted];
}

@end
