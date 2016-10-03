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
//分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"


#define SHARE_KEY @"179dc208e6be3"
@interface AppDelegate ()

@property(nonatomic, strong)UserDB * userDB;
@property(nonatomic, strong)LocationDB * locationDB;
@property(nonatomic, strong)HotCityDB * hotCityDB;
@property(nonatomic, strong)FavouriteDB * favouriteDB;
@property(nonatomic, strong)InterestingPointDB * interDB;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self sharedAction];
    
    
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

-(void)sharedAction{
        /**
         *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
         *  在将生成的AppKey传入到此方法中。
         *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
         *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
         *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
         */
    [ShareSDK registerApp:SHARE_KEY
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                     
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"3392544999"
                                                appSecret:@"da07195ce907d5feff584074cb41bb50"
                                              redirectUri:@"http://sns.whalecloud.com/sina2/callback"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      //设置微信应用信息
                      [appInfo SSDKSetupWeChatByAppId:@"wx79ccb55c65ad5aa2"
                                            appSecret:@"ee90aeae54e322122d51dac1004246a8"];
                      break;
                  case SSDKPlatformTypeQQ:
                      //设置QQ应用信息，其中authType设置为只用SSO形式授权
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeSSO];
                      break;
                  default:
                      break;
              }
          }];
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
