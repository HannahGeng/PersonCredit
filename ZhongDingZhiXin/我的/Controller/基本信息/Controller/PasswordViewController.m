//
//  PasswordViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/19.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()<UITextFieldDelegate>
{
    MBProgressHUD * mbHud;
}

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordText;

@property (weak, nonatomic) IBOutlet UITextField *newpasswordText;

@property (weak, nonatomic) IBOutlet UITextField *twopasswordText;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NavBarType(@"修改密码");
    
    leftButton;
    
    _oldPasswordText.tag = 1;
    _newpasswordText.tag = 2;
    _twopasswordText.tag = 3;
    [_oldPasswordText becomeFirstResponder];
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmClick {
    
    [self.view endEditing:YES];
    
    AppShare;
    NSString * oldpass = [AESCrypt encrypt:self.oldPasswordText.text password:app.loginKeycode];
    NSString * newPass = [AESCrypt encrypt:self.newpasswordText.text password:app.loginKeycode];
    
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.request,@"request",app.uid,@"uid",newPass,@"newpass",oldpass,@"oldpass", nil];
    
    if (self.oldPasswordText.text.length == 0 || self.newpasswordText.text.length == 0 || self.twopasswordText.text.length == 0) {
        
        MBhud(@"信息不完善");
        
    }else if (![self.newpasswordText.text isEqualToString:self.twopasswordText.text]){
        
        MBhud(@"两次密码输入不一致");
        
    }else if (_newpasswordText.text.length < 6){
        
        MBhud(@"密码必须大于6位数");
        
    }else{
     
        AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager] POST:changePass parameters:pdic result:^(id responseObject, NSError *error) {
                    
                    NSLog(@"%@",responseObject);
                    
                    app.request = responseObject[@"response"];
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        
                        MBhud(@"密码修改成功");
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            LoginViewController * login = [[LoginViewController alloc] init];
                            
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pass"];
                            
                            [self.navigationController pushViewController:login animated:YES];
                            
                            [login.userPass becomeFirstResponder];
                                                        
                        });
                        
                    }else{
                        
                        MBhud(responseObject[@"result"]);
                    }
                    
                }];
                
            }else
            {
                noWebhud;
            }
            
        }];

    }
    
}

- (IBAction)cancelClick {
    
    [self.navigationController popViewControllerAnimated:YES];    
}

#pragma mark - textfield代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_oldPasswordText.tag == 1) {
        NSString * phoneString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (phoneString.length > 16 && range.length != 1) {
            
            _oldPasswordText.text = [phoneString substringToIndex:16];
            return NO;
            
        }
        
    }else if (_newpasswordText.tag == 2){
        
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (passString.length > 16 && range.length != 1) {
            _newpasswordText.text = [passString substringToIndex:16];
            return NO;
        }
        
    }else if(_twopasswordText.tag == 3){
        NSString * passString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (passString.length > 16 && range.length != 1) {
            _twopasswordText.text = [passString substringToIndex:16];
            return NO;
        }
        
    }
    
    return YES;
}

@end
