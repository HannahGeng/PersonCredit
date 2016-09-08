//
//  LoginViewController.h
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *headImageView;
@property (strong, nonatomic) IBOutlet UIView *passImageView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UIView *phoneInageView;
@property (weak, nonatomic) IBOutlet UITextField *userPass;

@end
