//
//  AppDelegate.m
//  GHLoan
//
//  Created by Lin on 2017/8/24.
//  Copyright © 2017年 国恒金服. All rights reserved.
//

#import "AppDelegate.h"
#import "GHTabBarController.h"
#import "GHGestureModifyController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [GHTabBarController new];
    [self.window makeKeyAndVisible];
    
    // 手势密码
    [self showGestureLockView];
    
    
    UIApplication *app = [UIApplication sharedApplication];
    id value;
    
    // iphone x
    if (iPhone_X) {
         value = [[app valueForKey:@"statusBar"] valueForKeyPath:@"statusBar"];
        id value2 = [value valueForKey:@"currentData"];
        id value3 = [[value2 valueForKey:@"wifiEntry"] valueForKey:@"status"];
    } else {
        value = [app valueForKeyPath:@"statusBar"];
        UIView * value2 = [value valueForKey:@"foregroundView"];
        NSArray *children = value2.subviews;
        int netType = 0;
        //获取到网络返回码
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                //获取到状态栏
                netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
                
            }
        }
    }
   
    
    return YES;
}

- (void)showGestureLockView
{
    NSString * gesture = [QLCircleViewConst getGestureWithKey:gestureFinalSaveKey];
    if (gesture) {
        GHGestureModifyController *gestureVC = [GHGestureModifyController new];
        gestureVC.isfromMainView = YES;
        self.window.rootViewController = gestureVC;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // 手势密码
    [self showGestureLockView];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
