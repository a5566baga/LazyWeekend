//
//  MapDetailViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MapDetailViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>

@interface MapDetailViewController ()
@property(nonatomic, strong)BMKMapView * mapView;
@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    创建地图视图
//    定位到地方
//    插入大头针
}

#pragma make
#pragma mark ========== 赋值定位信息
-(void)setLocation:(float)lon lat:(float)lat poi:(NSString *)poi address:(NSString *)address{
    _lon = lon;
    _lat = lat;
    _poi = poi;
    _address = address;
    ZZQLog(@"%f, %f, %@, %@",_lon, _lat, _poi, _address);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"地址详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark
#pragma mark ============ 地图view
-(void)initForMapView{
    
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
