//
//  UserFirstSettingViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UserFirstSettingViewController.h"
#import "UserSecondSettingViewController.h"
#import "UserFirstSettingView.h"

@interface UserFirstSettingViewController ()

@property(nonatomic, strong)UserFirstSettingView * firstView;
@property(nonatomic, strong)NSMutableDictionary * mySettingDic;

@property(nonatomic, copy)NSString * sex;
@property(nonatomic, copy)NSString * status;

@end

@implementation UserFirstSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
//    设置标题
    [self initForTitleView];
//    设置页面
//    [self initForView];
}
#pragma mark
#pragma mark ========== 设置navigationBar样式
-(void)initForTitleView{
//    中间标题
    self.navigationItem.titleView = [UINavigationItem setTitleViewWithTitle:@"设置个人资料" font:[UIFont fontWithName:@"Gotham-Light" size:17]];
//    返回按钮
    UIBarButtonItem * backItem = [UIBarButtonItem itemWithImage:@"ic_nav_left" HightImage:@"ic_nav_left_white" target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backItem;
//    下一级按钮
    UIBarButtonItem * nextItem = [UIBarButtonItem itemWithImage:@"ic_nav_right" HightImage:@"ic_nav_right_white" target:self action:@selector(nextButtonAction:)];
    self.navigationItem.rightBarButtonItem = nextItem;
}
-(void)backButtonAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)nextButtonAction:(UIButton *)button{
//    NSLog(@"%@", _mySettingDic);
//    回调字典
    NSString * sexStr = _mySettingDic[@"性别"];
    NSString * nowstatusStr = _mySettingDic[@"当前状态"];
    if (![sexStr isEqualToString:@"未知"] && ![nowstatusStr isEqualToString:@"未知"]) {
#warning DB Save
//        写入数据库
        [UserDB addNewUser:@"匿名用户" icon:@"" sex:sexStr nowStatus:nowstatusStr];
//        视图跳转
        UserSecondSettingViewController * secondVC = [[UserSecondSettingViewController alloc] init];
        [self.navigationController pushViewController:secondVC animated:YES];
    }else{
        NSLog(@"信息填写不完全");
        UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width/3, self.view.height, self.view.width/3, 25)];
        errorLabel.text = @"信息填写不完全";
        errorLabel.backgroundColor = [UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0];
        errorLabel.layer.cornerRadius = 8;
        errorLabel.clipsToBounds = YES;
        errorLabel.textColor = [UIColor whiteColor];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.font = [UIFont systemFontOfSize:14 ];
        errorLabel.alpha = 0;
        [self.view addSubview:errorLabel];
        [UIView animateWithDuration:0.3 animations:^{
            errorLabel.alpha = 0.8;
            CGRect rect = errorLabel.frame;
            rect.origin.y -= 100;
            errorLabel.frame = rect;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                errorLabel.alpha = 0;
            } completion:^(BOOL finished) {
                CGRect rect = errorLabel.frame;
                rect.origin.y += 100;
                errorLabel.frame = rect;
            }];
        }];
    }
    
}

#pragma mark
#pragma mark ============ 设置页面内容
-(void)initForView{
    _firstView = [[UserFirstSettingView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_firstView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [self initForView];
    [_firstView setPostDic:^(NSMutableDictionary * dic) {
        _mySettingDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }];
}

@end
