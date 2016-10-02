//
//  InterestPointViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "InterestPointViewController.h"
#import "UserSecondSettingVIew.h"
#import "Interest.h"

@interface InterestPointViewController ()

@property(nonatomic, strong)UserSecondSettingVIew * secondView;
@property(nonatomic, strong)NSMutableDictionary * mySecSettingDic;
@property(nonatomic, strong)NSMutableDictionary * myDic;

@end

@implementation InterestPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)initForView{
    _secondView = [[UserSecondSettingVIew alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_secondView];
    [_secondView setPostInterestStatus:^(NSMutableDictionary * dic) {
        _myDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.title = @"兴趣标签";
    
    UIButton * saveButton = [[UIButton alloc] init];
    saveButton.frame = CGRectMake(0, 0, 40, 30);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    [self initForView];
    [_secondView setPostInterestStatus:^(NSMutableDictionary * dic) {
        _mySecSettingDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }];
}

-(void)saveAction:(UIButton *)button{
    [InterestingPointDB updateData:_mySecSettingDic];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
