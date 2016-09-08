//
//  SettingViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDetailTableViewCell.h"

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
    _titleArray = @[@"分享给好友", @"清除缓存", @"给我们一个评价", @"用户反馈", @"检查更新", @"联系我们", @"退出登录"];
    _icnoArray = @[@"ic_setting_share_app", @"ic_trash", @"ic_star", @"bbs_message", @"ic_update", @"ic_tel", @"ic_logout"];
}

#pragma mark
#pragma mark =========== 主页面设置
-(void)initForView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStylePlain];
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
