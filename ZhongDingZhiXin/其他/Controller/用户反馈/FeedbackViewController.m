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
}

@property (weak, nonatomic) IBOutlet UIButton *presentButton;
@property (weak, nonatomic) IBOutlet UITextView *writeTextView;

@end

@implementation FeedbackViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *string=APP_Font;
    _presentButton.titleLabel.font=[UIFont systemFontOfSize:17*[string floatValue]];
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    
    UILabel * alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.writeTextView.frame.size.width, 60)];
    
    alertLabel.backgroundColor = [UIColor greenColor];
    
    alertLabel.numberOfLines = 0;
    
    alertLabel.text = @"请描述您遇到的问题或想提供的建议，我们将尽快回复，如果没有联系方式，请留下联系方式！";
    
    [self.writeTextView addSubview:alertLabel];
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
    
    AppShare;
    
    if (self.writeTextView.text.length == 0 || [self.writeTextView.text containsString:@" "]) {
        
        MBhud(@"内容为空或格式错误");
        
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
                        
                    }else{
                        
                        MBhud(@"请求错误")
                    }
                    
                }];
                
            }else
            {
                noWebhud;
            }
            
        }];
        
    }
    
}

#pragma mark UITextViewDelegation
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

@end
