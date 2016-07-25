//
//  PasswordViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/19.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordText;

@property (weak, nonatomic) IBOutlet UITextField *newpasswordText;

@property (weak, nonatomic) IBOutlet UITextField *twopasswordText;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NavBarType(@"修改密码");
    
    leftButton;
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmClick {
    
    AppShare;
    NSString * oldpass = [AESCrypt encrypt:self.oldPasswordText.text password:app.loginKeycode];
    NSString * newPass = [AESCrypt encrypt:self.newpasswordText.text password:app.loginKeycode];
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.request,@"request",app.uid,@"uid",newPass,@"newpass",oldpass,@"oldpass", nil];
    
    [[HTTPSessionManager sharedManager] POST:changePass parameters:pdic result:^(id responseObject, NSError *error) {
        
        NSLog(@"%@",responseObject);
        
        app.request = responseObject[@"response"];
        
    }];
}

- (IBAction)cancelClick {
    
    [self.navigationController popViewControllerAnimated:YES];    
}

@end
