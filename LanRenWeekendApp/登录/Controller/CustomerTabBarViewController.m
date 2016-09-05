//
//  CustomerTabBarViewController.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/31.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "CustomerTabBarViewController.h"
#import "AllActivitesViewController.h"
#import "SearchViewController.h"
#import "HelpViewController.h"
#import "MeSettingViewController.h"
#import "CustomTabBar.h"
#import "CustomerNavViewController.h"
#import "MainViewController.h"

@interface CustomerTabBarViewController ()

@end

@implementation CustomerTabBarViewController

+(void)initialize{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStyleWithImage:@"ic_first_normal" selectImage:@"ic_first_pressed" viewController:[[AllActivitesViewController alloc] init]];
    
    [self setStyleWithImage:@"ic_second_normal" selectImage:@"ic_second_pressed" viewController:[[SearchViewController alloc] init]];
    
    [self setStyleWithImage:@"ic_third_normal" selectImage:@"ic_third_pressed" viewController:[[HelpViewController alloc] init]];
    
    [self setStyleWithImage:@"ic_fourth_normal" selectImage:@"ic_fourth_pressed" viewController:[[MeSettingViewController alloc] init]];
    
    [self setValue:[[CustomTabBar alloc] init] forKey:@"tabBar"];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)setStyleWithImage:(NSString *)imageStr selectImage:(NSString *)selectImageStr viewController:(UIViewController *)viewController{
    CustomerNavViewController * nvc = [[CustomerNavViewController alloc] initWithRootViewController:viewController];
    
    [nvc.tabBarItem setImage:[UIImage imageNamed:imageStr]];
    [nvc.tabBarItem setSelectedImage:[UIImage imageNamed:selectImageStr]];
    
    [self addChildViewController:nvc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
