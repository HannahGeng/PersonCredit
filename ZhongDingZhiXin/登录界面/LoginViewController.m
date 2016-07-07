//
//  LoginViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    NSMutableArray *_cityInfoArray;
    NSDictionary *dic;
    MBProgressHUD * mbHud;
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
    
    //加载数据
    [self loadData];
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航栏
    [self setNavigationBar];
    
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil][0];
    self.view=view;
    
    //设置背景颜色
    [_userName setText:@"waiwai400@sina.com"];
    [_userPass setText:@"lx1437"];
    
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"登陆");
}

//加载数据
- (void)loadData
{
    AppShare;
    //初始化请求（同时也创建了一个线程）
    [[HTTPSessionManager sharedManager] GET:CANSHU_URL parameters:nil result:^(id responseObject, NSError *error) {
        
        dic=responseObject[@"result"];
        
        app.noLoginkeycode = [AESCrypt decrypt:dic[@"keycode"]];
    
    }];
    
}

#pragma mark - 登录按钮
- (IBAction)loginButton:(id)sender {
    
    [self.view endEditing:YES];
    
    mbHUDinit;
    
    if (_userName.text.length==0 && _userPass.text.length==0)
    {
        UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，输入你的账号密码就可以登录咯" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];
        
    }else{
        
        [self loginSuccess];
    }
}

- (IBAction)passButton:(id)sender {
}

- (IBAction)noteButton:(id)sender {
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

    //加密
    NSString *encryptionStr1 = [AESCrypt encrypt:_userName.text password:app.noLoginkeycode];
    NSString *encryptionStr2 = [AESCrypt encrypt:_userPass.text password:app.noLoginkeycode];

    NSDictionary *pDict = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"keycode"],@"keycode",encryptionStr1,@"username",encryptionStr2,@"userpass",nil];

    [[HTTPSessionManager sharedManager] POST:DENGLU_URL parameters:pDict result:^(id responseObject, NSError *error) {
        
        if ([responseObject[@"status"] intValue]== 1) {
            NSDictionary *dict = responseObject[@"result"];
            
            app.request = responseObject[@"response"];
            
            app.uid = dict[@"uid"];
            app.loginKeycode = [AESCrypt decrypt:dict[@"keycode"]];
            
             [self UntilSeccessDone];
            
        }else{
            
            UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"很抱歉" message:@"亲，你输入的账号或者密码有误" delegate:nil cancelButtonTitle:@"我看一下" otherButtonTitles:@"重新输入", nil];
            [alter show];
        }
    
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
