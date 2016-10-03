//
//  UserFirstSettingView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/4.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserFirstSettingView : UIView

@property(nonatomic, strong)NSString * nickName;
@property(nonatomic, strong)NSString * iconStr;

@property(nonatomic, copy)void(^postDic)(NSMutableDictionary * dic);

-(void)setUserInfo:(NSString *)nickName iconStr:(NSString *)iconStr;

@end
