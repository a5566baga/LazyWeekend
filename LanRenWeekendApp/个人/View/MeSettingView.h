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

@protocol MeSettingViewProtocal <NSObject>

-(void)jumpToNext:(SettingViewController *)settingVC;

@end

@interface MeSettingView : UIView

@property(nonatomic, strong)MeSettingHeaderView * headerView;

@property(nonatomic, assign)id<MeSettingViewProtocal> delegate;

@end
