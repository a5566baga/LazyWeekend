//
//  UserFirstSettingViewController.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/3.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFirstSettingViewController : UIViewController

@property(nonatomic, strong)NSString * nickName;
@property(nonatomic, strong)NSString * iconStr;

-(void)setUserInfo:(NSString *)nickName iconStr:(NSString *)iconStr;

@end
