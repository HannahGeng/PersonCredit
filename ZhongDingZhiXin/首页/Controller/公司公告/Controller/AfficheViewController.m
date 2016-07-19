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
@property (weak, nonatomic) IBOutlet UITextView *textView;

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

    HomeViewController * home = [[HomeViewController alloc] init];
    QuestionViewController * ques = [[QuestionViewController alloc] init];
    PunishmentViewController * punish = [[PunishmentViewController alloc] init];
    RewardViewController * reward = [[RewardViewController alloc] init];
    NoticeViewController * notice = [[NoticeViewController alloc] init];
    
    NSArray * vcArray = [self.navigationController viewControllers];
    NSInteger vcCount = vcArray.count;
    UIViewController * lastVc = vcArray[vcCount - 2];
    
    if ([lastVc isKindOfClass:[home class]] || [lastVc isKindOfClass:[notice class]]){
        
        //标题
        NSString *strTitle=[AESCrypt decrypt:self.noticeInfo.title password:app.loginKeycode];
        _titleLabel.text=strTitle;
        
        //内容
        NSString *strContent=[AESCrypt decrypt:self.noticeInfo.content password:app.loginKeycode];
        _textView.text=[self filterHtmlTag:strContent];
        
        //时间
        NSString * str = [NSString new];
        timeCover;
        _timeLabel.text = currentDateStr;
        
    }else if ([lastVc isKindOfClass:[ques class]]){
        
        //标题
        NSString *strTitle=[AESCrypt decrypt:app.questionArray[app.index][@"title"] password:app.loginKeycode];
        _titleLabel.text=strTitle;
                
        //内容
        NSString *strContent=[AESCrypt decrypt:app.questionArray[app.index][@"content"] password:app.loginKeycode];
        _textView.text=[self filterHtmlTag:strContent];
        
        //时间
        NSString * str = [AESCrypt decrypt:app.questionArray[app.index][@"pubtime"] password:app.loginKeycode];
        
        timeCover;
        self.timeLabel.text = currentDateStr;
        
    }else if ([lastVc isKindOfClass:[punish class]]){
     
        //标题
        NSString *strTitle=[AESCrypt decrypt:app.punishArray[app.index][@"topic"] password:app.loginKeycode];
        _titleLabel.text=strTitle;
        
        //内容
        NSString *strContent=[AESCrypt decrypt:app.punishArray[app.index][@"description"] password:app.loginKeycode];
        _textView.text=[self filterHtmlTag:strContent];
        
        //时间
        NSString * str = [AESCrypt decrypt:app.punishArray[app.index][@"realname"] password:app.loginKeycode];
        
        self.timeLabel.text = str;

    }else if([lastVc isKindOfClass:[reward class]]){
        
        //标题
        NSString *strTitle=[AESCrypt decrypt:app.rewardArray[app.index][@"topic"] password:app.loginKeycode];
        _titleLabel.text=strTitle;
        
        //内容
        NSString *strContent=[AESCrypt decrypt:app.rewardArray[app.index][@"description"] password:app.loginKeycode];
        _textView.text = [self filterHtmlTag: strContent];
        
        //时间
        NSString * str = [AESCrypt decrypt:app.rewardArray[app.index][@"realname"] password:app.loginKeycode];
        
        self.timeLabel.text = str;

    }
    
}

- (NSString *)filterHtmlTag:(NSString *)originHtmlStr{
    
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
       
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];

        return [self filterHtmlTag:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
    }
    return result;
}
@end
