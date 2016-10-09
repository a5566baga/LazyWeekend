//
//  ShowDetailViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "ShowDetailView.h"
#import <FMDB.h>
#import <AFNetworking.h>
#import "AllActiviteModel.h"
#import "CityLocation.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface ShowDetailViewController ()
//请求的数据
@property(nonatomic, strong)AFHTTPSessionManager * manager;
@property(nonatomic, strong)NSMutableDictionary * paramers;
@property(nonatomic, strong)NSArray<AllActiviteModel *> * modelArray;
@property(nonatomic, strong)NSMutableArray<AllActiviteModel *> * allModelArray;

@property(nonatomic, assign)float lon;
@property(nonatomic, assign)float lat;
@property(nonatomic, assign)NSInteger pageTotal;
@property(nonatomic, assign)NSInteger nowPage;

@property(nonatomic, strong)ShowDetailView * showDetailView;
@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _cityName;
    ZZQLog(@"%@", _cityId);
    ZZQLog(@"%@", _searchStr);
    ZZQLog(@"%@", _cityName);
    [self initForView];
    [SVProgressHUD show];
    [self initForData];
}

-(void)setCityParamValue:(NSString *)cityStr{
    _cityId = cityStr;
}

-(void)setCitySearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
}

#pragma mark 
#pragma mark =========== 创建数据
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
    _nowPage = 1;
    CityLocation * location = [LocationDB queryLocation].firstObject;
    _lon = [location.lon floatValue];
    _lat = [location.lat floatValue];
    NSString * urlStr = @"http://api.lanrenzhoumo.com/wh/common/leos";
    _paramers = [[NSMutableDictionary alloc] init];
//    三种情况
//    1、选择城市之后显示所有内容
//    http: //api.lanrenzhoumo.com/wh/common/leos?category=all&city_id=53&page=1
    if (_cityId != nil) {
        _paramers[@"category"] = @"all";
        _paramers[@"city_id"] = _cityId;
        _paramers[@"page"] = @(1);
    }else if(_searchStr != nil){
//    2、搜索、表面的分类
//    http://api.lanrenzhoumo.com/wh/common/leos?city_id=383&page=1&lon=113.556237&lat=34.809972&keyword=搜索内容
        _paramers[@"city_id"] = _cityId;
        _paramers[@"page"] = @(1);
        _paramers[@"lon"] = @(_lon).stringValue;
        _paramers[@"lat"] = @(_lat).stringValue;
        _paramers[@"keyword"] = _searchStr;
    }
    ZZQLog(@"%@", _paramers);
    _allModelArray = [[NSMutableArray alloc] init];
    [self.manager GET:urlStr parameters:_paramers progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _modelArray = [AllActiviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            for (AllActiviteModel * model in _modelArray) {
                [_allModelArray addObject:model];
            }
            
            [_showDetailView setNewData:_allModelArray];
            
            _pageTotal = [responseObject[@"page_total"] integerValue];
            if (_nowPage < _pageTotal) {
                _nowPage++;
            }
            [_showDetailView endHeaderRefush];
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_showDetailView endHeaderRefush];
        ZZQLog(@"%@", error);
        [self initForErrorView];
        [SVProgressHUD dismiss];
    }];
}
-(void)initForNewData{
    [self.showDetailView.tableView.mj_footer beginRefreshing];
    _nowPage ++;
    CityLocation * location = [LocationDB queryLocation].firstObject;
    _lon = [location.lon floatValue];
    _lat = [location.lat floatValue];
    NSString * urlStr = @"http://api.lanrenzhoumo.com/wh/common/leos";
    _paramers = [[NSMutableDictionary alloc] init];
    //    三种情况
    //    1、选择城市之后显示所有内容
    //    http: //api.lanrenzhoumo.com/wh/common/leos?category=all&city_id=53&page=1
    if (_cityId != nil) {
        _paramers[@"category"] = @"all";
        _paramers[@"city_id"] = _cityId;
        _paramers[@"page"] = @(_nowPage);
    }else if(_searchStr != nil){
        //    2、搜索、表面的分类
        //    http://api.lanrenzhoumo.com/wh/common/leos?city_id=383&page=1&lon=113.556237&lat=34.809972&keyword=搜索内容
        _paramers[@"city_id"] = _cityId;
        _paramers[@"page"] = @(_nowPage);
        _paramers[@"lon"] = @(_lon).stringValue;
        _paramers[@"lat"] = @(_lat).stringValue;
        _paramers[@"keyword"] = _searchStr;
    }
    ZZQLog(@"%@", _paramers);
    _allModelArray = [[NSMutableArray alloc] init];
    [self.manager GET:urlStr parameters:_paramers progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _modelArray = [AllActiviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (AllActiviteModel * model in _modelArray) {
            [_allModelArray addObject:model];
        }
        
        [_showDetailView setData:_allModelArray];
        [_showDetailView.tableView reloadData];
        
        _pageTotal = [responseObject[@"page_total"] integerValue];
        if (_nowPage < _pageTotal) {
            _nowPage++;
        }
        [_showDetailView endFooterRefush];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_showDetailView endFooterRefush];
        ZZQLog(@"%@", error);
        [self initForErrorView];
        [SVProgressHUD dismiss];
    }];
}
#pragma mark
#pragma mark =========== 初始化视图，把参数传进去
-(void)initForView{
    _showDetailView = [[ShowDetailView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    _showDetailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_showDetailView];

    __weak typeof(self) mySelf = self;
    [_showDetailView setHeaderRefush:^{
        [mySelf initForData];
    }];
    [_showDetailView setFooterRefush:^{
        [mySelf initForNewData];
    }];

    [_showDetailView setJumpToDetail:^(DetailActivtyViewController * detailVC, NSInteger leo_id, NSString * imageStr, NSString * titleStr, NSString * nameStr) {
        detailVC.leo_id = leo_id;
        detailVC.imageStr = imageStr;
        detailVC.titleStr = titleStr;
        detailVC.nameStr = nameStr;
        [mySelf.navigationController pushViewController:detailVC animated:YES];
    }];
}
-(void)initForErrorView{
    UIImageView * errPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    errPic.image = [UIImage imageNamed:@"ic_cat_shock_gray"];
    errPic.center = CGPointMake(self.view.width/2, self.view.height/2-50);
    [self.view addSubview:errPic];
    UILabel * errLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(errPic.frame), 200, 40)];
    errLabel.center = CGPointMake(self.view.width/2, errPic.center.y+30);
    errLabel.text = @"对不起  出错了";
    errLabel.numberOfLines = 0;
    errLabel.textColor = [UIColor colorWithRed:0.75 green:0.74 blue:0.76 alpha:1.00];
    errLabel.textAlignment = NSTextAlignmentCenter;
    errLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:errLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

@end
