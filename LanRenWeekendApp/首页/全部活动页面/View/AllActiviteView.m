//
//  AllActiviteView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AllActiviteView.h"
#import "AllActivitesTableViewCell.h"
#import "AllActiviteModel.h"
#import <CoreLocation/CoreLocation.h>
//第三方
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#define CELL_ID @"allActivitesCell"
@interface AllActiviteView ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, BMKLocationServiceDelegate, BMKMapViewDelegate,BMKGeoCodeSearchDelegate>

//定位
@property(nonatomic, strong)BMKLocationService * locService;
@property(nonatomic, strong)BMKReverseGeoCodeOption *reverseGeoCodeOption;
@property(nonatomic, strong)BMKGeoCodeSearch *geoCodeSearch; ;


//get请求的参数
@property(nonatomic, assign)float lon;
@property(nonatomic, assign)float lat;
@property(nonatomic, strong)NSString * cityName;
@property(nonatomic, assign)NSInteger pageTotal;
@property(nonatomic, assign)NSInteger nowPage;
//请求的数据
@property(nonatomic, strong)AFHTTPSessionManager * manager;
@property(nonatomic, strong)NSArray<AllActiviteModel *> * modelArray;
@property(nonatomic, strong)NSMutableArray<AllActiviteModel *> * allModelArray;

@end

@implementation AllActiviteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark
#pragma mark ======== 定位，确定lon和lat(界面搞定在写)
-(void)setLocation:(float)lon lat:(float)lat{
    _lon = lon;
    _lat = lat;
    [self initForTableView];
    [self getLocationCity:_lon lat:_lat];
}
#pragma mark
#pragma mark ======== 数据的处理
-(AFHTTPSessionManager *)manager{
    if (nil == _manager) {
        _manager = [AFHTTPSessionManager manager];
        //设置网络请求数据返回值的类型。
        NSSet * set = [NSSet setWithObjects:@"text/html",@"json/html",@"application/json", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}
-(void)initForData{
    [self getLocationCity:_lon lat:_lat];
#warning 写入数据库
    [LocationDB deleteLocation];
    if (_cityName != nil) {
        [LocationDB addLocation:_cityName lon:_lon lat:_lat];
    }else{
        [LocationDB addLocation:nil lon:_lon lat:_lat];
    }
    
    _allModelArray = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"加载中"];
    
    _nowPage = 1;
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    dataDic[@"page"] = @(self.nowPage);
    dataDic[@"lon"] = @(_lon);
    dataDic[@"lat"] = @(_lat);
    [self.manager GET:@"http://api.lanrenzhoumo.com/main/recommend/index?" parameters:dataDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _modelArray = [AllActiviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (AllActiviteModel * model in _modelArray) {
            [_allModelArray addObject:model];
        }
        [_myTableView reloadData];
        _pageTotal = [responseObject[@"page_total"] integerValue];
        if (_nowPage < _pageTotal) {
            _nowPage++;
        }
        
        [SVProgressHUD dismiss];
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"对不起，网络出错"];
        ZZQLog(@"%@", error);
        [self.myTableView.mj_header endRefreshing];
        [self initForErrorView];
    }];
}
#pragma mark
#pragma mark ======== 请求新数据
-(void)initForNewData{
    [self.myTableView.mj_footer beginRefreshing];
    _nowPage ++;
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    dataDic[@"page"] = @(self.nowPage);
    dataDic[@"lon"] = @(_lon);
    dataDic[@"lat"] = @(_lat);
    [self.manager GET:@"http://api.lanrenzhoumo.com/main/recommend/index?" parameters:dataDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _modelArray = [AllActiviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (AllActiviteModel * model in _modelArray) {
            [_allModelArray addObject:model];
        }
        [_myTableView reloadData];
        _pageTotal = [responseObject[@"page_total"] integerValue];
        if (_nowPage < _pageTotal) {
            _nowPage++;
        }
        [self.myTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZZQLog(@"%@", error);
        [self.myTableView.mj_footer endRefreshing];
        [self initForErrorView];
    }];
}
#pragma mark
#pragma mark ======== 数据刷新方式
-(void)refresh{
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    [self.myTableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    self.myTableView.mj_footer = footer;
}
-(void)headerAction{
    [self initForData];
}
-(void)footerAction{
    [self initForNewData];
}
#pragma mark
#pragma mark ======== tableView的创建
-(void)initForTableView{
    if (_lat != 0 && _lon !=0) {
        _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self addSubview:_myTableView];
    }else{
        [self initForErrorView];
    }
    [self refresh];
}
-(void)initForErrorView{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    UIImageView * errPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    errPic.image = [UIImage imageNamed:@"ic_cat_shock_gray"];
    errPic.center = CGPointMake(self.width/2, self.height/2-50);
    [self addSubview:errPic];
    UILabel * errLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(errPic.frame), 200, 40)];
    errLabel.center = CGPointMake(self.width/2, errPic.center.y+30);
    errLabel.text = @"对不起  出错了";
    errLabel.numberOfLines = 0;
    errLabel.textColor = [UIColor colorWithRed:0.75 green:0.74 blue:0.76 alpha:1.00];
    errLabel.textAlignment = NSTextAlignmentCenter;
    errLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:errLabel];
}
#pragma mark
#pragma mark ======== layoutSubviews布局
-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark
#pragma mark ======== tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllActivitesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (nil == cell) {
        cell = [[AllActivitesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    for(UIView *view in cell.subviews){
        if(view){
            [view removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.masksToBounds = YES;
    if (_allModelArray.count > 0) {
        [cell setCellStyle:_allModelArray[indexPath.section]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.width/3.0*4.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:0.7];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZQLog(@"%ld", (long)indexPath.section);
    DetailActivtyViewController * detailVC = [[DetailActivtyViewController alloc] init];
    self.jumpToDetail(detailVC, [_allModelArray[indexPath.section] leo_id], [_allModelArray[indexPath.section] front_cover_image_list].firstObject, [_allModelArray[indexPath.section] title], [_allModelArray[indexPath.section] poi_name]);
}
#pragma mark
#pragma mark ============== 工具类
-(void)getLocationCity:(float)lon lat:(float)lat{
    //初始化反地理编码类
    _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    
    //需要逆地理编码的坐标位置
    CLLocationCoordinate2D coorDinate = CLLocationCoordinate2DMake(_lat, _lon);
    _reverseGeoCodeOption.reverseGeoPoint = coorDinate;
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
    //创建地理编码对象
    CLGeocoder * geocoder=[[CLGeocoder alloc]init];
    CLLocation *location=[[CLLocation alloc]initWithLatitude:coorDinate.latitude longitude:coorDinate.longitude];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            ZZQLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //赋值详细地址
            NSString * cityName= placemark.locality;
            _cityName = [cityName substringWithRange:NSMakeRange(0, cityName.length-1)];
            ZZQLog(@"cityName___%@", _cityName);
            [LocationDB deleteLocation];
            if (_cityName != nil) {
                [LocationDB addLocation:_cityName lon:_lon lat:_lat];
            }else{
                [LocationDB addLocation:nil lon:_lon lat:_lat];
            }
//            [self refresh];
        }
    }];
}
@end

