//
//  ShowDetailViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ShowDetailViewController.h"
#import <FMDB.h>

@interface ShowDetailViewController ()

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _cityName;
    ZZQLog(@"%@", _cityId);
    ZZQLog(@"%@", _searchStr);
    ZZQLog(@"%@", _cityName);
}

-(void)setCityParamValue:(NSString *)cityStr{
    _cityId = cityStr;
}

-(void)setCitySearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
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
