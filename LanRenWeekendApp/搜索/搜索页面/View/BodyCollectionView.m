//
//  BodyCollectionView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/6.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "BodyCollectionView.h"
#import "BodyCollectionViewCell.h"
#import "SearchTypeModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

#define CELL_ID @"collectionCell"
@interface BodyCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionViewFlowLayout * layout;
@property(nonatomic, strong)UICollectionView * collectionView;

@property(nonatomic, strong)NSArray * titleArray;
@property(nonatomic, strong)NSArray * imgArray;

@property(nonatomic, strong)NSArray<SearchTypeModel *> * modelArray;

@property(nonatomic, strong)AFHTTPSessionManager * manager;

@end

@implementation BodyCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForData];
         [self initForView];
    }
    return self;
}
#pragma mark
#pragma mark ======== 初始化界面展示的数据
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        NSSet * set = [[NSSet alloc] initWithObjects:@"text/html", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}
-(void)initForData{
    NSString * url = @"http://api.lanrenzhoumo.com/wh/common/cats?session_id=00004061a9f934aa1954907af22163863e8d00&v=2";
    [SVProgressHUD show];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _modelArray = [SearchTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [SVProgressHUD dismiss];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark
#pragma mark ======== 创建collectionView
-(void)initForView{
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 5;
    _layout.minimumInteritemSpacing = 5;
    _layout.itemSize = CGSizeMake((self.width-50)/2, 80);
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.sectionInset = UIEdgeInsetsMake(20, 15, 0, 15);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[BodyCollectionViewCell class]forCellWithReuseIdentifier:CELL_ID];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}
#pragma mark
#pragma mark ========= collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _modelArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BodyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
    [cell cellSetStyle:[_modelArray[indexPath.row] cn_name] image:[_modelArray[indexPath.row] icon_view]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
#warning 拼接数据接口
    NSLog(@"select === %ld", indexPath.row);
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cancel === %ld", indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
