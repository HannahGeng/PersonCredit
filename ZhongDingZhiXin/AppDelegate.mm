//
//  AppDelegate.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIScrollViewDelegate,CLLocationManagerDelegate>
{
    UIScrollView *scrollview;
    UIPageControl *pageControl;
    NSInteger width;
    NSInteger hight;
    UIImageView *_imageView;
    BOOL isOut;
    NSDictionary *dic;
    CLLocationManager * manager;
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
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"hHtSFomlKjDA3QxbIj0sCQYdLvrgMTu9"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //创建定位管理器
    manager = [[CLLocationManager alloc] init];
    
    //设置代理, 通过代理方法接收坐标
    manager.delegate = self;
    
    //开启定位
    [manager startUpdatingLocation];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
  
    NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
    NSString * blog = [defau objectForKey:@"first"];

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

//定位成功
-(void)locationManager:(CLLocationManager *)manager1 didUpdateLocations:(NSArray *)locations
{
    AppShare;
    
    //位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    app.coordinate = coordinate;
    
    //反地理编码(逆地理编码) : 把位置信息转换成地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"反地理编码失败!");
            return ;
        }
        
        //地址信息
        CLPlacemark *placemark = [placemarks firstObject];
        
        app.firAddress = [NSString stringWithFormat:@"%@ %@ %@",placemark.country,placemark.administrativeArea,placemark.locality];
        app.address = [NSString stringWithFormat:@"%@ %@ %@,%@",placemark.country,placemark.administrativeArea,placemark.locality,placemark.name];

    }];
    
    //停止定位
    [manager stopUpdatingLocation];
    

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
