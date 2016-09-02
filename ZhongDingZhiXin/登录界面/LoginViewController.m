//
//  LoginViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<CLLocationManagerDelegate>
{
    NSMutableArray *_cityInfoArray;
    MBProgressHUD * mbHud;
    NSDictionary *dic;
    CLLocationManager * _manager;
}

@property (strong, nonatomic) IBOutlet UIView *headImageView;
@property (strong, nonatomic) IBOutlet UIView *passImageView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UIView *phoneInageView;
@property (weak, nonatomic) IBOutlet UITextField *userPass;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.hidesBackButton = YES;
    
    //设置导航栏
    [self setNavigationBar];
    
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil][0];
    self.view=view;
    
    //读取用户名和密码
    _userName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"user"];
    
    _userPass.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"pass"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHUDinit;

            //创建定位管理器
            _manager = [[CLLocationManager alloc] init];
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
                [_manager requestAlwaysAuthorization]; //总是定位
                [_manager requestWhenInUseAuthorization]; //在使用期间定位
            }

            _manager.delegate = self;

            //开启定位
            [_manager startUpdatingLocation];

            [self loadData];
            
        }else
        {
            noWebhud;
        }
        
    }];

}

- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

-(void)locationManager:(CLLocationManager *)manager1 didUpdateLocations:(NSArray *)locations
{
    
    AppShare;
    
    //位置信息
    CLLocation *location = [locations firstObject];
    
    //定位到的坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    app.coordinate = coordinate;
    
    //反地理编码(逆地理编码) : 把位置信息转换成地址信息
    //地理编码 : 把地址信息转换成位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"反地理编码失败!");
            return ;
        }
        
        //地址信息
        CLPlacemark *placemark = [placemarks firstObject];
        
        app.firAddress = [NSString stringWithFormat:@"%@%@", placemark.country, placemark.locality];
        
        app.address = placemark.name;
    }];
    
    //停止定位
    [_manager stopUpdatingLocation];
}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@", error);
}

- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

- (void)loadData
{
    //加载数据
    AppShare;
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] GET:CANSHU_URL parameters:nil result:^(id responseObject, NSError *error) {
        
        if ([responseObject[@"status"] integerValue] == 1) {
            
            hudHide;
            
            dic=responseObject[@"result"];
            
            app.noLoginkeycode = [AESCrypt decrypt:dic[@"keycode"]];
            
        }
        
    }];

}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"登陆");
}

#pragma mark - 登录按钮
- (IBAction)loginButton:(id)sender {
    
    [self.view endEditing:YES];
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            mbHUDinit;

            if (_userName.text.length==0 || _userPass.text.length==0)
            {
                hudHide;
                
                MBhud(@"输入你的账号密码就可以登录咯");
                
            }else{
                
                [self loginSuccess];
                
            }
            
        }else
        {
            noWebhud;
        }
        
    }];

}

- (IBAction)forgetPass {
        
    ForgetPassWebViewController * forget = [[ForgetPassWebViewController alloc] init];
    
    [self.navigationController pushViewController:forget animated:YES];
}

//键盘退下事件的处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
} 

//登录成功时候调用该方法
-(void)loginSuccess
{
    AppShare;
    
    //保存用户名和密码
    [[NSUserDefaults standardUserDefaults] setObject:_userName.text forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] setObject:_userPass.text forKey:@"pass"];

    //加密
    NSString *encryptionStr1 = [AESCrypt encrypt:_userName.text password:app.noLoginkeycode];
    NSString *encryptionStr2 = [AESCrypt encrypt:_userPass.text password:app.noLoginkeycode];

    NSDictionary *pDict = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"keycode"],@"keycode",encryptionStr1,@"username",encryptionStr2,@"userpass",nil];

    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:DENGLU_URL parameters:pDict result:^(id responseObject, NSError *error) {
                
                if ([responseObject[@"status"] intValue]== 1) {
                    
                    NSDictionary *dict = responseObject[@"result"];
                    
                    app.request = responseObject[@"response"];
                    
                    app.uid = dict[@"uid"];
                    app.loginKeycode = [AESCrypt decrypt:dict[@"keycode"]];
                    
                    [self loadFirst];
                    
                }else{
                    
                    hudHide;
                    
                    MBhud(@"你输入的账号或者密码有误");
                    
                }
                
            }];

        }else
        {
            hudHide;
            noWebhud;
        }
        
    }];

}

- (void)loadFirst
{
    AppShare;
    
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] POST:GGTZ_URL parameters:Dic result:^(id responseObject, NSError *error) {
            
        NSArray *array = responseObject[@"result"];
        
        app.firstArray = array;
        
        if (array.count!=0) {
            
            app.request = responseObject[@"response"];
            
        }
        
        [self loadMessage];
        
    }];
}

- (void)loadMessage
{
    AppShare;
    
    [[HTTPSessionManager sharedManager] POST:ZUOZHENG_URL parameters:Dic result:^(id responseObject, NSError *error) {
        
        app.mobilephone = [AESCrypt decrypt:responseObject[@"result"][@"mobilephone"] password:app.loginKeycode];
        
        NSString * name = [AESCrypt decrypt:responseObject[@"result"][@"realname"] password:app.loginKeycode];
        
        app.name = name;
                
        app.request = responseObject[@"response"];
        
        app.http = [AESCrypt decrypt:responseObject[@"result"][@"http"] password:app.loginKeycode];
        
        app.avatar = [AESCrypt decrypt:responseObject[@"result"][@"avatar"] password:app.loginKeycode];
        
        [self UntilSeccessDone];
        
    }];
    
}

//登陆成功后调用的方法
-(void)UntilSeccessDone
{
    hudHide;
    KSTabBarController *tabBarC=[[KSTabBarController alloc]init];
    tabBarC.selectedIndex=2;
    self.view.window.rootViewController=tabBarC;
}

@end
