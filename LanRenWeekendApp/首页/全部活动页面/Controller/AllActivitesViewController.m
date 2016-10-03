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
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface AllActivitesViewController ()<BMKLocationServiceDelegate>
//定位
@property(nonatomic, strong)BMKLocationService * locService;
@property(nonatomic, assign)float lon;
@property(nonatomic, assign)float lat;

@property(nonatomic, strong)AllActiviteView * allActiviesView;
@end

@implementation AllActivitesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getLocation];
//    标题栏设计
    [self initForTitle];
//    主页面设计
    [self initForView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _locService.delegate = self;
    if (_allActiviesView != nil) {
        [_allActiviesView.myTableView reloadData];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    _locService.delegate = nil;
}
-(void)getLocation{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _lon = 0;
    _lat = 0;
    //启动LocationService
    [_locService startUserLocationService];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if ((NSInteger)_lon != (NSInteger)userLocation.location.coordinate.longitude || (NSInteger)_lat != (NSInteger)userLocation.location.coordinate.latitude) {
        _lon = userLocation.location.coordinate.longitude;
        _lat = userLocation.location.coordinate.latitude;
        [_allActiviesView setLocation:_lon lat:_lat];
    }
}

#pragma mark
#pragma mark ========= 标题栏设计
-(void)initForTitle{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    label.font = [UIFont fontWithName:@"Gotham-Light" size:17];
    label.text = @"周末去哪耍";
    self.navigationItem.titleView = label;
}
#pragma mark
#pragma mark ========= 主页面
-(void)initForView{
    _allActiviesView = [[AllActiviteView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    __weak typeof(self) mySelf = self;
    [_allActiviesView setJumpToDetail:^(DetailActivtyViewController * detailVC, NSInteger leo_id, NSString * imageStr, NSString * titleStr, NSString * nameStr) {
        detailVC.leo_id = leo_id;
        detailVC.imageStr = imageStr;
        detailVC.titleStr = titleStr;
        detailVC.nameStr = nameStr;
        [mySelf.navigationController pushViewController:detailVC animated:YES];
    }];
    [self.view addSubview:_allActiviesView];
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
