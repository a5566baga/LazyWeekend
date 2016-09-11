//
//  AllActivitesViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/29.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AllActivitesViewController.h"
#import "AllActiviteView.h"
#import "AllActiviteModel.h"

@interface AllActivitesViewController ()

@end

@implementation AllActivitesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    标题栏设计
    [self initForTitle];
//    主页面设计
    [self initForView];
}

#pragma mark
#pragma mark ========= 标题栏设计
-(void)initForTitle{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    label.font = [UIFont fontWithName:@"Gotham-Light" size:17];
    label.text = @"懒人周末";
    self.navigationItem.titleView = label;
}
#pragma mark
#pragma mark ========= 主页面
-(void)initForView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    AllActiviteView * allActiviesView = [[AllActiviteView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    [allActiviesView setJumpToDetail:^(DetailActivtyViewController * detailVC, NSInteger leo_id) {
        detailVC.leo_id = leo_id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    [self.view addSubview:allActiviesView];
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
