//
//  ChangCityHeaderView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ChangCityHeaderView.h"

@interface ChangCityHeaderView ()

//读取数据库中，自己存储的本地地址
@property(nonatomic, strong)UILabel * locationLabel;
@property(nonatomic, strong)UIButton * locationButton;
//读取数据库，最近浏览的3的地方
@property(nonatomic, strong)UILabel * recentLabel;
@property(nonatomic, strong)UIButton * recentButton;

//从网上请求下来的数据
@property(nonatomic, strong)UIButton * hotCityButton;
@property(nonatomic, strong)UILabel * hotCityLabel;

@property(nonatomic, strong)UILabel * allCityLabel;

@property(nonatomic, strong)NSArray<CitysModel *> * cityArray;
@end

@implementation ChangCityHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)initForView{
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:18];
    _locationLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    _locationLabel.text = @"当前所在的城市";
    [self addSubview:_locationLabel];
    
    _locationButton = [[UIButton alloc] init];
    NSString * cityName = [self getLocationCityName];
    if ([cityName isEqualToString:@""]) {
        [_locationButton setTitle:@"未知" forState:UIControlStateNormal];
    }else{
        [_locationButton setTitle:cityName forState:UIControlStateNormal];
    }
    [_locationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _locationButton.backgroundColor = [UIColor blackColor];
    _locationButton.layer.cornerRadius = 5;
    [self addSubview:_locationButton];
    
    _recentLabel = [[UILabel alloc] init];
    _recentLabel.text = @"最近浏览";
    _recentLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:18];
    _recentLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    [self addSubview:_recentLabel];
    
    _hotCityLabel = [[UILabel alloc] init];
    _hotCityLabel.text = @"热门城市";
    _hotCityLabel.adjustsFontSizeToFitWidth = YES;
    _hotCityLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    _hotCityLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:18];
    [self addSubview:_hotCityLabel];
    
    _allCityLabel = [[UILabel alloc] init];
    _allCityLabel.textColor = [UIColor colorWithRed:0.702 green:0.702 blue:0.702 alpha:1.0];
    _allCityLabel.font = [UIFont fontWithName:@"Lantinghei_0" size:18];
    _allCityLabel.text = @"全部城市";
    [self addSubview:_allCityLabel];
}

-(void)layoutSubviews{
    float lo_leftMargin = 30;
    float lo_topMargin = 20;
    _locationLabel.frame = CGRectMake(lo_leftMargin, lo_topMargin, 150, 30);
    _locationButton.frame = CGRectMake(self.width-120, 10, 70, 35);
    
    float rec_leftMargin = 20;
    float rec_topMargin = 10;
    _recentLabel.frame = CGRectMake(rec_leftMargin, CGRectGetMaxY(_locationButton.frame)+rec_topMargin, 120, 30);
    float rec_width = self.width/5;
    float rec_margin = 40;
//热门城市
    for (NSInteger i = 0; i < [HotCityDB queryLocation].count; i++) {
        _recentButton = [[UIButton alloc] init];
        _recentButton.layer.borderWidth = 1;
        _recentButton.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
        _recentButton.layer.cornerRadius = 5;
        _recentButton.frame = CGRectMake(lo_leftMargin+(rec_width+rec_margin)*i, CGRectGetMaxY(_recentLabel.frame)+rec_topMargin, rec_width, 35);
        [_recentButton setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:UIControlStateNormal];
        [_recentButton setTitle:[HotCityDB queryLocation][i].hotCityName forState:UIControlStateNormal];
        _recentButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _recentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_recentButton addTarget:self action:@selector(cityAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_recentButton];
    }
    
    _hotCityLabel.frame = CGRectMake(rec_leftMargin, CGRectGetMaxY(_recentLabel.frame)+2*rec_topMargin+35, 120, 30);
    
    for (NSInteger i = 0; i < _cityArray.count; i++) {
        _hotCityButton = [[UIButton alloc] init];
        _hotCityButton.frame = CGRectMake(lo_leftMargin+(rec_width+rec_margin)*(i%3), CGRectGetMaxY(_hotCityLabel.frame)+rec_leftMargin+(i/3)*(35+lo_topMargin), rec_width, 35);
        _hotCityButton.layer.borderColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0].CGColor;
        _hotCityButton.layer.borderWidth = 1;
        [_hotCityButton setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
        [_hotCityButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCityButton setTitle:[_cityArray[i] city_name] forState:UIControlStateNormal];
        _hotCityButton.layer.cornerRadius = 5;
        _hotCityButton.tag = 800+i;
        [_hotCityButton addTarget:self action:@selector(hotCityAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hotCityButton];
    }
    
    _allCityLabel.frame = CGRectMake(20, CGRectGetMaxY(_hotCityButton.frame)+20, 120, 35);
}
-(void)hotCityAction:(UIButton *)btn{
    NSInteger index = btn.tag-800;
    if (![HotCityDB isExistsCity:[_cityArray[index] city_name]]) {
        if ([HotCityDB queryLocation].count >= 3) {
            [HotCityDB deleteLocation];
            [HotCityDB addLocation:[_cityArray[index] city_name] city_id:[_cityArray[index] city_id]];
        }else{
            [HotCityDB addLocation:[_cityArray[index] city_name] city_id:[_cityArray[index] city_id]];
        }        
    }
    ShowDetailViewController * showVC = [[ShowDetailViewController alloc] init];
    self.goToDetailVC(showVC, @([_cityArray[index] city_id]).stringValue, [_cityArray[index] city_name]);
}
-(void)cityAction:(UIButton *)btn{
    ShowDetailViewController * showVC = [[ShowDetailViewController alloc] init];
    NSString * cityId = [HotCityDB queryLocationByCityName:btn.currentTitle];
    self.goToDetailVC(showVC, cityId, btn.currentTitle);
}

-(void)setHotCityArray:(NSArray<CitysModel *> *)cityArray{
    _cityArray = cityArray;
//    创建
    [self initForView];
}
#pragma mark
#pragma mark =========== 工具类
//获取城市名
-(NSString *)getLocationCityName{
    NSString * cityName = [LocationDB queryLocation].firstObject.cityName;
    return cityName;
}

@end
