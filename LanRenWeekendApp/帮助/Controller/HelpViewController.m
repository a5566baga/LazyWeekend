//
//  HelpViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "HelpViewController.h"
#import "TalkTableView.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置titleView
    [self initForTitleView];
    //设置内容
    [self initForView];
}
#pragma mark 
#pragma mark ========= 设置标题内容
-(void)initForTitleView{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    label.font = [UIFont fontWithName:@"Gotham-Light" size:17];
    label.text = @"懒喵助理";
    self.navigationItem.titleView = label;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark
#pragma mark ========= 设置主要内容
-(void)initForView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    TalkTableView * talkTableView = [[TalkTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    talkTableView.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.97 alpha:1.00];
    [self.view addSubview:talkTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden = NO;
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
