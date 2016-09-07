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

@interface SearchViewController ()<UISearchResultsUpdating, UISearchControllerDelegate>

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
#pragma mark
#pragma mark ========== 一个Button一个搜索
-(void)initForTitleView{
#warning 这里的Button参数也是第一次进来的时候定位获得的
    _citySelButton = [CityButtonLayoutImg buttonWithType:UIButtonTypeCustom];
    [_citySelButton setImage:[UIImage imageNamed:@"ic_nav_down"] forState:UIControlStateNormal];
    [_citySelButton setImage:[UIImage imageNamed:@"ic_nav_down"] forState:UIControlStateHighlighted];
    _citySelButton.frame = CGRectMake(0, 0, 60, 49);
    NSAttributedString * string = [[NSAttributedString alloc] initWithString:@"郑州" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light"size:18]}];
    [_citySelButton setAttributedTitle:string forState:UIControlStateNormal];
    _citySelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_citySelButton];
    [_citySelButton addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;
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
    NSAttributedString * cancelStr = [[NSAttributedString alloc] initWithString:@"取消" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gotham-Light"size:18],}];
    [canceLBtn setAttributedTitle:cancelStr forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor colorWithRed:0.098 green:0.098 blue:0.098 alpha:1.0] forState:UIControlStateNormal];
}
-(void)selectCity:(UIButton *)button{
#warning create View to Show citys
    
}
#pragma mark
#pragma mark =========== searchController的代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}
#pragma mark
#pragma mark =========== 主页面的内容
-(void)initForView{
    _collectionView = [[BodyCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-49)];
    [self.view addSubview:_collectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.searchController.searchBar becomeFirstResponder];
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
