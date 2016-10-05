//
//  MainViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/2.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MainViewController.h"
#import "LoginView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LoginView * loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, -20, self.view.width, self.view.height+20)];
    [self.view addSubview:loginView];
    [loginView setJumpToMain:^(UserFirstSettingViewController * viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
    [loginView setJumpToMainByOtherWay:^(UserFirstSettingViewController * firstVC, NSString * nickName, NSString * iconStr) {
        [firstVC setUserInfo:nickName iconStr:iconStr];
        [self.navigationController pushViewController:firstVC animated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
