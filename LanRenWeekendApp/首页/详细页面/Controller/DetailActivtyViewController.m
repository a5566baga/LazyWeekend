//
//  DetailActivtyViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/9.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "DetailActivtyViewController.h"
#import "DetailActivtyView.h"
#import <SVProgressHUD.h>

@interface DetailActivtyViewController ()



@end

@implementation DetailActivtyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initForTitleView];
    [self initForView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)initForTitleView{
    UIBarButtonItem * shareBar = [UIBarButtonItem itemWithImage:@"ic_nav_share_white" HightImage:@"ic_nav_share_white" target:self action:@selector(shareButton:)];
    UIBarButtonItem * favBar = [UIBarButtonItem itemWithImage:@"ic_nav_heart_white_off" HightImage:@"ic_nav_heart_white_off" target:self action:@selector(favButton:)];
    UIBarButtonItem * quesBar = [UIBarButtonItem itemWithImage:@"ic_nav_help_white" HightImage:@"ic_nav_help_white" target:self action:@selector(helpBar:)];
    self.navigationItem.rightBarButtonItems = @[quesBar, favBar, shareBar];
}
-(void)shareButton:(UIButton *)button{
//    第三方分享
}
-(void)favButton:(UIButton *)button{
    [button setBackgroundImage:[UIImage imageNamed:@"ic_nav_white_heart_on"] forState:UIControlStateSelected];
    [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionAutoreverse animations:^{
        button.selected = !button.selected;
            button.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }completion:^(BOOL finished) {
            button.imageView.transform = CGAffineTransformIdentity;
        }];
}
-(void)helpBar:(UIButton *)button{
//    帮助
}
#pragma mark
#pragma mark ============ 初始化界面
-(void)initForView{
    DetailActivtyView * detailView = [[DetailActivtyView alloc] initWithFrame:self.view.bounds];
    detailView.backgroundColor = [UIColor whiteColor];
    detailView.leo_id = self.leo_id;
    [self.view addSubview:detailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
