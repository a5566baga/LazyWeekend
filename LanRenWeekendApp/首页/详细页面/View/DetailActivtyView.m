//
//  DetailActivtyView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/9.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "DetailActivtyView.h"
#import "Booking_policy.h"
#import "DetailCellTableViewCell.h"
#import "HeaderView.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface DetailActivtyView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)AFHTTPSessionManager * manager;
@property(nonatomic, strong)UITableView * tableView;

//整个的大字典
@property(nonatomic, strong)NSDictionary * allDic;
//result的字典
@property(nonatomic, strong)NSDictionary * resultDic;
//预定需知
@property(nonatomic, strong)NSArray<Booking_policy *> * booking_policyArray;
//轮播图
@property(nonatomic, strong)NSArray * images;
//分类字典
@property(nonatomic, strong)NSDictionary * categoryDic;
//名字，标题
@property(nonatomic, strong)NSString * title;
//价格区间
@property(nonatomic, strong)NSString * price_info;
//时间区间
@property(nonatomic, strong)NSDictionary * timeDic;
//店名
@property(nonatomic, strong)NSString * poi;
//具体地址
@property(nonatomic, strong)NSString * address;
//描述
@property(nonatomic, strong)NSArray * descriptionArray;
//坐标
@property(nonatomic, strong)NSDictionary * locationDic;
@end

@implementation DetailActivtyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark
#pragma mark ========== 请求数据，多个字典
-(AFHTTPSessionManager *)manager{
    if (nil == _manager) {
        _manager = [AFHTTPSessionManager manager];
        NSSet * set = [[NSSet alloc] initWithObjects:@"text/html", @"application/json", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}
#pragma mark
#pragma mark ========= 数据下载
-(void)setLeo_id:(NSInteger)leo_id{
    _leo_id = leo_id;
    [self initForData];
}
-(void)initForData{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"leo_id"] = @(_leo_id);
    [self.manager GET:@"http://api.lanrenzhoumo.com/wh/common/leo_detail" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _allDic = [NSDictionary dictionary];
        _allDic = responseObject;
        _resultDic = [NSDictionary dictionaryWithDictionary:_allDic[@"result"]];
        _booking_policyArray = [Booking_policy mj_objectArrayWithKeyValuesArray:_resultDic[@"booking_policy"]];
        _images = _resultDic[@"images"];
        _categoryDic = _resultDic[@"category"];
        _title = _resultDic[@"title"];
        _price_info = _resultDic[@"price_info"];
        _timeDic = _resultDic[@"time"];
        _poi = _resultDic[@"poi"];
        _address = _resultDic[@"address"];
        _descriptionArray = _resultDic[@"description"];
        _locationDic = _resultDic[@"location"];
        [SVProgressHUD dismiss];
        [self initForView];
        [_tableView reloadData];
        self.downLoadFinish();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZZQLog(@"");
        [SVProgressHUD dismiss];
    }];
}
#pragma mark
#pragma mark ============ tableView 创建
-(void)initForView{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

#pragma mark
#pragma mark ============ 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _descriptionArray.count-1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_descriptionArray[indexPath.row][@"type"] isEqualToString:@"text"]) {
        CGSize mySize = CGSizeMake(self.width-20, CGFLOAT_MAX);
        CGSize size = [_descriptionArray[indexPath.row][@"content"] boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        return size.height + 10*size.height/21;
    }else{
        NSArray * size = _descriptionArray[indexPath.row][@"size"];
        float width = [size[0] floatValue];
        float height = [size[1] floatValue];
        return self.width*height/width+20;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (cell == nil) {
        cell = [[DetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
    }
    for(UIView *view in cell.subviews){
        if(view){
            [view removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setCellStyle:_descriptionArray[indexPath.row]];
    return cell;
}
//透视图，headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView * headerView = [[HeaderView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    [headerView setHeaderStyle:_images title:_title price_info:_price_info type:_categoryDic[@"cn_name"] iconStr:_categoryDic[@"icon_view"] timeStr:_timeDic[@"info"] locationStr:[NSString stringWithFormat:@"%@ · %@", _address, _poi]];
    
    [headerView setLocation:_locationDic[@"lon"] lat:_locationDic[@"lat"] poi:_poi address:_address picId:[_resultDic[@"template_id"] integerValue]];
    [headerView setSetLocation:^(float lon, float lat, NSString * poi, NSString * address, NSInteger picId) {
        MapDetailViewController * mapVC = [[MapDetailViewController alloc] init];
        self.jumpToMap(mapVC, lon, lat, _poi, _address, picId);
    }];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    float height = self.width;
    float titleHeight = [self rowHeightByString:_title font:[UIFont systemFontOfSize:24]]+10;
    height += 80;
    float timeHeight = [self rowHeightByString:_timeDic[@"info"] font:[UIFont systemFontOfSize:18]]+10;
    float locationHeight = [self rowHeightByString:[NSString stringWithFormat:@"%@ · %@", _address, _poi] font:[UIFont systemFontOfSize:18]]+10;
    height += 40+titleHeight+timeHeight+locationHeight+20;
    return height;
}
-(float)rowHeightByString:(NSString *)content font:(UIFont *)font{
    CGSize mySize = CGSizeMake(self.width-40, CGFLOAT_MAX);
    CGSize size = [content boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size.height;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 40) {
        self.changeNavbar();
    }else{
        self.changeNavbarBack();
    }
}

@end
