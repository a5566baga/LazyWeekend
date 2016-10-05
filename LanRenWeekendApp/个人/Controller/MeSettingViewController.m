//
//  MeSettingViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MeSettingViewController.h"
#import "MeSettingView.h"
#import "SettingViewController.h"
#import "InterestPointViewController.h"
#import "ReserveViewController.h"

@interface MeSettingViewController ()<MeSettingViewProtocal>

@end

@implementation MeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark
#pragma mark ========== 隐藏nav
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self initForView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark
#pragma mark ========== 创建collectionView
-(void)initForView{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    label.font = [UIFont fontWithName:@"Gotham-Light" size:17];
    if (![[UserDB queryUserName] isEqualToString:@""]) {
        label.text = [UserDB queryUserName];
    }else{
        label.text = @"匿名用户";
    }
    self.navigationItem.titleView = label;
    
    MeSettingView * meView = [[MeSettingView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49)];
    meView.delegate = self;
    [self.view addSubview:meView];
    typeof(self) myself = self;
    [meView setJumpToDetailView:^(DetailActivtyViewController * detailVC, NSInteger leo_id) {
        detailVC.leo_id = leo_id;
        [myself.navigationController pushViewController:detailVC animated:YES];
    }];
}

-(void)jumpToNextRes:(ReserveViewController *)reseverVC{
    [self.navigationController pushViewController:reseverVC animated:YES];
}
-(void)jumpToNextInter:(InterestPointViewController *)interestVC{
    [self.navigationController pushViewController:interestVC animated:YES];
}
-(void)jumpToNext:(SettingViewController *)settingVC{
        [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
