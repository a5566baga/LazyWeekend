//
//  AllActiviteView.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AllActiviteView.h"
#import "AllActivitesTableViewCell.h"
#import <AFNetworking.h>

#define CELL_ID @"allActivitesCell"
@interface AllActiviteView ()

@property(nonatomic, strong)UITableView * myTableView;

@end

@implementation AllActiviteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initForData];
        [self refresh];
        [self initForTableView];
    }
    return self;
}

#pragma mark
#pragma mark ======== 数据的处理
-(void)initForData{
    
}
#pragma mark
#pragma mark ======== 请求新数据
-(void)initForNewData{
    
}
#pragma mark
#pragma mark ======== 数据刷新方式
-(void)refresh{
    
}
#pragma mark
#pragma mark ======== tableView的创建
-(void)initForTableView{
    
}
#pragma mark
#pragma mark ======== layoutSubviews布局
-(void)layoutSubviews{
    
}

@end
