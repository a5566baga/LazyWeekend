//
//  ShowDetailViewController.h
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/9/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowDetailViewController : UIViewController

@property(nonatomic, strong)NSString * cityId;
@property(nonatomic, strong)NSString * searchStr;
@property(nonatomic, strong)NSString * cityName;

-(void)setCityParamValue:(NSString *)cityStr;
-(void)setCitySearchStr:(NSString * )searchStr;

@end
