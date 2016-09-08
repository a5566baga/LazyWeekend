//
//  MeSettingView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MeSettingView.h"
#import "MeSettingCollectionViewCell.h"

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
#warning 数据库取出数据的个数
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MeSettingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MeSettingCollectionViewCell alloc] init];
    }
    
    return cell;
}
//headerView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    _headerView = (MeSettingHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CELL_HEADER forIndexPath:indexPath];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.delegate = self;
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
    NSLog(@"%ld 个人cell 选中", indexPath.row);
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld 个人cell 取消", indexPath.row);
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
