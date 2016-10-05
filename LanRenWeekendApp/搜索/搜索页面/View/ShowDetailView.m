//
//  ShowDetailView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "ShowDetailView.h"
#import "AllActivitesTableViewCell.h"

#define CELL_ID @"allActivitesCell"
@interface ShowDetailView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UIImageView * errPic;
@end

@implementation ShowDetailView

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark
#pragma mark ======== 数据刷新方式
-(void)refresh{
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerAction)];
    _tableView.mj_header = _header;
//    [_tableView.mj_header beginRefreshing];
    
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerAction)];
    _footer.refreshingTitleHidden = YES;
    _footer.stateLabel.hidden = YES;
    _tableView.mj_footer = _footer;
}
-(void)headerAction{
    self.headerRefush();
}
-(void)endHeaderRefush{
    [_tableView.mj_header endRefreshing];
}
-(void)footerAction{
    self.footerRefush();
}
-(void)endFooterRefush{
    [_tableView.mj_footer endRefreshing];
}
#pragma mark
#pragma mark ========== 创建tableView
-(void)initForTableView{
//    ZZQLog(@"%ld", _allModelArray.count);
    if (_allModelArray.count != 0) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }else{
        _errPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _errPic.center = CGPointMake(self.width/2, self.height/2-20);
        _errPic.image = [UIImage imageNamed:@"ic_cat_cry_gray"];
        [self addSubview:_errPic];
    }
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
    if (_allModelArray.count > 0) {
        [cell setCellStyle:_allModelArray[indexPath.section]];
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZQLog(@"%ld", (long)indexPath.section);
    DetailActivtyViewController * detailVC = [[DetailActivtyViewController alloc] init];
    self.jumpToDetail(detailVC, [_allModelArray[indexPath.section] leo_id], [_allModelArray[indexPath.section] front_cover_image_list].firstObject, [_allModelArray[indexPath.section] title], [_allModelArray[indexPath.section] poi_name]);
}

-(NSMutableArray<AllActiviteModel *> *)allModelArray{
    if (_allModelArray == nil) {
        _allModelArray = [[NSMutableArray alloc] init];
    }
    return  _allModelArray;
}
-(void)setNewData:(NSMutableArray<AllActiviteModel *> *)allModels{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    _allModelArray = [[NSMutableArray alloc] init];
    NSArray<AllActiviteModel *> * tempArr = allModels;
    for (AllActiviteModel * model in tempArr) {
        [_allModelArray addObject:model];
    }
//    ZZQLog(@"数组长度 %ld", _allModelArray.count);
    [self initForTableView];
    [self refresh];
}
-(void)setData:(NSMutableArray *)allModels{
    NSArray<AllActiviteModel *> * tempArr = allModels;
    for (AllActiviteModel * model in tempArr) {
        [self.allModelArray addObject:model];
    }
//    ZZQLog(@"数组长度 %ld", _allModelArray.count);
//    [_tableView reloadData];
}

@end
