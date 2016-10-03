//
//  ShowDetailView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import "AllActiviteModel.h"
#import "DetailActivtyViewController.h"

@interface ShowDetailView : UIView

@property(nonatomic, copy)void(^jumpToDetail)(DetailActivtyViewController * detailVC, NSInteger leo_id, NSString * imageStr, NSString * titleStr, NSString * nameStr);
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray<AllActiviteModel *> * allModelArray;

@property(nonatomic, strong)MJRefreshNormalHeader * header;
@property(nonatomic, strong)MJRefreshAutoNormalFooter * footer;
@property(nonatomic, copy)void(^headerRefush)();
@property(nonatomic, copy)void(^footerRefush)();

-(void)refresh;
-(void)setNewData:(NSMutableArray<AllActiviteModel *> *)allModels;
-(void)setData:(NSMutableArray<AllActiviteModel *> *)allModels;
-(void)endHeaderRefush;
-(void)endFooterRefush;

@end
