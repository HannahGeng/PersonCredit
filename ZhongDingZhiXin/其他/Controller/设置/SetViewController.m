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
    
}
@end

@implementation SetViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    _string=APP_Font;
    _titleLable1.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable2.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable3.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable4.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable5.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable6.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable7.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _titleLable8.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _btn1.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
    _btn2.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];

    self.tabBarController.tabBar.hidden=YES;
    
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
    NSString *str=APP_Font;
    if (!str){
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = NO;
    _tableView.sectionFooterHeight=1;
    [self.view addSubview:_tableView];
    
    _titleLable1=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 150, 30)];
    _titleLable1.text=@"字号设置";
    _titleLable1.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable1];
    
    _titleLable2=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 150, 30)];
    _titleLable2.text=@"清除缓存";
    _titleLable2.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable2];
    
    _titleLable3=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, 150, 30)];
    _titleLable3.text=@"推送设置";
    _titleLable3.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable3];
    
    _titleLable4=[[UILabel alloc]initWithFrame:CGRectMake(20, 190, 150, 30)];
    _titleLable4.text=@"常见问题";
    _titleLable4.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable4];
    
    _titleLable5=[[UILabel alloc]initWithFrame:CGRectMake(20, 240, 300, 30)];
    _titleLable5.text=@"亲 去App Store给个好评吧！";
    _titleLable5.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable5];
    
    _titleLable6=[[UILabel alloc]initWithFrame:CGRectMake(20, 290, 150, 30)];
    _titleLable6.text=@"检测更新";
    _titleLable6.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable6];
    
    _titleLable7=[[UILabel alloc]initWithFrame:CGRectMake([UIUtils getWindowWidth]-55, 80, 50, 30)];
    _titleLable7.text=@"1.6M";
    _titleLable7.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLable7];

    _titleLable8=[[UILabel alloc]initWithFrame:CGRectMake(([UIUtils getWindowWidth]-200)/2, 355, 200, 30)];
    _titleLable8.text=@"退出当前账号";
    _titleLable8.font=[UIFont systemFontOfSize:17];
    _titleLable8.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLable8];
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
        return 3;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.section==0) {
            //设置cell不可选择
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImage *image1=[UIImage imageNamed:@"ziti-5"];
            _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn1.frame = CGRectMake([UIUtils getWindowWidth]-100, 10, 30, 30);
            [_btn1 setTitle:@"小" forState:UIControlStateNormal];
            
            _string=APP_Font;
            _btn1.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
            
            [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_btn1 setBackgroundImage:image1 forState:UIControlStateSelected];
            [_btn1 addTarget:self action:@selector(onClick0) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_btn1];

            UIImage *image2=[UIImage imageNamed:@"ziti-5"];
            _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn2.frame = CGRectMake([UIUtils getWindowWidth]-70, 10, 30, 30);
            [_btn2 setTitle:@"中" forState:UIControlStateNormal];
        
            _string=APP_Font;
            _btn2.titleLabel.font=[UIFont systemFontOfSize:17*[_string floatValue]];
            
            [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_btn2 setBackgroundImage:image2 forState:UIControlStateSelected];
            [_btn2 addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_btn2];
            
            UIImage *image3=[UIImage imageNamed:@"ziti-5"];
            _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn3.frame = CGRectMake([UIUtils getWindowWidth]-40, 10, 30, 30);
            [_btn3 setTitle:@"大" forState:UIControlStateNormal];
            
            NSString *string3=APP_Font;
            _btn3.titleLabel.font=[UIFont systemFontOfSize:17*[string3 floatValue]];
           
            [_btn3 setBackgroundImage:image3 forState:UIControlStateSelected];
            [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_btn3 addTarget:self action:@selector(onClick2) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_btn3];
            
        }
        
        if (indexPath.section==1){
            if (indexPath.row==1) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            }
        }else if (indexPath.section==2){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        
    }
    return cell;
}


-(void)onClick0
{
    NSLog(@"小");
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"change_font"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _btn1.selected=YES;
    _btn2.selected=NO;
    _btn3.selected=NO;
    
}
-(void)onClick1
{
    NSLog(@"中");
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1.11" forKey:@"change_font"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _btn1.selected=NO;
    _btn2.selected=YES;
    _btn3.selected=NO;
}
-(void)onClick2
{
    NSLog(@"大");
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1.23" forKey:@"change_font"];
    
    _btn1.selected=NO;
    _btn2.selected=NO;
    _btn3.selected=YES;
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
    if (indexPath.section==2) {
        if (indexPath.row==1) {
            NSString *url = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",490062954];//490062954是程序的Apple ID,可以在iTunes Connect中查到。
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }
    if (indexPath.section==3) {
        
        UIAlertView* alter=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，你确定要退出吗？？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];

    }
}

//监听点击事件 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];

    if ([btnTitle isEqualToString:@"确定"]) {

        LoginViewController *loginView=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginView animated:NO];
        
    }else if ([btnTitle isEqualToString:@"取消"] ) {

        [alertView removeFromSuperview];

    }
}

@end
