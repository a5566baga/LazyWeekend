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
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self initForView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark
#pragma mark ========== 创建collectionView
-(void)initForView{
    if (![[UserDB queryUserName] isEqualToString:@""]) {
        self.title = [UserDB queryUserName];
    }else{
        self.title = @"匿名用户";
    }
    
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
