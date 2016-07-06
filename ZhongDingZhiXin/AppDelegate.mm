//
//  AppDelegate.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()<UIScrollViewDelegate>
{
    BMKMapManager *_mapManager;
    UIScrollView *scrollview;
    UIPageControl *pageControl;
    NSInteger width;
    NSInteger hight;
    UIImageView *_imageView;
    BOOL isOut;
}

@end

@implementation AppDelegate
+ (instancetype)sharedAppDelegate {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"S4R7t21HsAfEC6rv5BA1ori2" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
  
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString * blog = [defau objectForKey:@"first"];
    NSLog(@"%@",blog);
    if ([blog isEqualToString:@"2"]) {
        
        LoginViewController *loginVC=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController=navController;
        
    }else{
        
        ViewController *viewController=[[ViewController alloc] init];
        UINavigationController *navigation=[[UINavigationController alloc] initWithRootViewController:viewController];
        self.window.rootViewController=navigation;
    }
    
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
