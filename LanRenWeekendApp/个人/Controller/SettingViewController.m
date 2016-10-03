//
//  SettingViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDetailTableViewCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSArray * icnoArray;
@property(nonatomic, strong)NSArray * titleArray;

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
    ZZQLog(@"%ld", indexPath.row);
    if (indexPath.row == 0) {
//        分享
        [self shareButtonAction:tableView];
    }else if (indexPath.row == 1){
//        清除缓存
        
    }else if (indexPath.row == 2){
//        用户反馈
    }else if (indexPath.row == 3){
//        练习我们
    }else if (indexPath.row == 4){
//        登录账号/退出账号
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
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@", error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
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
