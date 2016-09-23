//
//  SetViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/15.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    UILabel *_titleLable1;
    UILabel *_titleLable2;
    UILabel *_titleLable3;
    UILabel *_titleLable4;
    UILabel *_titleLable5;
    UILabel *_titleLable6;
    UILabel *_titleLable7;
    UILabel *_titleLable8;
    UIButton *_btn1;
    UIButton *_btn2;
    UIButton *_btn3;
    
    NSString *_string;
    NSString * curVersion;
    NSString * systype;
    MBProgressHUD * mbHud;
}

@end

@implementation SetViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    [UILabel appearance].font = [UILabel changeFont];
    
    [self setHidesBottomBarWhenPushed:NO];
    self.tabBarController.tabBar.hidden=YES;
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]]];
    
    //设置导航栏
    [self setNavigationBar];
    
    //添加内容视图
    [self addContentView];
    
}

//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"设置");
    
    //为导航栏添加左侧按钮
    leftButton;
}

-(void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

//添加内容视图
-(void)addContentView
{
    _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = NO;
    _tableView.sectionFooterHeight=1;
    [self.view addSubview:_tableView];
    
    _titleLable1=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 150, 30)];
    _titleLable1.text=@"字号设置";
    [self.view addSubview:_titleLable1];
    
    _titleLable2=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 150, 30)];
    _titleLable2.text=@"常见问题";
    [self.view addSubview:_titleLable2];
    
    _titleLable3=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, 300, 30)];
    _titleLable3.text=@"亲 去App Store给个好评吧";
    [self.view addSubview:_titleLable3];
    
    _titleLable4=[[UILabel alloc]initWithFrame:CGRectMake(20, 190, 150, 30)];
    _titleLable4.text=@"检测更新";
    [self.view addSubview:_titleLable4];
    
    _titleLable5=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2 + 50, 250, 200, 30)];
    _titleLable5.text=@"退出当前账号";
    [self.view addSubview:_titleLable5];
    
}

-(void)cancelButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
    }else if (section==2){
        return 1;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.section==0) {
            
            //设置cell不可选择
            UIImage *image2=[UIImage imageNamed:@"ziti-5"];
            _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn2.frame = CGRectMake([UIUtils getWindowWidth]-70, 10, 30, 30);
            [_btn2 setTitle:@"小" forState:UIControlStateNormal];
            //点击事件（变小）
            [_btn2 addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_btn2];
            _string=APP_Font;
            [_btn2.titleLabel setFont:[UIFont systemFontOfSize:15*[_string floatValue]]];
            [_btn2 setSelected:YES];
            [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_btn2 setBackgroundImage:image2 forState:UIControlStateSelected];
            [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            UIImage *image3=[UIImage imageNamed:@"ziti-5"];
            _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn3.frame = CGRectMake([UIUtils getWindowWidth]-40, 10, 30, 30);
            [_btn3 setTitle:@"大" forState:UIControlStateNormal];
            //点击事件（变大）
            [_btn3 addTarget:self action:@selector(onClick2) forControlEvents:UIControlEventTouchUpInside];
            _string = APP_Font;
            [_btn3.titleLabel setFont:[UIFont systemFontOfSize:15*[_string floatValue]]];
            [_btn3 setBackgroundImage:image3 forState:UIControlStateSelected];
            [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell addSubview:_btn3];
            
        }
        
        if (indexPath.section==1){
            if (indexPath.row==1) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
        }else if (indexPath.section==2){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }
    return cell;
}

//字体变小
-(void)onClick1
{
    _string = APP_Font;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
    _btn2.selected=YES;
    _btn3.selected=NO;
    
    [UILabel appearance].font = [UILabel changeFont];
}

//字体变大
-(void)onClick2
{
    _string = APP_Font;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1.3" forKey:@"change_font"];
    _btn2.selected=NO;
    _btn3.selected=YES;
    
    [UILabel appearance].font = [UILabel changeFont];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        
        if (indexPath.row == 0) {
            
            AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
            [mgr startMonitoring];
            
            [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                
                if (status != 0) {
                    
                    QuestionViewController * ques = [[QuestionViewController alloc] init];
                    [self.navigationController pushViewController:ques animated:YES];
                    
                }else
                {
                    noWebhud;
                }
                
            }];
        
        }else if (indexPath.row==1) {
            NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",490062954];//490062954是程序的Apple ID,可以在iTunes Connect中查到。
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
    
    if (indexPath.section == 2) {
        
        AppShare;
        
        mbHUDinit;
        
        //获取用户最新的版本号:info.plist
        curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        systype = @"1";
        
        NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:app.uid,@"uid",app.request,@"request",systype,@"systype",curVersion,@"version", nil];
        
        AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr startMonitoring];
        
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if (status != 0) {
                
                [[HTTPSessionManager sharedManager]POST:CHECK_URL parameters:pdic result:^(id responseObject, NSError *error) {
                    
                    NSLog(@"版本信息:%@",responseObject);
                    
                    app.request = responseObject[@"response"];
                    
                    [self update];
                }];

                
            }else
            {
                noWebhud;
            }
            
        }];

    }
    if (indexPath.section==3) {
        
        UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，你确定要退出吗？？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];

    }
}

- (void)update
{
    NSDictionary * pdic = [NSDictionary dictionaryWithObjectsAndKeys:curVersion,@"version",systype,@"systype", nil];
    
    AFNetworkReachabilityManager * mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status != 0) {
            
            [[HTTPSessionManager sharedManager] POST:UPDATE_URL parameters:pdic result:^(id responseObject, NSError *error) {
                
                hudHide;

                NSLog(@"强制更新:%@",responseObject);

                if ([responseObject[@"status"] integerValue] == 1) {
                
                    if ([responseObject[@"result"][@"flag"] integerValue] == 1) {
                        
                        MBhud(@"已是最新版本");
                    }else
                    {
                        MBhud(@"你有新的版本");
                    }
                }
            }];
            
        }else
        {
            noWebhud;
        }
        
    }];
    
}

//监听点击事件 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];

    if ([btnTitle isEqualToString:@"确定"]) {

        LoginViewController *loginView=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pass"];
        
        [self.navigationController pushViewController:loginView animated:NO];
        
    }else if ([btnTitle isEqualToString:@"取消"] ) {

        [alertView removeFromSuperview];

    }
}

@end
