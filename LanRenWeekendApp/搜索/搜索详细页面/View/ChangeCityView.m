//
//  ChangeCityView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ChangeCityView.h"
#import "ChangCityHeaderView.h"
#import "ChangeCityTableViewCell.h"
#import "CitysModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@interface ChangeCityView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)AFHTTPSessionManager * manager;

@property(nonatomic, strong)NSArray <CitysModel *> * cityArray;
@property(nonatomic, strong)NSMutableArray<NSArray *> * allCity;
@property(nonatomic, strong)NSMutableArray * cityNameArray;

@end

@implementation ChangeCityView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        数据请求
        [self initForData];
//        创建tableView
        [self initForTableView];
    }
    return self;
}
#warning 这个页面还没完成
#pragma mark
#pragma mark ============ 请求数据
-(AFHTTPSessionManager *)manager{
    if (nil == _manager) {
        _manager = [AFHTTPSessionManager manager];
        NSSet * set = [[NSSet alloc] initWithObjects:@"text/html", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}
#pragma mark
#pragma mark ============ 请求数据
-(void)initForData{
    _cityNameArray = [NSMutableArray array];
    _allCity = [NSMutableArray array];
    [self.manager GET:@"http://api.lanrenzhoumo.com/district/list/allcity" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * allCity = responseObject[@"result"];
        for (NSDictionary * dic in allCity) {
            NSString * indexStr = dic[@"begin_key"];
            [_cityNameArray addObject:indexStr];
            _cityArray = [CitysModel mj_objectArrayWithKeyValuesArray:dic[@"city_list"]];
            [_allCity addObject:_cityArray];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}
#pragma mark
#pragma mark ============ 创建tableView
-(void)initForTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.sectionIndexColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

#pragma mark
#pragma mark ============ tableView的delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else
        return  [_allCity[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allCity.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChangeCityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"changeCityCell"];
    if (cell == nil) {
        cell = [[ChangeCityTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"changeCityCell"];
    }
    cell.frame = CGRectMake(15, 0, self.width-30, 40);
    cell.textLabel.text = [_allCity[indexPath.section][indexPath.row] city_name];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//选中后跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 页面跳转传的参数是http://api.lanrenzhoumo.com/wh/common/leos?category=all&city_id=321&page=1
//    city_id
}
//headerView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 500;
    }
        return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        ChangCityHeaderView * headerView = [[ChangCityHeaderView alloc] init];
        [headerView setHotCityArray:_allCity[section]];
        return headerView;
    }else{
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(20, 0, 100, 30);
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.text = [NSString stringWithFormat:@"  %@", _cityNameArray[section]];
        titleLabel.backgroundColor = [UIColor whiteColor];
        return titleLabel;
    }
}
//设置侧边索引栏
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSLog(@"");
    return _cityNameArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSLog(@"index == %ld", index);
    return index;
}
//侧边栏消失出现
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.sectionIndexBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
        _tableView.sectionIndexColor = [UIColor grayColor];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [UIView animateWithDuration:1 animations:^{
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor clearColor];
    }];
}
@end
