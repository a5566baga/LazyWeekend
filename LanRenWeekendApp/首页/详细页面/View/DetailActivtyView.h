//
//  DetailActivtyView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/9.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailActivtyView : UIView

@property(nonatomic, copy)void(^changeNavbar)();
@property(nonatomic, copy)void(^changeNavbarBack)();

@property(nonatomic, assign)NSInteger leo_id;
@property(nonatomic, strong)NSString * imageStr;
@property(nonatomic, strong)NSString * titleStr;
@property(nonatomic, strong)NSString * nameStr;

-(void)setLeo_id:(NSInteger)leo_id;

@end
