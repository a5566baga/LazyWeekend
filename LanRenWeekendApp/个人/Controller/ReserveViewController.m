//
//  ReserveViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ReserveViewController.h"

@interface ReserveViewController ()

@end

@implementation ReserveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的预定";
    [self initForReserveView];
}

#pragma mark
#pragma mark ============ 预定页面详情
-(void)initForReserveView{
    UIView * reView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    reView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:reView];
    UILabel * errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];;
    errorLabel.center = CGPointMake(self.view.width/2, reView.height/2-50);
    errorLabel.text = @"对不起，本功能尚未开放";
    errorLabel.textAlignment = NSTextAlignmentCenter;
    errorLabel.font = [UIFont systemFontOfSize:18];
    errorLabel.textColor = [UIColor grayColor];
    [reView addSubview:errorLabel];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
