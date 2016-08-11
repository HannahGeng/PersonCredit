//
//  AboutViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UITextView *aboutText;
@property (weak, nonatomic) IBOutlet UIScrollView *aboutScrollView;

@end

@implementation AboutViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NavBarType(@"关于我们")
    leftButton;
    
    //设置scrollView
    self.aboutScrollView.showsHorizontalScrollIndicator = NO;
    self.aboutScrollView.showsVerticalScrollIndicator = NO;
    self.aboutScrollView.contentSize = CGSizeMake(0, 1000);
    self.aboutScrollView.contentOffset = CGPointMake(0, 0);

}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)webClick {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.newqc.cn"]];
}

- (IBAction)phoneClick {

    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel://40000060806"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

@end
