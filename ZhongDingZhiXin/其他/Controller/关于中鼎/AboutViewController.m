//
//  AboutViewController.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/27.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

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
    
}

- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
