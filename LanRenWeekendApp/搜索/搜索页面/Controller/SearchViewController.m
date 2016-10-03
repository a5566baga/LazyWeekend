//
//  SearchViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "SearchViewController.h"
#import "CityButtonLayoutImg.h"
#import "BodyCollectionView.h"
#import "ChangeCityViewController.h"
#import "ShowDetailViewController.h"

@interface SearchViewController ()<UISearchResultsUpdating, UISearchControllerDelegate,UISearchBarDelegate>

//titleView
@property(nonatomic, strong)UISearchController * searchController;
@property(nonatomic, strong)CityButtonLayoutImg * citySelButton;
@property(nonatomic, strong)BodyCollectionView * collectionView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    设置nav的内容
    [self initForTitleView];
//    设置view的内容
    [self initForView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSString * cityName = [self getLocationCityName];
//    [_citySelButton setTitle:cityName forState:UIControlStateNormal];
    [self initForTitleView];
}
#pragma mark
#pragma mark ========== 一个Button一个搜索
-(void)initForTitleView{
    _citySelButton = [CityButtonLayoutImg buttonWithType:UIButtonTypeCustom];
    [_citySelButton setImage:[UIImage imageNamed:@"ic_nav_down"] forState:UIControlStateNormal];
    [_citySelButton setImage:[UIImage imageNamed:@"ic_nav_down"] forState:UIControlStateHighlighted];
    _citySelButton.frame = CGRectMake(0, 0, 60, 49);
    
    NSString * cityName = [self getLocationCityName];
    NSAttributedString * string = nil;
    string = [[NSAttributedString alloc] initWithString:cityName attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light"size:18]}];
    [_citySelButton setAttributedTitle:string forState:UIControlStateNormal];
    _citySelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_citySelButton];
    [_citySelButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchController.searchBar.x += 80;
    _searchController.searchBar.y += 20;
    _searchController.searchBar.width = self.view.width - CGRectGetMaxX(_citySelButton.frame)-10;
    _searchController.searchBar.showsCancelButton = YES;
    _searchController.searchBar.placeholder = @"搜索活动或地点";
    self.navigationItem.titleView = _searchController.searchBar;
    self.definesPresentationContext = YES;
    
    UIButton *canceLBtn = [_searchController.searchBar valueForKey:@"cancelButton"];
    NSAttributedString * cancelStr = [[NSAttributedString alloc] initWithString:@"取消" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light"size:16],}];
    [canceLBtn setAttributedTitle:cancelStr forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0] forState:UIControlStateNormal];
}
-(void)selectCity:(UIButton *)button{
    ChangeCityViewController * changeCityVC = [[ChangeCityViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:changeCityVC];
    [self presentViewController:nvc animated:YES completion:nil];
}
#pragma mark
#pragma mark =========== searchController的代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
}
//向详细页面传参数
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    ShowDetailViewController * showDetailVC = [[ShowDetailViewController alloc] init];
    [showDetailVC setCityName:searchBar.text];
    [showDetailVC setCitySearchStr:searchBar.text];
    [self.navigationController pushViewController:showDetailVC animated:YES];
}
#pragma mark
#pragma mark =========== 主页面的内容
-(void)initForView{
    _collectionView = [[BodyCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    [self.view addSubview:_collectionView];
    
    typeof(self) myself = self;
    [_collectionView setJumpToShowDetailVC:^(ShowDetailViewController * showDetailVC, NSString * category, NSString * cityName) {
        [showDetailVC setCitySearchStr:category];
        [showDetailVC setCityName:cityName];
        [myself.navigationController pushViewController:showDetailVC animated:YES];
    }];
}

#pragma mark
#pragma mark ========= 工具类
-(NSString *)getLocationCityName{
    NSString * cityName;
    if ([LocationDB queryLocation].firstObject.cityName != nil) {
        cityName = [LocationDB queryLocation].firstObject.cityName;
    }else{
        cityName = @"未知";
    }
    return cityName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
