//
//  ChangCityHeaderView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitysModel.h"
#import "ShowDetailViewController.h"

@interface ChangCityHeaderView : UIView

@property(nonatomic, copy)void(^goToDetailVC)(ShowDetailViewController * vc, NSString * cityId, NSString * cityName);

-(void)setHotCityArray:(NSArray<CitysModel *> *)cityArray;

@end
