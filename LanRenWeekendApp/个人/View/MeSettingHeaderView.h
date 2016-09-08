//
//  MeSettingHeaderView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/7.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@protocol SettingViewControllerProtocol <NSObject>

-(void)jumpToSettingViewController:(SettingViewController *) settingVC;

@end

@interface MeSettingHeaderView : UICollectionReusableView

@property(nonatomic, assign)id<SettingViewControllerProtocol> delegate;

-(void)setMeheaderValue:(NSString *)name icon:(NSData *)iconImg;


@end
