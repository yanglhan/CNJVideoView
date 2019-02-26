//
//  AppDelegate.m
//  CNJVideoView
//
//  Created by etz on 2019/1/26.
//  Copyright © 2019年 alibaba. All rights reserved.
//

#import "AppDelegate.h"
#import "CNJViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
        configure.backStyle             = GKNavigationBarBackStyleWhite;
        configure.titleFont             = [UIFont systemFontOfSize:18.0f];
        configure.titleColor            = [UIColor whiteColor];
        configure.gk_navItemLeftSpace   = 12.0f;
        configure.gk_navItemRightSpace  = 12.0f;
        configure.statusBarStyle        = UIStatusBarStyleLightContent;
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [UINavigationController rootVC:[CNJViewController new] translationScale:NO];
    nav.gk_openScrollLeftPush = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}


- (void)applicationDidEnterBackground:(UIApplication *)application {}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}


@end
