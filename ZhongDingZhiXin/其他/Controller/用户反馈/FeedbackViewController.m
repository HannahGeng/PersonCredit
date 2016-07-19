//
//  FeedbackViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/15.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>

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
    
    NSDictionary * pdic = [[NSDictionary alloc]initWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",[AESCrypt decrypt:self.writeTextView.text password:app.loginKeycode],@"tickling",nil];
    
    [[HTTPSessionManager sharedManager] POST:FANKUI_URL parameters:pdic  result:^(id responseObject, NSError *error) {
        
        NSLog(@"%@",responseObject);
    }];
}

#pragma mark UITextViewDelegation
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    return YES;
}

@end
