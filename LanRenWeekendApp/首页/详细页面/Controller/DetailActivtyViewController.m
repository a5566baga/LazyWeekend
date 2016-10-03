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
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = NO;
}
//白色的nav
-(void)initForTitleView{
    UIBarButtonItem * shareBar = [UIBarButtonItem itemWithImage:@"ic_nav_share_white" HightImage:@"ic_nav_share_white" target:self action:@selector(shareButton:)];
    
    UIButton * favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [favButton setBackgroundImage:[UIImage imageNamed:@"ic_nav_heart_white_off"] forState:UIControlStateNormal];
    [favButton setBackgroundImage:[UIImage imageNamed:@"ic_nav_white_heart_on"] forState:UIControlStateSelected];
    favButton.selected = [FavouriteDB isFavourit:_leo_id];
    [favButton addTarget:self action:@selector(favButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * favBar = [[UIBarButtonItem alloc] initWithCustomView:favButton];
       
    
    UIBarButtonItem * quesBar = [UIBarButtonItem itemWithImage:@"ic_nav_help_white" HightImage:@"ic_nav_help_white" target:self action:@selector(helpBar:)];
    self.navigationItem.rightBarButtonItems = @[quesBar, favBar, shareBar];
}
//黑色的nav
-(void)initForTitleViewBlack{
    UIBarButtonItem * shareBar = [UIBarButtonItem itemWithImage:@"ic_nav_share_black" HightImage:@"ic_nav_share_black" target:self action:@selector(shareButton:)];
    
    UIButton * favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [favButton setBackgroundImage:[UIImage imageNamed:@"ic_nav_black_heart_off"] forState:UIControlStateNormal];
    [favButton setBackgroundImage:[UIImage imageNamed:@"ic_nav_black_heart_on"] forState:UIControlStateSelected];
    [favButton addTarget:self action:@selector(favButtonBlack:) forControlEvents:UIControlEventTouchUpInside];
    favButton.selected = [FavouriteDB isFavourit:_leo_id];
    UIBarButtonItem * favBar = [[UIBarButtonItem alloc] initWithCustomView:favButton];

    UIBarButtonItem * quesBar = [UIBarButtonItem itemWithImage:@"ic_nav_help" HightImage:@"ic_nav_help" target:self action:@selector(helpBar:)];
    self.navigationItem.rightBarButtonItems = @[quesBar, favBar, shareBar];
    
    UIBarButtonItem * backBar = [UIBarButtonItem itemWithImage:@"ic_nav_left" HightImage:@"ic_nav_left" target:self action:@selector(backAvtion:)];
    self.navigationItem.leftBarButtonItem = backBar;
}
-(void)shareButton:(UIButton *)button{
//    第三方分享
}
-(void)backAvtion:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
#warning message
-(void)favButtonBlack:(UIButton *)button{
    if (button.selected) {
        [FavouriteDB deleteFavouriteItem:_leo_id];
    }else{
        [FavouriteDB addFavourite:_leo_id pic:_imageStr title:_titleStr poi_name:_nameStr];
    }
    button.selected = !button.selected;
}
-(void)favButton:(UIButton *)button{
    if (button.selected) {
        [FavouriteDB deleteFavouriteItem:_leo_id];
    }else{
        [FavouriteDB addFavourite:_leo_id pic:_imageStr title:_titleStr poi_name:_nameStr];
    }
    button.selected = !button.selected;
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
    detailView.imageStr = self.imageStr;
    detailView.titleStr = self.titleStr;
    detailView.nameStr = self.nameStr;
    [self.view addSubview:detailView];
    
    [detailView setChangeNavbar:^{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        [self initForTitleViewBlack];
    }];
    [detailView setChangeNavbarBack:^{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
        [self initForTitleView];
        UIBarButtonItem * backBar = [UIBarButtonItem itemWithImage:@"ic_nav_left_white" HightImage:@"ic_nav_left_white" target:self action:@selector(backAvtion:)];
        self.navigationItem.leftBarButtonItem = backBar;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
