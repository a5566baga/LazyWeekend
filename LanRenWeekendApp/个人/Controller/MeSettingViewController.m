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
    [self initForView];
}
#pragma mark
#pragma mark ========== 隐藏nav
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark
#pragma mark ========== 创建collectionView
-(void)initForView{
    MeSettingView * meView = [[MeSettingView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-49)];
    meView.delegate = self;
    [self.view addSubview:meView];
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
