//
//  AppDelegate.m
//  LanRenWeekendApp
//
//  Created by 张增强 on 16/8/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomerTabBarViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@property(nonatomic, strong)UserDB * userDB;
@property(nonatomic, strong)LocationDB * locationDB;
@property(nonatomic, strong)HotCityDB * hotCityDB;
@property(nonatomic, strong)FavouriteDB * favouriteDB;
@property(nonatomic, strong)InterestingPointDB * interDB;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _userDB = [[UserDB alloc] init];
    _locationDB = [[LocationDB alloc] init];
    _favouriteDB = [[FavouriteDB alloc] init];
    _interDB = [[InterestingPointDB alloc] init];
    _hotCityDB = [[HotCityDB alloc] init];
    ZZQLog(@"%@%@%@ %@ %@", _userDB, _locationDB, _favouriteDB, _interDB, _hotCityDB);
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    CustomerTabBarViewController * customerTabBarVC = [[CustomerTabBarViewController alloc] init];
//    customerTabBarVC.tabBar.backgroundColor = [UIColor whiteColor];
//    _window.rootViewController = customerTabBarVC;
    
#warning RootController change
    if ([UserDB queryIsExistUser]) {
//        主页面
        _window.rootViewController = customerTabBarVC;
    }else{
//        登录页面
        MainViewController * mainVC = [[MainViewController alloc] init];
        UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:mainVC];
        _window.rootViewController = nvc;
    }
     
    [_window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
