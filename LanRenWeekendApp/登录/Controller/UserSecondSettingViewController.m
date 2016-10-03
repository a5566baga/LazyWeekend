//
//  UserSecondSettingViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UserSecondSettingViewController.h"
#import "CustomerTabBarViewController.h"
#import "UserSecondSettingVIew.h"

@interface UserSecondSettingViewController ()

@property(nonatomic, strong)UserSecondSettingVIew * secondView;
@property(nonatomic, strong)NSMutableDictionary * mySecSettingDic;

@end

@implementation UserSecondSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
//    设置标题
    [self initForTitleView];
//    设置主页面
//    [self initForView];
}
#pragma mark
#pragma mark ========== 设置navigationBar样式
-(void)initForTitleView{
    //    中间标题
    self.navigationItem.titleView = [UINavigationItem setTitleViewWithTitle:@"选择您的兴趣标签" font:[UIFont fontWithName:@"Gotham-Light" size:17]];
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
//DB Save
//    用block跳转。把内容提交到数据库
    [InterestingPointDB insertNewData:_mySecSettingDic];
    CustomerTabBarViewController * tabBarController = [[CustomerTabBarViewController alloc] init];
    [UIView animateWithDuration:0.5 animations:^{
        [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
    }];
}
#pragma mark
#pragma mark ============== 设置主页面collectionView
-(void)initForView{
    _secondView = [[UserSecondSettingVIew alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_secondView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self initForView];
    [_secondView setPostInterestStatus:^(NSMutableDictionary * dic) {
        _mySecSettingDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
        
    }];
}

@end
