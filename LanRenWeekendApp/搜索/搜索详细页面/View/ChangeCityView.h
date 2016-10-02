//
//  ChangeCityView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDetailViewController.h"

@interface ChangeCityView : UIView

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, copy)void(^jumpToCity)(ShowDetailViewController * viewController, NSString * cityId, NSString * cityName);

@end
