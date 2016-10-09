//
//  MeSettingView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"
#import "MeSettingHeaderView.h"
#import "InterestPointViewController.h"
#import "ReserveViewController.h"
#import "DetailActivtyViewController.h"

@protocol MeSettingViewProtocal <NSObject>

-(void)jumpToNext:(SettingViewController *)settingVC;
-(void)jumpToNextInter:(InterestPointViewController *)interestVC;
-(void)jumpToNextRes:(ReserveViewController *)reseverVC;

@end

@interface MeSettingView : UIView

@property(nonatomic, strong)void(^jumpToDetailView)(DetailActivtyViewController * detailVC, NSInteger leo_id);

@property(nonatomic, strong)void(^changeWhriteTitle)();
@property(nonatomic, strong)void(^changeBlackTitle)();

@property(nonatomic, strong)MeSettingHeaderView * headerView;

@property(nonatomic, assign)id<MeSettingViewProtocal> delegate;

@end
