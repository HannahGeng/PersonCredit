//
//  RegisterViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NavBarType(@"签到记录");
    leftButton;
    
    [self loadData];
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)loadData
{
//    "client"  用户姓名
//    "contact"  联系人
//    "contacttel" 联系电话
//    "coordinate" 坐标
//    "locatime" 时间
//    "location" 地址
    AppShare;
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",app.name,@"client", nil];
    [[HTTPSessionManager sharedManager] POST:JIANDAO_URL parameters:pdic result:^(id responseObject, NSError *error) {
       
        NSLog(@"签到记录:%@",responseObject);
        
    }];
}

@end
