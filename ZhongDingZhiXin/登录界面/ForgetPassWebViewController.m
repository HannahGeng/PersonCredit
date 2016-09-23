//
//  ForgetPassWebViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/8/29.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "ForgetPassWebViewController.h"

@interface ForgetPassWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ForgetPassWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [UILabel appearance].font = [UILabel changeFont];

    NSURL * url = [NSURL URLWithString:@"http://www.newqc.cn/public/getpwd"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
    
    NavBarType(@"忘记密码");
    leftButton;

}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
