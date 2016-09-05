//
//  LoginView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/29.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFirstSettingViewController.h"

@interface LoginView : UIView

@property(nonatomic, copy)void(^jumpToMain)(UserFirstSettingViewController * viewController);

@end
