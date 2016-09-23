//
//  FeedbackViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/15.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "FeedbackViewController.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

@interface FeedbackViewController ()<UITextViewDelegate>
{
    MBProgressHUD * mbHud;
    UILabel *_placeholderLabel;
    int a;
    unichar c;
}

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIButton *presentButton;
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;

@end

@implementation FeedbackViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    [UILabel appearance].font = [UILabel changeFont];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    
    //设置导航栏
    [self setNavigationBar];
    
    [_writeTextView becomeFirstResponder];
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"用户反馈");
    
    //为导航栏添加左侧按钮
    leftButton;

}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

//键盘退下事件的处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)presentButton:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    AppShare;
    
    if (self.writeTextView.text.length == 0) {
        
        MBhud(@"内容不能为空");
        
    }else{
        
        for(int i=0; i< self.writeTextView.text.length;i++){
            
            a = [self.writeTextView.text characterAtIndex:i];
            c = [self.writeTextView.text characterAtIndex:i];
        }
        
        if((!(a > 0x4e00 && a < 0x9fff)) && ((c<'A'||c>'Z')&&(c<'a'||c>'z')) && (a)){
            
            MBhud(@"请输入文字");
            
        }else{
            
            AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
            
            [mgr startMonitoring];
            
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status != 0) {
                    
                    NSDictionary * pdic = [[NSDictionary alloc]initWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",[AESCrypt encrypt:self.writeTextView.text password:app.loginKeycode],@"tickling",nil];
                    
                    [[HTTPSessionManager sharedManager] POST:FANKUI_URL parameters:pdic  result:^(id responseObject, NSError *error) {
                        
                        if ([responseObject[@"status"] integerValue] == 1) {
                            
                            app.request = responseObject[@"response"];
                            
                            MBhud(responseObject[@"result"]);
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [self.navigationController popToRootViewControllerAnimated:YES];
                            });
                            
                        }else{
                            
                            MBhud(@"请求错误");
                        }
                        
                    }];
                    
                }else
                {
                    noWebhud;
                }
                
            }];

        }
        
    }
    
}

#pragma mark UITextViewDelegation
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length > 0) {
        
        self.alertLabel.hidden = YES;
        
    }else{
        
        self.alertLabel.hidden = NO;
    }
}

@end
