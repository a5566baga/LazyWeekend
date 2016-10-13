//
//  MapDetailViewController.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/10/5.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapDetailViewController : UIViewController

@property(nonatomic, assign)float lon;
@property(nonatomic, assign)float lat;
@property(nonatomic, strong)NSString * poi;
@property(nonatomic, strong)NSString * address;

-(void)setLocation:(float)lon lat:(float)lat poi:(NSString *)poi address:(NSString *)address picId:(NSInteger)picId;

@end
