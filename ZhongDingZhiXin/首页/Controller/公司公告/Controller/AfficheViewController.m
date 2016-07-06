//
//  AfficheViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/23.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "AfficheViewController.h"

@interface AfficheViewController ()
{
    NSString *_pwd;
    UILabel *_titleLabel;
    UITextView *_textView;
    UILabel *_timeLabel;
}
@end

@implementation AfficheViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *string=APP_Font;
    _titleLabel.font=[UIFont systemFontOfSize:16*[string floatValue]];
    _textView.font=[UIFont systemFontOfSize:15*[string floatValue]];
    _timeLabel.font=[UIFont systemFontOfSize:15*[string floatValue]];
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    // 添加内容视图
    [self addContentView];
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"公司公告");
    //为导航栏添加左侧按钮
    leftButton;

}
-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)remindButton
{
    NSLog(@"remindButton");
}

// 添加内容视图
-(void)addContentView
{
    AppShare;
    NSString *str=APP_Font;
    if (!str){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    NSString *strTitle=[AESCrypt decrypt:self.noticeInfo.title password:app.loginKeycode];
    
    NSLog(@"\n%@",strTitle);
    
    NSString *strContent=[AESCrypt decrypt:self.noticeInfo.content password:app.loginKeycode];
    NSString *strMark=[AESCrypt decrypt:self.noticeInfo.mark password:app.loginKeycode];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, 70, 200, 30)];
    _titleLabel.font=[UIFont systemFontOfSize:16];
    _titleLabel.text=strTitle;
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+10, [UIUtils getWindowWidth], 0)];
    _textView.text=strContent;
    _textView.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:_textView];
    _textView.frame=CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+10, [UIUtils getWindowWidth]-20,_textView.contentSize.height);
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-130, CGRectGetMaxY(_textView.frame)+10, 120, 30)];
    _timeLabel.font=[UIFont systemFontOfSize:15];
    _timeLabel.text=strMark;
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_timeLabel];
}

@end
