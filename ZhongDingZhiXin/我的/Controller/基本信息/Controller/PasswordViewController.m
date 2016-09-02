//
//  PasswordViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/19.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()
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
    
    if (self.oldPasswordText.text.length == 0 || self.newpasswordText.text.length == 0 || self.twopasswordText.text.length == 0) {
        
        MBhud(@"信息不完善");
        
    }else if (![self.newpasswordText.text isEqualToString:self.twopasswordText.text]){
        
        MBhud(@"两次密码输入不一致");
        
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
                            
                            [self.navigationController popToRootViewControllerAnimated:YES];
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

@end
