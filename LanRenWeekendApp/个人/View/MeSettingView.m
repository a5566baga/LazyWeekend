//
//  MeSettingView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MeSettingView.h"
#import "MeSettingCollectionViewCell.h"
#import "Favourtie.h"

#define CELL_ID @"collection_ID"
#define CELL_HEADER @"collection_HEADER"
@interface MeSettingView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SettingViewControllerProtocol>

@property(nonatomic, strong)UICollectionViewFlowLayout * layout;
@property(nonatomic, strong)UICollectionView * collectionView;

@end

@implementation MeSettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        请求数据，数据库内的数据(用户名，用户头像，收藏的内容)
        [self initForDataFromDB];
        //        设置内容
        [self initForView];
    }
    return self;
}

#pragma mark
#pragma mark =========== 请求数据
-(void)initForDataFromDB{
// 请求的数据是在收藏的那里点击按钮之后
    
}


#pragma mark
#pragma mark ============ 创建视图
-(void)initForView{
    float margin = 10;
    float itemWidth = (self.width-3*margin)/2;
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = margin;
    _layout.minimumInteritemSpacing = margin;
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.itemSize = CGSizeMake(itemWidth, itemWidth*1.4);
    _layout.sectionInset = UIEdgeInsetsMake(margin, margin, 0, margin);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    _collectionView.bounces = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[MeSettingHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELL_HEADER];
    [_collectionView registerClass:[MeSettingCollectionViewCell class]forCellWithReuseIdentifier:CELL_ID];
}
#pragma mark
#pragma mark ========== collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//数据库取出数据的个数
    NSArray * array = [FavouriteDB queryAllFavourite];
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MeSettingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MeSettingCollectionViewCell alloc] init];
    }
    Favourtie * fav = [FavouriteDB queryAllFavourite][indexPath.row];
    [cell setCellStyle:fav.title name:fav.poi_name pic:fav.pic];
    return cell;
}
//headerView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    _headerView = (MeSettingHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELL_HEADER forIndexPath:indexPath];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.delegate = self;
//    [_headerView setMeheaderValue:nil icon:nil];
    return _headerView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    float height = 230 + self.width/3 + 2*20 + 50;
    CGSize size = CGSizeMake(300, height);
    return size;
}
//是否中的cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    页面跳转到二级页面，传参数拼接成一个url
    ZZQLog(@"%ld 个人cell 选中", (long)indexPath.row);
    Favourtie * fav = [FavouriteDB queryAllFavourite][indexPath.row];
    DetailActivtyViewController * detailVC = [[DetailActivtyViewController alloc] init];
    self.jumpToDetailView(detailVC, fav.leo_id);
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZQLog(@"%ld 个人cell 取消", (long)indexPath.row);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 40) {
        self.changeWhriteTitle();
    }else if(scrollView.contentOffset.y < 40){
        self.changeBlackTitle();
    }
}
#pragma mark
#pragma mark ========== 页面的设置跳转
-(void)jumpToReserveViewController:(ReserveViewController *)reserveVC{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(jumpToNextRes:)]) {
        [self.delegate jumpToNextRes:reserveVC];
    }
}
-(void)jumoToInterestViewController:(InterestPointViewController *)interestVC{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(jumpToNextInter:)]) {
        [self.delegate jumpToNextInter: interestVC];
    }
}
-(void)jumpToSettingViewController:(SettingViewController *)settingVC{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(jumpToNext:)]) {
        [self.delegate jumpToNext:settingVC];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
