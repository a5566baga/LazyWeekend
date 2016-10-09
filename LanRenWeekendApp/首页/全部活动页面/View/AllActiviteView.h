//
//  AllActiviteView.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailActivtyViewController.h"

@interface AllActiviteView : UIView

@property(nonatomic, copy)void(^jumpToDetail)(DetailActivtyViewController * detailVC, NSInteger leo_id, NSString * imageStr, NSString * titleStr, NSString * nameStr);

@property(nonatomic, copy)void(^changCity)();

@property(nonatomic, strong)UITableView * myTableView;

-(void)setLocation:(float)lon lat:(float)lat;

@end
