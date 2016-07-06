//
//  AboutViewController.m
//  ZhongDingZhiXin
//
//  Created by zdzx-008 on 15/10/14.
//  Copyright (c) 2015年 张豪. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
    UIImageView *_imageView4;
    UILabel *_fontLabel1;
    UILabel *_fontLabel2;
    UILabel *_fontLabel3;
    UILabel *_fontLabel4;
}

@end

@implementation AboutViewController

//隐藏TabBar
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *string=APP_Font;
    _fontLabel1.font=[UIFont systemFontOfSize:17*[string floatValue]];
    _fontLabel2.font=[UIFont systemFontOfSize:17*[string floatValue]];
    _fontLabel3.font=[UIFont systemFontOfSize:17*[string floatValue]];
    _fontLabel4.font=[UIFont systemFontOfSize:17*[string floatValue]];
    
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]]];
    //设置导航栏
    [self setNavigationBar];
    //添加视图
    [self addContentView];
}
//设置导航栏
-(void)setNavigationBar
{
    //设置导航栏的颜色
    NavBarType(@"关于中鼎");
    
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
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.scrollEnabled = NO;
    _tableView.sectionFooterHeight=1;
    [self.view addSubview:_tableView];
    
    _imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    _imageView1.layer.cornerRadius=5;//设置圆角
    _imageView1.image=[UIImage imageNamed:@"logo.png"];
    [_tableView addSubview:_imageView1];
    
    _imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 95, 20, 20)];
    _imageView2.image=[UIImage imageNamed:@"wangzhan.png"];
    [_tableView addSubview:_imageView2];
    
    _imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(20, 145, 20, 20)];
    _imageView3.image=[UIImage imageNamed:@"dianhua.png"];
    [_tableView addSubview:_imageView3];
    
    _imageView4=[[UIImageView alloc]initWithFrame:CGRectMake(20, 205, 20, 20)];
    _imageView4.image=[UIImage imageNamed:@"huanyingye.png"];
    [_tableView addSubview:_imageView4];
    
    _fontLabel1=[[UILabel alloc]initWithFrame:CGRectMake(60, 25, 200, 30)];
    _fontLabel1.text=@"中鼎职信";
    _fontLabel1.textColor=PASS_COLOR;
    _fontLabel1.font=[UIFont systemFontOfSize:17];
    [_tableView addSubview:_fontLabel1];
    
    _fontLabel2=[[UILabel alloc]initWithFrame:CGRectMake(60, 90, 220, 30)];
    _fontLabel2.text=@"www.4000520856.com";
    _fontLabel2.textColor=PASS_COLOR;
    _fontLabel2.font=[UIFont systemFontOfSize:17];
    [_tableView addSubview:_fontLabel2];
    
    _fontLabel3=[[UILabel alloc]initWithFrame:CGRectMake(60, 140, 150, 30)];
    _fontLabel3.text=@"4000-520-856";
    _fontLabel3.textColor=PASS_COLOR;
    _fontLabel3.font=[UIFont systemFontOfSize:17];
    [_tableView addSubview:_fontLabel3];
    
    _fontLabel4=[[UILabel alloc]initWithFrame:CGRectMake(60, 200, 100, 30)];
    _fontLabel4.text=@"欢迎页";
    _fontLabel4.font=[UIFont systemFontOfSize:17];
    [_tableView addSubview:_fontLabel4];
}
-(void)cancelButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
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
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }else{
        return 50;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.4000520856.com"]];
        }
        if (indexPath.row==1) {
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:@"tel://4000520856"];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            //记得添加到view上
            [self.view addSubview:callWebview];
        }
    }
    
    if (indexPath.section==2) {
        
        PageViewController *pageVC=[[PageViewController alloc]initWithNibName:@"PageViewController" bundle:nil];
        //隐藏tabBar
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:pageVC animated:YES];
    }
}

@end
