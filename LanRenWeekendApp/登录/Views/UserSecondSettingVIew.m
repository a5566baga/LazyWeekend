//
//  UserSecondSettingVIew.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/4.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "UserSecondSettingVIew.h"
#import "UserSecondSettingCollectionViewCell.h"


static NSString * cellId = @"cellID";
@interface UserSecondSettingVIew ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout * layout;

@property(nonatomic, strong)NSArray * imageArray;
@property(nonatomic, strong)NSArray * onclickImageArray;
@property(nonatomic, strong)NSArray * titleArray;

//数据库的接口，填写兴趣标签的选中状态
@property(nonatomic, strong)NSMutableDictionary * interestStatus;

@end

@implementation UserSecondSettingVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = @[@"ic_c_montain_gray", @"ic_c_bar_gray", @"ic_c_music_gray", @"ic_c_stage_gray", @"ic_c_pic_gray", @"ic_c_eat_gray", @"ic_c_bag_gray", @"ic_c_movie_gray",  @"ic_c_persons_gray", @"ic_c_backetball_gray", @"ic_c_leaf_gray", @"ic_c_shirt_gray"];
        
_onclickImageArray = @[@"ic_c_montain", @"ic_c_bar", @"ic_c_music", @"ic_c_stage",  @"ic_c_pic", @"ic_c_eat", @"ic_c_bag", @"ic_c_movie", @"ic_c_persons", @"ic_c_backetball", @"ic_c_leaf", @"ic_c_shirt"];
        _titleArray = @[@"周边游", @"酒吧", @"音乐", @"戏剧", @"展览", @"美食", @"购物", @"电影", @"聚会", @"运动", @"公益", @"商业"];
        _interestStatus = [NSMutableDictionary dictionary];
        for (NSString * title in _titleArray) {
            [_interestStatus setObject:@(NO) forKey:title];
        }
        [self initForView];
    }
    return self;
}
#pragma mark
#pragma mark ========== 创建视图
-(void)initForView{
    float margin = 10;
    float width = (self.width-4*margin)/3;
    //创建视图
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(width, width);
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 5;
    _layout.sectionInset = UIEdgeInsetsMake(-20, 10, 0, 10);
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    _collectionView.allowsMultipleSelection = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[UserSecondSettingCollectionViewCell class] forCellWithReuseIdentifier:cellId];
}
#pragma mark
#pragma mark ========= 布局视图
-(void)layoutSubviews{
    //布局视图
    [super layoutSubviews];
    self.postInterestStatus(_interestStatus);
}
#pragma mark
#pragma mark ========= delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    在cell中赋值的时候，对应的5和4应该改一下字体
    UserSecondSettingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    [cell setCellDetail:_onclickImageArray[indexPath.row] imageCancel:_imageArray[indexPath.row] titleName:_titleArray[indexPath.row]];
    return cell;
}
//选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected === %ld", indexPath.row);
    [self.interestStatus setObject:@(YES) forKey:_titleArray[indexPath.row]];
    
    self.postInterestStatus(self.interestStatus);
}
//取消
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cancel === %ld", indexPath.row);
    [self.interestStatus setObject:@(NO) forKey:_titleArray[indexPath.row]];
    
    self.postInterestStatus(self.interestStatus);
}


@end
