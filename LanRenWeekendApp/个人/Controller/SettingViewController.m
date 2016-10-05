//
//  SettingViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDetailTableViewCell.h"
#import "MainViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <UIImageView+WebCache.h>

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSArray * icnoArray;
@property(nonatomic, strong)NSArray * titleArray;

//提示
@property(nonatomic, strong)UIView * alertCancelView;
@property(nonatomic, strong)UILabel * textAlertLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    初始化数据
    [self initForData];
    //    设置titleView
    [self initForTitleView];
    //    创建view
    [self initForView];
}
#pragma mark
#pragma mark =========== titleView
-(void)initForTitleView{
    self.navigationItem.title = @"设置";
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

#pragma mark
#pragma mark =========== 数据
-(void)initForData{
    if ([[UserDB queryUserName] isEqualToString:@""]) {
        _titleArray = @[@"分享给好友", @"清除缓存", @"用户反馈", @"联系我们", @"登录账号"];
    }else{
        _titleArray = @[@"分享给好友", @"清除缓存", @"用户反馈", @"联系我们", @"退出登录"];
    }
    _icnoArray = @[@"ic_setting_share_app", @"ic_trash",  @"bbs_message", @"ic_tel", @"ic_logout"];
}

#pragma mark
#pragma mark =========== 主页面设置
-(void)initForView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark ========== tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil) {
        cell = [[SettingDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellTitle:_titleArray[indexPath.row] img:_icnoArray[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    ZZQLog(@"%ld", indexPath.row);
    if (indexPath.row == 0) {
        //        分享
        [self shareButtonAction:tableView];
    }else if (indexPath.row == 1){
        //        清除缓存
        float ImageCache = [[SDImageCache sharedImageCache]getSize]/1000/1000;
        [self initForCancelView:[NSString stringWithFormat:@"清除缓存%.2lfMB", ImageCache]];
        [[SDImageCache sharedImageCache] clearDisk];
        [self showAlertView];
    }else if (indexPath.row == 2){
        //        用户反馈
        [self initForCancelView:@"还未开放"];
        [self showAlertView];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://a5566baga@126.com"]];
    }else if (indexPath.row == 3){
        //        联系我们
        [self initForCancelView:@"还未开放"];
        [self showAlertView];
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://15670276702"]];
    }else if (indexPath.row == 4){
        //        登录账号/退出账号
        [UserDB deleteAllUser];
        [FavouriteDB deleteAllFavouriteItem];
        [InterestingPointDB deleteAllData];
        MainViewController * mainVC = [[MainViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:mainVC];
        [UIApplication sharedApplication].keyWindow.rootViewController = nvc;
    }
}
-(void)shareButtonAction:(id)gender{
    NSString * shareUrl = @"http://lanrenzhoumo.com/";
    //    第三方分享
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"mountain_199.1960199005px_1200341_easyicon.net"]];
    if (imageArray)
    {
        [shareParams SSDKSetupShareParamsByText:@"一起在城市中寻找快乐吧~~~"
                                         images:imageArray
                                            url:[NSURL URLWithString:shareUrl]
                                          title:@"周末去哪耍"
                                           type:SSDKContentTypeImage];
    }
    
    //2、分享
    [ShareSDK showShareActionSheet:gender
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
    _alertCancelView = [[UIView alloc] initWithFrame:CGRectMake(letf, self.view.height*0.7, letf, 30)];
    _alertCancelView.backgroundColor = [UIColor blackColor];
    _alertCancelView.alpha = 0;
    _alertCancelView.layer.cornerRadius = 5;
    _alertCancelView.clipsToBounds = YES;
    [self.tableView addSubview:_alertCancelView];
    
    _textAlertLabel = [[UILabel alloc] initWithFrame:_alertCancelView.bounds];
    _textAlertLabel.textAlignment = NSTextAlignmentCenter;
    _textAlertLabel.font = [UIFont systemFontOfSize:15];
    _textAlertLabel.textColor = [UIColor whiteColor];
    _textAlertLabel.text = text;
    _textAlertLabel.adjustsFontSizeToFitWidth = YES;
    [self.alertCancelView addSubview:_textAlertLabel];
}
-(void)showAlertView{
    [UIView animateWithDuration:0.8 animations:^{
        _alertCancelView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            _alertCancelView.alpha = 0;
        }completion:^(BOOL finished) {
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
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
