//
//  LoginView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/29.
//  Copyright © 2016年 张增强. All rights reserved.
//登录界面

#import "LoginView.h"

@interface LoginView ()

@property(nonatomic, strong)UIScrollView * bgScrllView;

@property(nonatomic, strong)UIImageView * imageView;

@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * bigTitleLabel;

@property(nonatomic, strong)NSArray * titleArray;
@property(nonatomic, strong)NSArray * bigTitleArray;

@property(nonatomic, strong)UISwipeGestureRecognizer * leftSwip;
@property(nonatomic, strong)UISwipeGestureRecognizer * rightSwip;

@property(nonatomic, strong)NSTimer * timer;

@property(nonatomic, strong)UIButton * sina;
@property(nonatomic, strong)UIButton * weixinButton;
@property(nonatomic, strong)UIButton * nologinButton;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = @[@"难掩喜悦与期待", @"因为你心为所动", @"只因追寻你所爱", @"做最了解你的人"];
        _bigTitleArray = @[@"闭目", @"睁眼", @"启程", @"我们"];
        [self initForScrollerView];
        [self initForImage];
        [self createSwip];
        [self initForTimer];
        [self initForButton];
    }
    return self;
}

#pragma mark
#pragma mark =========== 轮播图
-(void)initForScrollerView{
    _bgScrllView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _bgScrllView.showsVerticalScrollIndicator = NO;
    _bgScrllView.showsHorizontalScrollIndicator = NO;
    _bgScrllView.pagingEnabled = YES;
    _bgScrllView.bounces = NO;
    [self addSubview:_bgScrllView];
}
#pragma mark
#pragma mark ========== 第三方登录
-(void)initForButton{
    _sina = [UIButton buttonWithType:UIButtonTypeCustom];
    _sina.frame = CGRectMake(0, self.bgScrllView.height-100, (self.bgScrllView.width-2)/2, 40);
    [_sina setTitle:@"微博登录" forState:UIControlStateNormal];
    [_sina setImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
    [_sina setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
    _sina.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    _sina.titleLabel.font = [UIFont systemFontOfSize:16];
    [_sina setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self.bgScrllView addSubview:_sina];
    [_sina addTarget:self action:@selector(weiboLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    _weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _weixinButton.frame = CGRectMake(self.bgScrllView.width/2+1, self.bgScrllView.height-100, (self.bgScrllView.width-2)/2, 40);
    [_weixinButton setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [_weixinButton setTitle:@"微信登录" forState:UIControlStateNormal];
    _weixinButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_weixinButton setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
    _weixinButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    [_weixinButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self.bgScrllView addSubview:_weixinButton];
    [_weixinButton addTarget:self action:@selector(weixinLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    _nologinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nologinButton.frame = CGRectMake(0, self.bgScrllView.height-60, self.bgScrllView.width, 35);
    [_nologinButton setTitle:@"暂不登录，随便逛逛" forState:UIControlStateNormal];
    _nologinButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_nologinButton setTitleColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0] forState:UIControlStateHighlighted];
    [self.bgScrllView addSubview:_nologinButton];
    [_nologinButton addTarget:self action:@selector(nologinAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)weiboLogin:(UIButton *)button{
//    微博登录
    
}
-(void)weixinLogin:(UIButton *)button{
//    微信登录
    
}
-(void)nologinAction:(UIButton *)button{
//    不登录
//    跳转到用户设置页面
    UserFirstSettingViewController * userFirstSettingView = [[UserFirstSettingViewController alloc] init];
    self.jumpToMain(userFirstSettingView);
}

#pragma mark
#pragma mark ======== 显示的图片
-(void)initForImage{
//创建图片
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = self.bgScrllView.bounds;
        self.imageView.userInteractionEnabled = YES;
        self.imageView.alpha = 0;
        self.imageView.tag = 100+i;
        self.imageView.image = [UIImage imageNamed:@(i+1).stringValue];
        [self.bgScrllView addSubview:self.imageView];
        
        self.bigTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgScrllView.width/5*1.7, self.bgScrllView.height/2-20, self.bgScrllView.width/5, 30)];
        self.bigTitleLabel.text = _bigTitleArray[i];
        self.bigTitleLabel.textColor = [UIColor whiteColor];
        self.bigTitleLabel.font = [UIFont systemFontOfSize:25];
        self.bigTitleLabel.alpha = 0;
        self.bigTitleLabel.tag = 200+i;
        [self.bgScrllView addSubview:_bigTitleLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bgScrllView.width/5*1.7, self.bgScrllView.height/2+10, self.bgScrllView.width/2, 25)];
        self.titleLabel.text = self.titleArray[i];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.tag = 300+i;
        self.titleLabel.alpha = 0;
        [self.bgScrllView addSubview:_titleLabel];
    }
}
#pragma mark
#pragma mark ============= 滑动手势
-(void)createSwip{
//滑动手势
    self.imageView = [self viewWithTag:100];
    self.imageView.alpha = 1;
    self.bigTitleLabel = [self viewWithTag:200];
    self.bigTitleLabel.alpha = 1;
    self.titleLabel = [self viewWithTag:300];
    self.titleLabel.alpha = 1;
    
    _leftSwip = [[UISwipeGestureRecognizer alloc] init];
    _leftSwip.direction = UISwipeGestureRecognizerDirectionLeft;
    _leftSwip.numberOfTouchesRequired = 1;
    [_leftSwip addTarget:self action:@selector(swipOnLeft:)];
    [self.imageView addGestureRecognizer:_leftSwip];
    
    _rightSwip = [[UISwipeGestureRecognizer alloc] init];
    _rightSwip.direction =  UISwipeGestureRecognizerDirectionRight;
    _rightSwip.numberOfTouchesRequired = 1;
    [_rightSwip addTarget:self action:@selector(swipOnRight:)];
    [self.imageView addGestureRecognizer:_rightSwip];
}
//左滑
-(void)swipOnLeft:(UISwipeGestureRecognizer *)swip{
    NSInteger index = swip.view.tag;
    if (swip.view.tag == 103) {
        [self setImageLeftAnimate:103 newTagNum:100 scale:1.5];
    }else{
        [self setImageLeftAnimate:index scale:1.5];
    }
}
//右滑
-(void)swipOnRight:(UISwipeGestureRecognizer *)swip{
    NSInteger index = swip.view.tag;
    if (swip.view.tag == 100) {
        [self setImageRightAnimate:100 newTagNum:103 scale:0.8];
    }else{
        [self setImageRightAnimate:index scale:0.8];
    }
}
//添加手势
-(void)addSwipView:(UIImageView *)imageView{
    [imageView addGestureRecognizer:_leftSwip];
    [imageView addGestureRecognizer:_rightSwip];
}

#pragma mark
#pragma mark ========= 定时器，自己动
//定时器
-(void)initForTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(changPic) userInfo:nil repeats:YES];
}
//定时器滑动
-(void)changPic{
    NSInteger index = self.imageView.tag;
    if (self.imageView.tag == 103) {
        [self setImageLeftAnimate:103 newTagNum:100 scale:1.5];
    }else{
        [self setImageLeftAnimate:index scale:1.5];
    }
}

#pragma mark 
#pragma mark =========== 封装了改变图片的方式
//一般向左滑
-(void)setImageLeftAnimate:(NSInteger)tagNum scale:(float)scaleValue{
    [UIView animateWithDuration:0.7 animations:^{
        self.imageView.alpha = 0;
        self.imageView.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
        self.imageView = [self viewWithTag:tagNum+1];
        self.imageView.alpha = 1;
    }];
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    self.imageView.frame = CGRectMake(0, 0, self.bgScrllView.width, self.bgScrllView.height);
    [self addSwipView:self.imageView];
    
    self.bigTitleLabel.alpha = 0;
    self.bigTitleLabel = [self viewWithTag:100+tagNum+1];
    self.bigTitleLabel.alpha = 1;
    
    self.titleLabel.alpha = 0;
    self.titleLabel = [self viewWithTag:200+tagNum+1];
    self.titleLabel.alpha = 1;
}
//特殊的向左滑
-(void)setImageLeftAnimate:(NSInteger)tagNum newTagNum:(NSInteger)newTagNum scale:(float)scaleValue{
    [UIView animateWithDuration:0.7 animations:^{
        self.imageView.alpha = 0;
        self.imageView.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
        self.imageView = [self viewWithTag:newTagNum];
        self.imageView.alpha = 1;
    }];
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    self.imageView.frame = CGRectMake(0, 0, self.bgScrllView.width, self.bgScrllView.height);
    [self addSwipView:self.imageView];
    
    self.bigTitleLabel.tag = 100+tagNum;
    self.bigTitleLabel.alpha = 0;
    self.bigTitleLabel = [self viewWithTag:100+newTagNum];
    self.bigTitleLabel.alpha = 1;
    
    self.titleLabel.tag = 200+tagNum;
    self.titleLabel.alpha = 0;
    self.titleLabel = [self viewWithTag:200+newTagNum];
    self.titleLabel.alpha = 1;
}
//一般向右滑
-(void)setImageRightAnimate:(NSInteger)tagNum scale:(float)scaleValue{
    float marginLeft = self.bgScrllView.width/4;
    float marginTop = self.bgScrllView.height/4;
    self.imageView = [self viewWithTag:tagNum-1];
    self.imageView.frame = CGRectMake(-marginLeft, -marginTop, self.bgScrllView.width+2*marginLeft, self.bgScrllView.height+2*marginTop);
    [UIView animateWithDuration:0.7 animations:^{
        self.imageView = [self viewWithTag:tagNum];
        self.imageView.alpha = 0;
        self.imageView = [self viewWithTag:tagNum-1];
        self.imageView.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
        self.imageView.alpha = 1;
        [self addSwipView:self.imageView];
    }];
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    self.imageView.frame = CGRectMake(0, 0, self.bgScrllView.width, self.bgScrllView.height);
    
    self.bigTitleLabel.alpha = 0;
    self.bigTitleLabel = [self viewWithTag:100+tagNum-1];
    self.bigTitleLabel.alpha = 1;
    
    self.titleLabel.alpha = 0;
    self.titleLabel = [self viewWithTag:200+tagNum-1];
    self.titleLabel.alpha = 1;

}
//特殊向右滑
-(void)setImageRightAnimate:(NSInteger)tagNum newTagNum:(NSInteger)newTagNum scale:(float)scaleValue{
    float marginLeft = self.bgScrllView.width/4;
    float marginTop = self.bgScrllView.height/4;
    self.imageView = [self viewWithTag:newTagNum];
    self.imageView.frame = CGRectMake(-marginLeft, -marginTop, self.bgScrllView.width+2*marginLeft, self.bgScrllView.height+2*marginTop);
    [UIView animateWithDuration:0.7 animations:^{
        self.imageView = [self viewWithTag:tagNum];
        self.imageView.alpha = 0;
        self.imageView = [self viewWithTag:newTagNum];
        self.imageView.alpha = 1;
        self.imageView.transform = CGAffineTransformMakeScale(scaleValue, scaleValue);
    }];
    [self addSwipView:self.imageView];
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    self.imageView.frame = CGRectMake(0, 0, self.bgScrllView.width, self.bgScrllView.height);
    
    self.bigTitleLabel.tag = 100+tagNum;
    self.bigTitleLabel.alpha = 0;
    self.bigTitleLabel = [self viewWithTag:100+newTagNum];
    self.bigTitleLabel.alpha = 1;
    
    self.titleLabel.tag = 200+tagNum;
    self.titleLabel.alpha = 0;
    self.titleLabel = [self viewWithTag:200+newTagNum];
    self.titleLabel.alpha = 1;
}
@end
