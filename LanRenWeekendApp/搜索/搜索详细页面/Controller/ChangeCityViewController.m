//
//  ChangeCityViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ChangeCityViewController.h"
#import "ChangeCityView.h"

@interface ChangeCityViewController ()
@property(nonatomic, strong)ChangeCityView * changCityView;
@end

@implementation ChangeCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    设置nav的属性
    [self initForTitleView];
//    下面的内容是tableView实现的
    [self initForView];
}

-(void)initForTitleView{
    self.navigationItem.title = @"切换城市";
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * exitButton = [UIBarButtonItem itemWithImage:@"ic_me_back" HightImage:@"cancel_white" target:self action:@selector(exitAction:)];
    self.navigationItem.leftBarButtonItem = exitButton;
}

-(void)exitAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark
#pragma mark =========== 创建地理位置的视图
-(void)initForView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _changCityView = [[ChangeCityView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_changCityView];
    
    __weak typeof(self) mySelf = self;
    [_changCityView setJumpToCity:^(ShowDetailViewController * vc, NSString * cityId, NSString * cityName) {
        [vc setCityParamValue:cityId];
        [vc setCityName:cityName];
        [mySelf.navigationController pushViewController:vc animated:YES];
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_changCityView.tableView reloadData];
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
