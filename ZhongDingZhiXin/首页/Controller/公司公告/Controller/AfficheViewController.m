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
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textView;

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
    NSString *strr=APP_Font;
    if (!strr){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    NSString *strTitle=[AESCrypt decrypt:self.noticeInfo.title password:app.loginKeycode];
    
    NSString *strMark=[AESCrypt decrypt:self.noticeInfo.mark password:app.loginKeycode];

    _titleLabel.text=strTitle;
    
    NSString *topic=[AESCrypt decrypt:self.noticeInfo.topic password:app.loginKeycode];

    _titleLabel.text = topic;

    NSString *strContent=[AESCrypt decrypt:self.noticeInfo.content password:app.loginKeycode];

    _textView.text=strContent;
    
    NSString *des=[AESCrypt decrypt:self.noticeInfo.descrip password:app.loginKeycode];
    _textView.text = des;
    
    NSString * str = strMark;
    timeCover;
    
    _timeLabel.text = currentDateStr;
}

@end
