//
//  DetailActivtyViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/9.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "DetailActivtyViewController.h"
#import "DetailActivtyView.h"
#import "HelpViewController.h"
#import <SVProgressHUD.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@interface DetailActivtyViewController ()

@property(nonatomic, strong)UIView * alertCancelView;
@property(nonatomic, strong)UILabel * textAlertLabel;

@end

@implementation DetailActivtyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initForTitleView];
    [self initForView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    NSString * urlStr = [NSString stringWithFormat:@"http://api.lanrenzhoumo.com/wh/common/leo_detail?leo_id=%ld", (long)_leo_id];
//    第三方分享
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[_imageStr];
    if (imageArray)
    {
        [shareParams SSDKSetupShareParamsByText:_titleStr
                                         images:imageArray
                                            url:[NSURL URLWithString:urlStr]
                                          title:_nameStr
                                           type:SSDKContentTypeImage];
    }
    
    //2、分享
    [ShareSDK showShareActionSheet:button
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state)
                   {
                       case SSDKResponseStateSuccess:
                       {
                           [self initForCancelView:@"分享成功"];
                           [self showAlertView];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           [self initForCancelView:@"分享失败"];
                           [self showAlertView];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           [self initForCancelView:@"分享已取消"];
                           [self showAlertView];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}
//提示取消分享视图
-(void)initForCancelView:(NSString *)text{
    float letf = self.view.width/3;
    _alertCancelView = [[UIView alloc] initWithFrame:CGRectMake(letf, self.view.height*0.8, letf, 30)];
    _alertCancelView.backgroundColor = [UIColor blackColor];
    _alertCancelView.alpha = 0;
    _alertCancelView.layer.cornerRadius = 5;
    _alertCancelView.clipsToBounds = YES;
    [self.view addSubview:_alertCancelView];
    
    _textAlertLabel = [[UILabel alloc] initWithFrame:_alertCancelView.bounds];
    _textAlertLabel.textAlignment = NSTextAlignmentCenter;
    _textAlertLabel.font = [UIFont systemFontOfSize:15];
    _textAlertLabel.textColor = [UIColor whiteColor];
    _textAlertLabel.text = text;
    [self.alertCancelView addSubview:_textAlertLabel];
}
-(void)showAlertView{
    [UIView animateWithDuration:0.8 animations:^{
        _alertCancelView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            _alertCancelView.alpha = 0;
        }];
    }];
}
-(void)backAvtion:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
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
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 2;
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
    
    [detailView setDownLoadFinish:^{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
    }];
    
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
    
    [detailView setJumpToMap:^(MapDetailViewController * mapVC, float lon, float lat, NSString * poi, NSString * address) {
        [mapVC setLocation:lon lat:lat poi:poi address:address];
        [self.navigationController pushViewController:mapVC animated:YES];
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
