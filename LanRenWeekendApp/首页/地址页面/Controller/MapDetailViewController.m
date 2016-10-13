//
//  MapDetailViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MapDetailViewController.h"
#import "CityLocation.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface MapDetailViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
@property(nonatomic, strong)BMKMapView * mapView;
@property(nonatomic, strong)BMKLocationService * locService;
@property(nonatomic, assign)NSInteger picId;
@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
//    创建地图视图
    [self initForMapView];
//    定位到地方
//    [self getLocation];
//    插入大头针
}

#pragma make
#pragma mark ========== 赋值定位信息
-(void)setLocation:(float)lon lat:(float)lat poi:(NSString *)poi address:(NSString *)address picId:(NSInteger)picId{
    _lon = lon;
    _lat = lat;
    _poi = poi;
    _address = address;
    _picId = picId;
    ZZQLog(@"%f, %f, %@, %@",_lon, _lat, _poi, _address);
}
#pragma mark
#pragma mark ============ 页面基础设置
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"地址详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    _mapView.delegate = nil;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mask"] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark
#pragma mark =========== 定位
-(void)getLocation{
    ZZQLog(@"===========Location");
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    我的位置
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    
    CLLocationCoordinate2D coord;
    coord.latitude=userLocation.location.coordinate.latitude;
    coord.longitude=userLocation.location.coordinate.longitude;
    //添加大头针
    BMKPointAnnotation *ann=[[BMKPointAnnotation alloc] init];
    ann.coordinate=coord;
    ann.title=@"我的位置";
    [_mapView addAnnotation:ann];
    BMKCoordinateRegion region ;//表示范围的结构体
    
    region.center = coord;//指定地图中心点
    region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.1;//纬度范围
    [_mapView setRegion:region animated:YES];
}
#pragma mark
#pragma mark ============ 地图view
-(void)initForMapView{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
//    目标地点
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = _lat;
    coor.longitude = _lon;
    annotation.coordinate = coor;
    annotation.title = _poi;
    annotation.subtitle = _address;
    [_mapView addAnnotation:annotation];

    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = coor;//指定地图中心点
    region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.1;//纬度范围
    [_mapView setRegion:region animated:YES];
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        NSArray * picArray = @[@"ic_location_bag", @"ic_location_hotel", @"ic_location_shirt", @"ic_location_persons", @"ic_location_music", @"ic_location_basketball", @"ic_location_pic", @"ic_location_bar", @"ic_location_leaf", @"ic_location_ticket", @"ic_location_stage", @"ic_location_food"];
        NSInteger index = _picId%12;
        newAnnotationView.image = [UIImage imageNamed:picArray[index]];
        [newAnnotationView setSelected:YES animated:YES];
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        return newAnnotationView;
    }
    return nil;
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
