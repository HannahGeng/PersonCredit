//
//  OtherViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/9/24.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "OtherViewController.h"

#define SHARE_CONTENT_HEIGHT 250

@interface OtherViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_tableDataArray;
    UITableView *_tableView;
    UIView *_shareView;
    UIView *_contentView;
    UILabel *_buttonLabel;
}
@end

@implementation OtherViewController

//显示TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    //设置导航栏
    [self setNavigationBar];
    //加载tableView
    [self addTableView];
    
    [self loadData];//假数据
    
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"其他")
}
-(void)loadData{
    
    _tableDataArray=@[@{@"image":@"guanyuzhongding",@"title":@"关于中鼎"},
                      @{@"image":@"tuijianpy",@"title":@"推荐给朋友"},
                      @{@"image":@"fankui",@"title":@"用户反馈"},
                      @{@"image":@"shezhi",@"title":@"设置"}];
}

//加载tableView
- (void)addTableView {
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight]-64) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = YES;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
}
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Identifier";
    OtherViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[OtherViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    [cell setContentView:_tableDataArray[indexPath.row]];
    
    return cell;
}
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        AboutViewController *aboutVC=[[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if (indexPath.row==1) {
        
        _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIUtils getWindowWidth], [UIUtils getWindowHeight])];
        UITapGestureRecognizer *tapContentGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [_shareView addGestureRecognizer:tapContentGesture];
        
        [_shareView setBackgroundColor:LIGHT_OPAQUE_BLACK_COLOR];
        self.tabBarController.tabBar.hidden=YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_shareView];

        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIUtils getWindowHeight]-SHARE_CONTENT_HEIGHT, [UIUtils getWindowWidth], SHARE_CONTENT_HEIGHT)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_shareView addSubview:_contentView];
        
        //添加contentView底部视图
        UIImage *contentFootImage = [UIImage imageNamed:@"ShareMenuFooter_light"];
        UIImageView *contentFootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _contentView.frame.size.height-contentFootImage.size.height, _contentView.frame.size.width, contentFootImage.size.height)];
        [contentFootView setUserInteractionEnabled:YES];
        [contentFootView setImage:contentFootImage];
        [_contentView addSubview:contentFootView];

        //添加取消按钮
        UIImage *cancelButtonNormal = [UIImage imageNamed:@"ShareMenuCancel_light_normal"];
        UIImage *cancelButtonHighlight = [UIImage imageNamed:@"ShareMenuCancel_light_selected"];
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setFrame:CGRectMake(10, 10, contentFootView.frame.size.width-10-10, contentFootView.frame.size.height-10-10)];
        [cancelButton setBackgroundImage:[cancelButtonNormal stretchableImageWithLeftCapWidth:10 topCapHeight:0]forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[cancelButtonHighlight stretchableImageWithLeftCapWidth:10 topCapHeight:0]forState:UIControlStateHighlighted];
        [cancelButton addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [contentFootView addSubview:cancelButton];
        
        //初始化分享按钮
        [self addShareButtons];
    }
    if (indexPath.row==2) {
        FeedbackViewController *feedbackCarVC=[[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedbackCarVC animated:YES];
    }
    if (indexPath.row==3) {
        SetViewController *setCarVC=[[SetViewController alloc]init];
        [self.navigationController pushViewController:setCarVC animated:YES];
    }

}
//初始化分享按钮
- (void)addShareButtons
{
    NSArray *platforms = @[SOCIAL_SHARE_PLATFORM_WEIXIN,
                           SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,
                           SOCIAL_SHARE_PLATFORM_QQ,
                           SOCIAL_SHARE_PLATFORM_QQ_ZONE,
                           SOCIAL_SHARE_PLATFORM_EMAIL,
                           SOCIAL_SHARE_PLATFORM_SMS,
                           SOCIAL_SHARE_PLATFORM_COPY];
    for (int i=0; i<platforms.count; i++) {
        //初始化透明的背景视图backView用来确定分享按钮的中心点坐标
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10+i%4*([UIUtils getWindowWidth]-10*2)/4, 10+i/4*80, ([UIUtils getWindowWidth]-10*2)/4, 80)];
        [_contentView addSubview:backView];
        
        NSString *platform = platforms[i];
        //添加按钮
        UIButton *button = [self getShareButtonWithPlatform:platform];
        button.center = backView.center;
        [_contentView addSubview:button];
        //添加label
        UILabel *label = [self getShareLabelWithPlatform:platform];
        CGPoint labelCenter = CGPointMake(backView.center.x, backView.center.y+30);
        label.center = labelCenter;
        [_contentView addSubview:label];
    }
}
//获取对应平台的分享标签
- (UILabel *)getShareLabelWithPlatform:(NSString *)platform
{
    _buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [_buttonLabel setBackgroundColor:[UIColor clearColor]];
    [_buttonLabel setTextAlignment:NSTextAlignmentCenter];
    [_buttonLabel setFont:[UIFont systemFontOfSize:12]];
    if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_SINAWEIBO]) {
        [_buttonLabel setText:@"新浪微博"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_WEIXIN]) {
        [_buttonLabel setText:@"微信好友"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE]) {
        [_buttonLabel setText:@"朋友圈"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_QQ]) {
        [_buttonLabel setText:@"QQ"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_QQ_ZONE]) {
        [_buttonLabel setText:@"QQ空间"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_EMAIL]) {
        [_buttonLabel setText:@"邮件"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_SMS]) {
        [_buttonLabel setText:@"短信"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_COPY]) {
        [_buttonLabel setText:@"复制链接"];
    }
    return _buttonLabel;
}

//获取对应平台的分享按钮
- (UIButton *)getShareButtonWithPlatform:(NSString *)platform
{
    //获取相应图片
    UIImage *shareButtonImage;
    if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_SINAWEIBO]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_sinaweibo"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_WEIXIN]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_weixin"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_weixinTimeline"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_QQ]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_qqfriend"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_QQ_ZONE]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_qzone"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_EMAIL]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_email"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_SMS]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_sms"];
    } else if ([platform isEqualToString:SOCIAL_SHARE_PLATFORM_COPY]) {
        shareButtonImage = [UIImage imageNamed:@"SocialSharePlatformIcon_copy"];
    }
    
    //初始化按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:platform forState:UIControlStateNormal];
    [button.titleLabel setAlpha:0.0f];
    [button addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, shareButtonImage.size.width, shareButtonImage.size.height)];
    [button setBackgroundImage:shareButtonImage forState:UIControlStateNormal];
    return button;
}
- (void)shareButtonPress:(UIButton *)button
{
    NSLog(@"分享按钮被点击 %@",button.currentTitle);

}

- (void)removeView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [_shareView setFrame:CGRectMake(0, [UIUtils getWindowHeight], [UIUtils getWindowWidth], SHARE_CONTENT_HEIGHT)];
                     } completion:^(BOOL finished) {
                         self.tabBarController.tabBar.hidden=NO;
                         [_shareView removeFromSuperview];
                     }];
    
}

@end
