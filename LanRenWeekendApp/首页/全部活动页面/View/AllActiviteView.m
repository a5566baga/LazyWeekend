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
//第三方
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

#define CELL_ID @"allActivitesCell"
@interface AllActiviteView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * myTableView;
//get请求的参数
@property(nonatomic, assign)double lon;
@property(nonatomic, assign)double lat;
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
        [self getLocation];
        [self initForData];
        [self initForTableView];
        [self refresh];
    }
    return self;
}

#pragma mark
#pragma mark ======== 定位，确定lon和lat(界面搞定在写)
-(void)getLocation{
    _lon = 113.556002;
    _lat = 34.809942;
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
    _allModelArray = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    _nowPage = 1;
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    dataDic[@"page"] = @(self.nowPage);
    dataDic[@"lon"] = @(_lon);
    dataDic[@"lat"] = @(_lat);
    [self.manager GET:@"http://api.lanrenzhoumo.com/main/recommend/index?" parameters:dataDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _modelArray = [AllActiviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [_allModelArray addObjectsFromArray:_modelArray];
        [_myTableView reloadData];
        _pageTotal = [responseObject[@"page_total"] integerValue];
        if (_nowPage < _pageTotal) {
            _nowPage++;
        }
        [SVProgressHUD dismiss];
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"对不起，网络出错"];
        NSLog(@"Failed");
        NSLog(@"%@", error);
        [self.myTableView.mj_header endRefreshing];
    }];
}
#pragma mark
#pragma mark ======== 请求新数据
-(void)initForNewData{
    [self.myTableView.mj_footer beginRefreshing];
    _nowPage = 2;
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    dataDic[@"page"] = @(self.nowPage);
    dataDic[@"lon"] = @(_lon);
    dataDic[@"lat"] = @(_lat);
    [self.manager GET:@"http://api.lanrenzhoumo.com/main/recommend/index?" parameters:dataDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _modelArray = [AllActiviteModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [_allModelArray addObjectsFromArray:_modelArray];
        [_myTableView reloadData];
        _pageTotal = [responseObject[@"page_total"] integerValue];
        if (_nowPage < _pageTotal) {
            _nowPage++;
        }
        [self.myTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed");
        NSLog(@"%@", error);
        [self.myTableView.mj_footer endRefreshing];
    }];
}
#pragma mark
#pragma mark ======== 数据刷新方式
-(void)refresh{
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    [self.myTableView.mj_header beginRefreshing];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
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
    _myTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _myTableView.showsHorizontalScrollIndicator = NO;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.bounces = YES;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self addSubview:_myTableView];
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
    [cell setCellStyle:_allModelArray[indexPath.section]];
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

@end


